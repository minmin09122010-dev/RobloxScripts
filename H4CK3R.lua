--!strict
local success, Aiming = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Aiming/main/Examples/AimLock.lua"))()
end)

if not success or not Aiming then
    warn("Failed to load Aiming library!")
    return
end

local AimingChecks = Aiming.Checks
local AimingSelected = Aiming.Selected
local AimLockSettings = Aiming.AimLock

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("H4CK3R_Loading") then
    playerGui.H4CK3R_Loading:Destroy()
end
if playerGui:FindFirstChild("H4CK3R_MobileUI") then
    playerGui.H4CK3R_MobileUI:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "H4CK3R_Loading"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = playerGui

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
status.Text = "LOADING CORE..."
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
    task.wait(0.015)
end

status.Text = "SYSTEM READY"
task.wait(0.5)

local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local t1 = TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 1})
local t2 = TweenService:Create(title, tweenInfo, {TextTransparency = 1})
local t3 = TweenService:Create(status, tweenInfo, {TextTransparency = 1})
local t4 = TweenService:Create(bar, tweenInfo, {BackgroundTransparency = 1})
local t5 = TweenService:Create(fill, tweenInfo, {BackgroundTransparency = 1})

t1:Play() t2:Play() t3:Play() t4:Play() t5:Play()
t1.Completed:Wait()
gui:Destroy()

local DaHoodSettings = {
    Prediction = 0.165,
    SilentAim = true,
    AimLock = AimLockSettings,
    BeizerLock = {
        Smoothness = 0.05,
        CurvePoints = {
            Vector2.new(0.83, 0),
            Vector2.new(0.17, 1)
        }
    }
}
getgenv().DaHoodSettings = DaHoodSettings

function DaHoodSettings.ApplyPredictionFormula(SelectedPart, Velocity)
    return SelectedPart.CFrame + (Velocity * DaHoodSettings.Prediction)
end

local mobileGui = Instance.new("ScreenGui")
mobileGui.Name = "H4CK3R_MobileUI"
mobileGui.ResetOnSpawn = false
mobileGui.Parent = playerGui

local camButton = Instance.new("TextButton")
camButton.Size = UDim2.new(0, 130, 0, 45)
camButton.Position = UDim2.new(0.8, -65, 0.25, 0)
camButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
camButton.BorderColor3 = Color3.fromRGB(255, 35, 55)
camButton.BorderSizePixel = 2
camButton.Text = "H4CK3R: OFF"
camButton.TextColor3 = Color3.fromRGB(255, 35, 55)
camButton.TextSize = 13
camButton.Font = Enum.Font.GothamBold
camButton.Parent = mobileGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = camButton

local isAimlocking = false

camButton.MouseButton1Click:Connect(function()
    isAimlocking = not isAimlocking
    if isAimlocking then
        camButton.Text = "H4CK3R: ON"
        camButton.TextColor3 = Color3.fromRGB(0, 255, 100)
        camButton.BorderColor3 = Color3.fromRGB(0, 255, 100)
    else
        camButton.Text = "H4CK3R: OFF"
        camButton.TextColor3 = Color3.fromRGB(255, 35, 55)
        camButton.BorderColor3 = Color3.fromRGB(255, 35, 55)
    end
end)

RunService.RenderStepped:Connect(function()
    if isAimlocking and AimingChecks.IsAvailable() then
        local targetPart = AimingSelected.Part
        if targetPart and targetPart.Parent then
            local currentCamera = workspace.CurrentCamera
            local hit = DaHoodSettings.ApplyPredictionFormula(targetPart, AimingSelected.Velocity * Vector3.new(1, 0.1, 1))
            currentCamera.CFrame = CFrame.new(currentCamera.CFrame.Position, hit.Position)
        end
    end
end)

print("H4CK3R Aimlock Loaded Successfully!")
