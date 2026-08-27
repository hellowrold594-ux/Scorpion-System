--[[
    SCORPION SYSTEM
    Personal Roblox Game Script
    Version: 1.0
]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ScorpionSystem"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main window
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 420, 0, 300)
main.Position = UDim2.new(0.5, -210, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = main

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 55)
title.BackgroundTransparency = 1
title.Text = "🦂 SCORPION SYSTEM"
title.TextColor3 = Color3.fromRGB(255, 170, 60)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.Parent = main

-- Status
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 35)
status.Position = UDim2.new(0, 15, 0, 65)
status.BackgroundTransparency = 1
status.Text = "System loaded successfully"
status.TextColor3 = Color3.fromRGB(180, 180, 190)
status.TextSize = 15
status.Font = Enum.Font.Gotham
status.Parent = main

-- Button creator
local function createButton(text, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 180, 0, 45)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(240, 240, 240)
    button.TextSize = 15
    button.Font = Enum.Font.GothamSemibold
    button.Parent = main

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = button

    return button
end

-- Buttons
local infoButton = createButton(
    "Player Info",
    UDim2.new(0, 20, 0, 120)
)

local respawnButton = createButton(
    "Respawn",
    UDim2.new(0, 220, 0, 120)
)

local hideButton = createButton(
    "Hide GUI",
    UDim2.new(0, 20, 0, 180)
)

local closeButton = createButton(
    "Close",
    UDim2.new(0, 220, 0, 180)
)

-- Player Info
infoButton.MouseButton1Click:Connect(function()
    status.Text = "Player: " .. player.Name
end)

-- Respawn
respawnButton.MouseButton1Click:Connect(function()
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid.Health = 0
            status.Text = "Respawning..."
        end
    end
end)

-- Hide
hideButton.MouseButton1Click:Connect(function()
    main.Visible = false
end)

-- Close
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("Scorpion System loaded!")
