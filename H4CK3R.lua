--!strict
-- H4CK3R Loading Screen + Mobile Camlock Button

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. XÓA UI CŨ NẾU CÓ
if playerGui:FindFirstChild("H4CK3R_Loading") then
    playerGui.H4CK3R_Loading:Destroy()
end
if playerGui:FindFirstChild("H4CK3R_MobileUI") then
    playerGui.H4CK3R_MobileUI:Destroy()
end

-- 2. TẠO GIAO DIỆN LOADING SCREEN
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

-- 3. CHẠY THANH LOADING
for progress = 1, 100 do
    fill.Size = UDim2.fromScale(progress / 100, 1)
    status.Text = "LOADING SYSTEM... " .. progress .. "%"
    task.wait(0.02)
end

status.Text = "H4CK3R SYSTEM READY"
task.wait(0.6)

-- 4. HIỆU ỨNG MỜ DẦN VÀ XÓA MÀN HÌNH LOADING
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local t1 = TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 1})
local t2 = TweenService:Create(title, tweenInfo, {TextTransparency = 1})
local t3 = TweenService:Create(status, tweenInfo, {TextTransparency = 1})
local t4 = TweenService:Create(bar, tweenInfo, {BackgroundTransparency = 1})
local t5 = TweenService:Create(fill, tweenInfo, {BackgroundTransparency = 1})

t1:Play() t2:Play() t3:Play() t4:Play() t5:Play()
t1.Completed:Wait()
gui:Destroy()

--------------------------------------------------------------------------------
-- 5. TẠO NÚT BẤM CAMLOCK ẢO TRÊN MÀN HÌNH ĐIỆN THOẠI
--------------------------------------------------------------------------------
local mobileGui = Instance.new("ScreenGui")
mobileGui.Name = "H4CK3R_MobileUI"
mobileGui.ResetOnSpawn = false
mobileGui.Parent = playerGui

local camButton = Instance.new("TextButton")
camButton.Size = UDim2.new(0, 120, 0, 45)
camButton.Position = UDim2.new(0.8, -60, 0.2, 0) -- Nằm ở góc phải màn hình, có thể kéo thả
camButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
camButton.BorderColor3 = Color3.fromRGB(255, 35, 55)
camButton.BorderSizePixel = 2
camButton.Text = "CAMLOCK: OFF"
camButton.TextColor3 = Color3.fromRGB(255, 35, 55)
camButton.TextSize = 14
camButton.Font = Enum.Font.GothamBold
camButton.Parent = mobileGui

-- Bo tròn nút cho đẹp
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = camButton

local Camera = workspace.CurrentCamera
local targetPlayer: Player? = nil
local camlockEnabled = false

-- Hàm tìm player gần tâm màn hình nhất
local function getClosestPlayer(): Player?
    local closestPlr: Player? = nil
    local shortestDist = math.huge
    -- Lấy tâm màn hình điện thoại
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local humanoid = p.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local vector, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                if onScreen then
                    local dist = (Vector2.new(vector.X, vector.Y) - screenCenter).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        closestPlr = p
                    end
                end
            end
        end
    end
    return closestPlr
end

-- Sự kiện khi bấm vào nút Camlock trên màn hình điện thoại
camButton.MouseButton1Click:Connect(function()
    camlockEnabled = not camlockEnabled
    if camlockEnabled then
        targetPlayer = getClosestPlayer()
        if targetPlayer and targetPlayer.Name then
            camButton.Text =
