
--!strict
-- H4CK3R Loading Screen

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "H4CK3R_Loading"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromScale(1, 1)
frame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.Position = UDim2.fromScale(0, 0.35)
title.BackgroundTransparency = 1
title.Text = "H4CK3R"
title.TextColor3 = Color3.fromRGB(255, 35, 55)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 35)
status.Position = UDim2.fromScale(0, 0.47)
status.BackgroundTransparency = 1
status.Text = "INITIALIZING CAMLOCK..."
status.TextColor3 = Color3.fromRGB(220, 220, 220)
status.TextScaled = true
status.Font = Enum.Font.Code
status.Parent = frame

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0.65, 0, 0, 8)
bar.Position = UDim2.fromScale(0.175, 0.57)
bar.BackgroundColor3 = Color3.fromRGB(45, 15, 20)
bar.BorderSizePixel = 0
bar.Parent = frame

local fill = Instance.new("Frame")
fill.Size = UDim2.fromScale(0, 1)
fill.BackgroundColor3 = Color3.fromRGB(255, 35, 55)
fill.BorderSizePixel = 0
fill.Parent = bar

for progress = 1, 100 do
    fill.Size = UDim2.fromScale(progress / 100, 1)
    status.Text = "LOADING SYSTEM... " .. progress .. "%"
    task.wait(0.025)
end

status.Text = "H4CK3R SYSTEM READY"

task.wait(0.8)

local tween = TweenService:Create(
    frame,
    TweenInfo.new(0.6),
    {BackgroundTransparency = 1}
)

tween:Play()
tween.Completed:Wait()
gui:Destroy()
