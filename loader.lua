-- Word Bank DogeVoid Loader (Hub)

local URL = "https://raw.githubusercontent.com/bro-pixel11/WordBank-DogeVoid/main/script.lua"

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "WordBankHub"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 140)
frame.Position = UDim2.new(0.5, -110, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Word Bank Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0.8, 0, 0, 40)
button.Position = UDim2.new(0.1, 0, 0.5, 0)
button.Text = "Load Script"
button.Parent = frame

-- LOAD FUNCTION
button.MouseButton1Click:Connect(function()
    local ok, res = pcall(function()
        return game:HttpGet(URL)
    end)

    if not ok or not res then
        button.Text = "Failed"
        return
    end

    local func = loadstring(res)

    if func then
        button.Text = "Loaded"
        task.wait(0.3)
        func()
    else
        button.Text = "Error"
    end
end)