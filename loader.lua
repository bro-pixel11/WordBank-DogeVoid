-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "WordBankHub"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 150)
frame.Position = UDim2.new(0.5, -130, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
frame.BorderSizePixel = 0
frame.Parent = gui

-- rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- stroke (рамка)
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

-- SUBTITLE
local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.new(0, 0, 0.25, 0)
sub.BackgroundTransparency = 1
sub.Text = "ready to load script"
sub.TextColor3 = Color3.fromRGB(150, 150, 150)
sub.Font = Enum.Font.Gotham
sub.TextSize = 12
sub.Parent = frame

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

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = button