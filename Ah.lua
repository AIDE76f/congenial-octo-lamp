-- سكربت My Car Show لجمع الأموال تلقائياً مع GUI بسيط

-- الخدمات المطلوبة
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Workspace = game:GetService("Workspace")

-- إعداد GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoCashGUI"
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0, 20, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BackgroundTransparency = 0.3
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Auto Money Collector"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = Frame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(1, -20, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 50)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.TextColor3 = Color3.new(1,1,1)
ToggleButton.Text = "Start"
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 16
ToggleButton.Parent = Frame

-- المتغيرات
local collecting = false

-- دالة جمع الأموال
local function collectMoney()
    for _, carSpot in pairs(Workspace:GetDescendants()) do
        if carSpot:IsA("Model") and carSpot:FindFirstChild("Money") then
            local moneyPart = carSpot.Money
            -- تحريك اللاعب إلى المال لجمعه (افتراضي)
            LocalPlayer.Character.HumanoidRootPart.CFrame = moneyPart.CFrame
            wait(0.1) -- تأخير بسيط
        end
    end
end

-- التكرار كل 5 ثواني
spawn(function()
    while true do
        if collecting then
            collectMoney()
        end
        wait(5)
    end
end)

-- أزرار التحكم
ToggleButton.MouseButton1Click:Connect(function()
    collecting = not collecting
    if collecting then
        ToggleButton.Text = "Stop"
    else
        ToggleButton.Text = "Start"
    end
end)
