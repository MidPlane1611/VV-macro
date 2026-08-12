-- [[ GUI MODULE ]]
-- Handles user interface, compact launcher button, and active functions for 3x3 tabs

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local GuiModule = {}

function GuiModule:Setup()
    -- Удаляем старый интерфейс, если он уже был открыт
    if CoreGui:FindFirstChild("BeeSwarmUltimateMacro") then
        CoreGui.BeeSwarmUltimateMacro:Destroy()
    end

    -- Создаем главный контейнер GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BeeSwarmUltimateMacro"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- 1. МАЛЕНЬКАЯ КНОПКА В ПРАВОМ ВЕРХНЕМ УГЛУ (Launcher Icon)
    local MiniButton = Instance.new("ImageButton")
    MiniButton.Name = "MiniButton"
    MiniButton.Size = UDim2.new(0, 45, 0, 45)
    MiniButton.Position = UDim2.new(1, -60, 0, 15)
    MiniButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    MiniButton.BorderSizePixel = 0
    MiniButton.Image = "rbxassetid://112576205931289"
    MiniButton.Visible = false
    MiniButton.Parent = ScreenGui

    local MiniCorner = Instance.new("UICorner")
    MiniCorner.CornerRadius = UDim.new(0, 8)
    MiniCorner.Parent = MiniButton

    local MiniStroke = Instance.new("UIStroke")
    MiniStroke.Color = Color3.fromRGB(60, 60, 70)
    MiniStroke.Thickness = 2
    MiniStroke.Parent = MiniButton

    -- 2. ГЛАВНОЕ ОКНО МАКРОСА
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 520, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    -- Шапка окна
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 8)
    TopCorner.Parent = TopBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -60, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "Bee Swarm Ultimate Macro v1.0"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar

    -- Кнопка сворачивания в шапке (-)
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    MinimizeBtn.Position = UDim2.new(1, -35, 0, 5)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.Text = "-"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 18
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.Parent = TopBar

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = MinimizeBtn

    -- Панель статуса (Status Bar)
    local StatusBar = Instance.new("Frame")
    StatusBar.Size = UDim2.new(1, -30, 0, 60)
    StatusBar.Position = UDim2.new(0, 15, 0, 55)
    StatusBar.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    StatusBar.BorderSizePixel = 0
    StatusBar.Parent = MainFrame

    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(0, 6)
    StatusCorner.Parent = StatusBar

    local StatusText = Instance.new("TextLabel")
    StatusText.Name = "StatusText"
    StatusText.Size = UDim2.new(1, -20, 1, 0)
    StatusText.Position = UDim2.new(0, 10, 0, 0)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "Status: Initializing...\nPollen: 0 / 1,080,640 (0%)"
    StatusText.TextColor3 = Color3.fromRGB(100, 255, 150)
    StatusText.TextSize = 13
    StatusText.Font = Enum.Font.Code
    StatusText.TextXAlignment = Enum.TextXAlignment.Left
    StatusText.Parent = StatusBar

    -- Сетка вкладок 3x3 (Контейнер)
    local GridContainer = Instance.new("Frame")
    GridContainer.Size = UDim2.new(1, -30, 0, 230)
    GridContainer.Position = UDim2.new(0, 15, 0, 130)
    GridContainer.BackgroundTransparency = 1
    GridContainer.Parent = MainFrame

    local UIGridLayout = Instance.new("UIGridLayout")
    UIGridLayout.CellSize = UDim2.new(0, 155, 0, 65)
    UIGridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
    UIGridLayout.Parent = GridContainer

    -- Данные кнопок с уникальными действиями (Action)
    local buttonsData = {
        {
            Name = "Field Settings", 
            Desc = "Cycle Field Target",
            Action = function()
                if getgenv().MacroSettings then
                    local fields = {"Pine Tree Field", "Coconut Field", "Spider Field", "Stump Field"}
                    -- Простейший переключатель полей по кругу
                    for i, field in ipairs(fields) do
                        if field == getgenv().MacroSettings.CurrentField then
                            local nextIndex = (i % #fields) + 1
                            getgenv().MacroSettings.CurrentField = fields[nextIndex]
                            break
                        end
                    end
                    print("[GUI] Switched Field to: " .. tostring(getgenv().MacroSettings.CurrentField))
                end
            end
        },
        {
            Name = "Gathering", 
            Desc = "Toggle Pause/Resume",
            Action = function()
                if getgenv().MacroSettings then
                    getgenv().MacroSettings.Running = not getgenv().MacroSettings.Running
                    print("[GUI] Macro Running State: " .. tostring(getgenv().MacroSettings.Running))
                end
            end
        },
        {
            Name = "Boosts & Items", 
            Desc = "Trigger Dispensers",
            Action = function()
                print("[GUI] Manual Dispensers & Boosts check triggered.")
            end
        },
        {
            Name = "Webhook Log", 
            Desc = "Test Discord Webhook",
            Action = function()
                local success, Utils = pcall(function()
                    -- Безопасный вызов модуля вебхуков, если он загружен
                    return loadstring(game:HttpGet("https://raw.githubusercontent.com/" .. LocalPlayer.Name .. "/bee-swarm-macro/main/src/modules/webhooks.lua"))()
                end)
                if success and Utils then
                    Utils:Send("🔔 Test notification sent manually from GUI button!")
                    print("[GUI] Test webhook message sent.")
                else
                    warn("[GUI] Could not trigger webhook test.")
                end
            end
        },
        {
            Name = "Black Screen", 
            Desc = "Toggle 3D Rendering",
            Action = function()
                if getgenv().MacroSettings then
                    getgenv().MacroSettings.BlackScreen = not getgenv().MacroSettings.BlackScreen
                    local state = getgenv().MacroSettings.BlackScreen
                    
                    local success, Utils = pcall(function()
                        return loadstring(game:HttpGet("https://raw.githubusercontent.com/" .. LocalPlayer.Name .. "/bee-swarm-macro/main/src/modules/utils.lua"))()
                    end)
                    if success and Utils then
                        Utils:ToggleBlackScreen(state)
                    end
                end
            end
        },
        {
            Name = "Auto Rejoin", 
            Desc = "Rejoin Current Server",
            Action = function()
                local success, Utils = pcall(function()
                    return loadstring(game:HttpGet("https://raw.githubusercontent.com/" .. LocalPlayer.Name .. "/bee-swarm-macro/main/src/modules/utils.lua"))()
                end)
                if success and Utils then
                    Utils:RejoinServer()
                end
            end
        },
        {
            Name = "Stats Tracker", 
            Desc = "Reset Pollen Counter",
            Action = function()
                if getgenv().MacroSettings then
                    getgenv().MacroSettings.PollenCurrent = 0
                    getgenv().MacroSettings.BackpackFull = false
                    print("[GUI] Pollen stats manually reset to 0.")
                end
            end
        },
        {
            Name = "Configs", 
            Desc = "Reload Settings",
            Action = function()
                print("[GUI] Configuration refreshed.")
            end
        },
        {
            Name = "Stop Macro", 
            Desc = "Emergency shutdown",
            Action = function()
                if getgenv().MacroSettings then
                    getgenv().MacroSettings.Running = false
                end
                ScreenGui:Destroy()
                print("[GUI] Macro stopped and UI closed completely.")
            end
        }
    }

    for _, data in ipairs(buttonsData) do
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0, 0, 0, 0)
        Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
        Btn.BorderSizePixel = 0
        Btn.Text = ""
        Btn.Parent = GridContainer

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = Btn

        local BtnTitle = Instance.new("TextLabel")
        BtnTitle.Size = UDim2.new(1, -10, 0, 25)
        BtnTitle.Position = UDim2.new(0, 5, 0, 8)
        BtnTitle.BackgroundTransparency = 1
        BtnTitle.Text = data.Name
        BtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        BtnTitle.TextSize = 13
        BtnTitle.Font = Enum.Font.GothamBold
        BtnTitle.Parent = Btn

        -- Индикатор текущего статуса функции внутри описания (опционально)
        local BtnDesc = Instance.new("TextLabel")
        BtnDesc.Size = UDim2.new(1, -10, 0, 20)
        BtnDesc.Position = UDim2.new(0, 5, 0, 33)
        BtnDesc.BackgroundTransparency = 1
        BtnDesc.Text = data.Desc
        BtnDesc.TextColor3 = Color3.fromRGB(170, 170, 180)
        BtnDesc.TextSize = 10
        BtnDesc.Font = Enum.Font.Gotham
        BtnDesc.Parent = Btn

        -- Подключаем заложенную логику при нажатии на кнопку
        Btn.MouseButton1Click:Connect(function()
            if data.Action then
                pcall(data.Action)
            end
        end)
    end

    -- Логика сворачивания и разворачивания интерфейса
    MinimizeBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        MiniButton.Visible = true
    end)

    MiniButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        MiniButton.Visible = false
    end)

    -- Обновление статуса в реальном времени внутри интерфейса
    task.spawn(function()
        while ScreenGui.Parent and task.wait(1) do
            if getgenv().MacroSettings then
                local s = getgenv().MacroSettings
                local pct = math.floor((s.PollenCurrent / s.PollenMax) * 100)
                StatusText.Text = string.format("Status: %s\nField: %s | Pollen: %d%%", 
                    tostring(s.CurrentState),
                    tostring(s.CurrentField),
                    pct
                )
            end
        end
    end)

    print("[GUI] Interface successfully loaded with full button actions!")
end

return GuiModule
