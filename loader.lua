local URL = "https://raw.githubusercontent.com/bro-pixel11/WordBank-DogeVoid/main/script.lua"

--// UI
local gui = Instance.new("ScreenGui")
gui.Name = "WordBankHub"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 150)
frame.Position = UDim2.new(0.5, -130, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(90, 120, 255)
stroke.Thickness = 1.5
stroke.Parent = frame

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Word Bank Hub"
title.TextColor3 = Color3.fromRGB(235, 235, 235)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame

-- SUBTITLE / STATUS
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 20)
status.Position = UDim2.new(0, 0, 0.25, 0)
status.BackgroundTransparency = 1
status.Text = "Ready"
status.TextColor3 = Color3.fromRGB(150, 150, 150)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.Parent = frame

-- BUTTON
local button = Instance.new("TextButton")
button.Size = UDim2.new(0.85, 0, 0, 38)
button.Position = UDim2.new(0.075, 0, 0.6, 0)
button.BackgroundColor3 = Color3.fromRGB(90, 120, 255)
button.Text = "Load Script"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 14
button.BorderSizePixel = 0
button.Parent = frame

Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

-- CLOSE BUTTON
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 22, 0, 22)
close.Position = UDim2.new(1, -28, 0, 6)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.Font = Enum.Font.GothamBold
close.TextSize = 12
close.Parent = frame

Instance.new("UICorner", close).CornerRadius = UDim.new(1, 0)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

--// DRAG SYSTEM
local UIS = game:GetService("UserInputService")

local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

--// LOAD SCRIPT
button.MouseButton1Click:Connect(function()
    status.Text = "Loading..."

    local ok, res = pcall(function()
        return game:HttpGet(URL)
    end)

    if not ok or not res then
        status.Text = "HTTP ERROR"
        return
    end

    local func = loadstring(res)

    if not func then
        status.Text = "LOAD ERROR"
        return
    end

    status.Text = "Running..."

    task.wait(0.2)
    pcall(func)

    status.Text = "Loaded ✔"
end)