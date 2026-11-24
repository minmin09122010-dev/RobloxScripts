--!strict
-- H4CK3R Loading Screen

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tránh bị trùng lặp nếu load lại script nhiều lần
if playerGui:FindFirstChild("H4CK3R_Loading") then
    playerGui.H4CK3R_Loading:Destroy()
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

-- Chạy thanh loading
for progress = 1, 100 do
    fill.Size = UDim2.fromScale(progress / 100, 1)
    status.Text = "LOADING SYSTEM... " .. progress .. "%"
    task.wait(0.025)
end

status.Text = "H4CK3R SYSTEM READY"
task.wait(0.8)

-- Dùng Tween làm mờ toàn bộ ScreenGui để chữ và khung cùng biến mất mượt mà
local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Tạo hiệu ứng ẩn dần các thành phần
local tween1 = TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 1})
local tween2 = TweenService:Create(title, tweenInfo, {TextTransparency = 1})
local tween3 = TweenService:Create(status, tweenInfo, {TextTransparency = 1})
local tween4 = TweenService:Create(bar, tweenInfo, {BackgroundTransparency = 1})
local tween5 = TweenService:Create(fill, tweenInfo, {BackgroundTransparency = 1})

tween1:Play()
tween2:Play()
tween3:Play()
tween4:Play()
tween5:Play()

tween1.Completed:Wait()
gui:Destroy()

--------------------------------------------------
-- ĐOẠN NÀY LÀ NƠI BẠN GẮN MENU HẶC CODE HACK VÀO SAU KHI LOAD XONG
--------------------------------------------------
print("H4CK3R UI Loaded Successfully!")
-- Ví dụ gọi script hack chính của bạn ở đây:
-- loadstring(game:HttpGet("LINK_SCRIPT_CHINH_CUA_BAN"))()
