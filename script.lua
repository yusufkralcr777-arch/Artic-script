-- =========================================================================
-- 👑 SURVIVE 7 DAYS IN ARCTIC - PREMIUM YOUTUBE SCRIPT
-- Geliştirici: Özel Yapım
-- Sürüm: v1.0 (Safe Mode Bypass)
-- =========================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- [ ESKİ MENÜYÜ TEMİZLEME ] --
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "PremiumArcticHub" then
        gui:Destroy()
    end
end

-- =========================================================================
-- 🎨 ARAYÜZ (UI) TASARIMI - ŞIK VE MODERN
-- =========================================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PremiumArcticHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 280)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Köşe Yumuşatma
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Üst Başlık Çubuğu (Sürüklenebilir Alan)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "👑 ARCTIC PREMIUM HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Kapatma Butonu
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Font = Enum.Font.GothamBlack
CloseBtn.TextSize = 16
CloseBtn.Parent = TopBar

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Sürükleme Mantığı (Draggable)
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Özellikler İçin Alan
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -20, 1, -55)
ContentFrame.Position = UDim2.new(0, 10, 0, 45)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = 4
ContentFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ContentFrame

-- =========================================================================
-- ⚙️ SİSTEM DEĞİŞKENLERİ
-- =========================================================================
local features = {
    FastFishing = false,
    AutoChop = false,
    InstantPrompt = false
}

-- =========================================================================
-- 🛠️ BUTON OLUŞTURUCU FONKSİYON
-- =========================================================================
local function createToggle(name, description, featureKey)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -10, 0, 50)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ToggleFrame.Parent = ContentFrame

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
    ToggleBtn.BackgroundTransparency = 1
    ToggleBtn.Text = ""
    ToggleBtn.Parent = ToggleFrame

    local TitleText = Instance.new("TextLabel")
    TitleText.Size = UDim2.new(1, -60, 0, 25)
    TitleText.Position = UDim2.new(0, 10, 0, 5)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = name
    TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleText.Font = Enum.Font.GothamBold
    TitleText.TextSize = 14
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Parent = ToggleFrame

    local DescText = Instance.new("TextLabel")
    DescText.Size = UDim2.new(1, -60, 0, 20)
    DescText.Position = UDim2.new(0, 10, 0, 25)
    DescText.BackgroundTransparency = 1
    DescText.Text = description
    DescText.TextColor3 = Color3.fromRGB(150, 150, 150)
    DescText.Font = Enum.Font.Gotham
    DescText.TextSize = 11
    DescText.TextXAlignment = Enum.TextXAlignment.Left
    DescText.Parent = ToggleFrame

    local StatusBox = Instance.new("Frame")
    StatusBox.Size = UDim2.new(0, 30, 0, 30)
    StatusBox.Position = UDim2.new(1, -40, 0.5, -15)
    StatusBox.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    StatusBox.Parent = ToggleFrame

    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(0, 6)
    StatusCorner.Parent = StatusBox

    ToggleBtn.MouseButton1Click:Connect(function()
        features[featureKey] = not features[featureKey]
        if features[featureKey] then
            StatusBox.BackgroundColor3 = Color3.fromRGB(60, 255, 100)
        else
            StatusBox.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        end
    end)
end

-- Butonları Menüye Ekleme
createToggle("🎣 Hızlı Balık Tutma", "Balık sürelerini max 2 saniyeye indirir.", "FastFishing")
createToggle("🪓 Otomatik Ağaç/Kaynak", "Elindeki aleti sürekli kullanır.", "AutoChop")
createToggle("⚡ Anında Etkileşim (VIP)", "Bekleme sürelerini sıfırlar (0 saniye).", "InstantPrompt")

-- İçerik kutusunun boyutunu ayarlama
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)

-- =========================================================================
-- 🚀 ANA HİLE DÖNGÜLERİ (SAFE MODE - ÇÖKMEYİ ENGELLER)
-- =========================================================================

-- 1. HIZLI BALIK DÖNGÜSÜ
task.spawn(function()
    while task.wait(0.1) do
        if features.FastFishing then
            pcall(function()
                -- Karakterdeki ve UI'daki değerleri tara ve düşür
                local char = LocalPlayer.Character
                if char then
                    for _, v in pairs(char:GetDescendants()) do
                        if v:IsA("NumberValue") or v:IsA("IntValue") then
                            local lowerName = string.lower(v.Name)
                            if string.find(lowerName, "fish") or string.find(lowerName, "time") or string.find(lowerName, "wait") then
                                if v.Value > 2 then v.Value = 2 end
                            end
                        end
                    end
                end
                
                local pGui = LocalPlayer:FindFirstChild("PlayerGui")
                if pGui then
                    for _, v in pairs(pGui:GetDescendants()) do
                        if (v:IsA("NumberValue") or v:IsA("IntValue")) and (string.find(string.lower(v.Name), "fish") or string.find(string.lower(v.Name), "progress")) then
                            if v.Value > 2 then v.Value = 2 end
                        end
                    end
                end
            end)
        end
    end
end)

-- 2. ANINDA ETKİLEŞİM (PROXIMITY BYPASS)
task.spawn(function()
    while task.wait(0.2) do
        if features.InstantPrompt then
            pcall(function()
                for _, prompt in pairs(Workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") then
                        if prompt.HoldDuration > 0 then
                            prompt.HoldDuration = 0
                        end
                        -- Mesafeyi azıcık artır ki uzaktan alabilesin
                        if prompt.MaxActivationDistance < 15 then
                            prompt.MaxActivationDistance = 15
                        end
                    end
                end
            end)
        end
    end
end)

-- 3. OTOMATİK TOOL (BALTA/OLTA) SALLAMA AURA
task.spawn(function()
    while task.wait(0.1) do
        if features.AutoChop then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    local currentTool = char:FindFirstChildOfClass("Tool")
                    if currentTool then
                        currentTool:Activate()
                    end
                end
            end)
        end
    end
end)

print("[Premium Arctic Hub] Başarıyla Çalıştırıldı!")
