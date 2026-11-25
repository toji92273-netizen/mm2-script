-- Fling GUI Script for MM2 (Delta)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlingGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 120)
Frame.Position = UDim2.new(0.5, -110, 0.5, -60)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "FLING GUI"
Title.TextColor3 = Color3.fromRGB(0, 255, 170)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.9, 0, 0, 30)
TextBox.Position = UDim2.new(0.05, 0, 0.3, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.PlaceholderText = "Введи ник"
TextBox.Text = ""
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
TextBox.Parent = Frame

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0.9, 0, 0, 35)
Button.Position = UDim2.new(0.05, 0, 0.6, 0)
Button.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
Button.TextColor3 = Color3.fromRGB(10, 10, 15)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 14
Button.Text = "ФЛИНГ!"
Button.Parent = Frame

-- Функция поиска игрока по нику
local function GetPlayer(name)
    name = name:lower()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and (p.Name:lower():sub(1, #name) == name or p.DisplayName:lower():sub(1, #name) == name) then
            return p
        end
    end
    return nil
end

-- Упрощённая функция флинга
local function Fling(TargetPlayer)
    local char = TargetPlayer.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(math.random(-500, 500), 800, math.random(-500, 500))
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Parent = root
    
    task.wait(0.15)
    if bv then bv:Destroy() end
end

Button.MouseButton1Click:Connect(function()
    local targetName = TextBox.Text
    if targetName == "" then
        return
    end
    
    local target = GetPlayer(targetName)
    if target then
        Fling(target)
    end
end)