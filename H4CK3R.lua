-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Aiming/main/Examples/AimLock.lua"))()
local AimingChecks = Aiming.Checks
local AimingSelected = Aiming.Selected
local AimLockSettings = Aiming.AimLock

-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- // Vars
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local H4CK3RSettings = {
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
getgenv().H4CK3RSettings = H4CK3RSettings

-- // Prediction Formula
function H4CK3RSettings.ApplyPredictionFormula(SelectedPart, Velocity)
    return SelectedPart.CFrame + (Velocity * H4CK3RSettings.Prediction)
end

-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and AimingChecks.IsAvailable() and H4CK3RSettings.SilentAim) then
        local SelectedPart = AimingSelected.Part
        if SelectedPart then
            local Hit = H4CK3RSettings.ApplyPredictionFormula(SelectedPart, AimingSelected.Velocity * Vector3.new(1, 0.1, 1))
            return (k == "Hit" and Hit or SelectedPart)
        end
    end
    return __index(t, k)
end)

-- // Aimlock Position
function AimLockSettings.AimLockPosition(CameraMode)
    local Position
    local BeizerData = {}

    if AimingSelected.Part then
        local Hit = H4CK3RSettings.ApplyPredictionFormula(AimingSelected.Part)
        local HitPosition = Hit.Position

        if (CameraMode) then
            Position = HitPosition
        else
            local Vector, _ = CurrentCamera:WorldToViewportPoint(HitPosition)
            local Vector2D = Vector2.new(Vector.X, Vector.Y)
            local BeizerLock = H4CK3RSettings.BeizerLock

            Position = Vector2D
            BeizerData = {
                Smoothness = BeizerLock.Smoothness,
                CurvePoints = BeizerLock.CurvePoints
            }
        end
    end

    return Position, BeizerData
end

--------------------------------------------------------------------------------
-- // MOBILE UI: TẠO NÚT H4CK3R: OFF / ON TRÊN MÀN HÌNH ĐIỆN THOẠI
--------------------------------------------------------------------------------

-- Xóa UI cũ nếu đã tồn tại để tránh bị nhân đôi
if PlayerGui:FindFirstChild("H4CK3R_MobileUI") then
    PlayerGui.H4CK3R_MobileUI:Destroy()
end

local mobileGui = Instance.new("ScreenGui")
mobileGui.Name = "H4CK3R_MobileUI"
mobileGui.ResetOnSpawn = false
mobileGui.Parent = PlayerGui

local camButton = Instance.new("TextButton")
camButton.Size = UDim2.new(0, 130, 0, 45)
camButton.Position = UDim2.new(0.8, -65, 0.25, 0) -- Vị trí nút ở cạnh phải màn hình
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

-- Xử lý logic bật/tắt Aimlock khi bấm vào nút
camButton.MouseButton1Click:Connect(function()
    -- Đảo ngược trạng thái SilentAim khi bấm nút
    H4CK3RSettings.SilentAim = not H4CK3RSettings.SilentAim

    if H4CK3RSettings.SilentAim then
        camButton.Text = "H4CK3R: ON"
        camButton.TextColor3 = Color3.fromRGB(0, 255, 100)
        camButton.BorderColor3 = Color3.fromRGB(0, 255, 100)
    else
        camButton.Text = "H4CK3R: OFF"
        camButton.TextColor3 = Color3.fromRGB(255, 35, 55)
        camButton.BorderColor3 = Color3.fromRGB(255, 35, 55)
    end
end)

-- // Return
return H4CK3RSettings
