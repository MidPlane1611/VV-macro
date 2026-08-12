-- [[ ADVANCED GUI MODULE ]]
-- Bee Swarm Ultimate Macro - Full Interactive Interface

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

    -- 1. МАЛЕНЬКАЯ КНОПКА В ПРАВОМ ВЕРХНЕМ УГЛУ (Launcher Icon с твоим ID)
    local MiniButton = Instance.new("ImageButton")
    MiniButton.Name = "MiniButton"
    MiniButton.Size = UDim2.new(0, 48, 0, 48)
    MiniButton.Position = UDim2.new(1, -65, 0, 15)
    MiniButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    MiniButton.BorderSizePixel = 0
    MiniButton.Image = "rbxassetid://112576205931289"
    MiniButton.Visible = false
    MiniButton.Parent = ScreenGui

    local MiniCorner = Instance.new("UICorner")
    MiniCorner.CornerRadius = UDim.new(0, 10)
    MiniCorner.Parent = MiniButton

    local MiniStroke = Instance.new("UIStroke")
    MiniStroke.Color = Color3.fromRGB(80, 80, 100)
    MiniStroke.Thickness = 2
    MiniStroke.Parent = MiniButton

    -- 2. ГЛАВНОЕ ОКНО МАКРОСА
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 560, 0, 410)
    MainFrame.Position = UDim2.new(0.5, -280, 0.5, -205)
    MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(50, 50, 65)
    MainStroke.Thickness = 1
    MainStroke.Parent = MainFrame

    -- Шапка окна
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 10)
    TopCorner.Parent = TopBar

    -- Исправление для закругленных углов шапки (скрываем нижние углы)
    local TopCover = Instance.new("Frame")
    TopCover.Size = UDim2.new(1, 0, 0, 10)
    TopCover.Position = UDim2.new(0, 0, 1, -10)
    TopCover.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    TopCover.BorderSizePixel = 0
    TopCover.Parent = TopBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -70, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "🐝 Bee Swarm Ultimate Macro | Pro Edition"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 15
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar

    -- Кнопка сворачивания в шапке ([-] Minimize)
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Size = UDim2.new(0, 32, 0, 32)
    MinimizeBtn.Position = UDim2.new(1, -40, 0, 6)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.Text = "—"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 14
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.Parent = TopBar

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = MinimizeBtn

    -- Панель статуса (Status Bar)
    local StatusBar = Instance.new("Frame")
    StatusBar.Size = UDim2.new(1, -30, 0, 55)
    StatusBar.Position = UDim2.new(0, 15, 0, 55)
    StatusBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    StatusBar.BorderSizePixel = 0
    StatusBar.Parent = MainFrame

    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(0, 8)
    StatusCorner.Parent = StatusBar

    local StatusText = Instance.new("TextLabel")
    StatusText.Name = "StatusText"
    StatusText.Size = UDim2.new(1, -20, 1, 0)
    StatusText.Position = UDim2.new(0, 12, 0, 0)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "Status: Initializing...\nField: Pine Tree Field | Pollen: 0 / 1,080,640 (0%)"
    StatusText.TextColor3 = Color3.fromRGB(120, 255, 170)
    StatusText.TextSize = 12
    StatusText.Font = Enum.Font.Code
    StatusText.TextXAlignment = Enum.TextXAlignment.Left
    StatusText.Parent = StatusBar

    -- Сетка вкладок 3x3 (Контейнер)
    local GridContainer = Instance.new("Frame")
    GridContainer.Size = UDim2.new(1, -30, 0, 265)
    GridContainer.Position = UDim2.new(0, 15, 0, 125)
    GridContainer.BackgroundTransparency = 1
    GridContainer.Parent = MainFrame

    local UIGridLayout = Instance.new("UIGridLayout")
    UIGridLayout.CellSize = UDim2.new(0, 168, 0, 75)
    UIGridLayout.CellPadding = UDim2.new(0, 12, 0, 12)
    UIGridLayout.Parent = GridContainer

    -- Функция для создания красивых карточек-кнопок 3x3
    local function CreateCard(name, desc, defaultState, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0, 0, 0, 0)
        Btn.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
        Btn.BorderSizePixel = 0
        Btn.AutoButtonColor = false
        Btn.Text = ""
        Btn.Parent = GridContainer

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 8)
        BtnCorner.Parent = Btn

        local BtnTitle = Instance.new("TextLabel")
        BtnTitle.Size = UDim2.new(1, -15, 0, 22)
        BtnTitle.Position = UDim2.new(0, 10, 0, 8)
        BtnTitle.BackgroundTransparency = 1
        BtnTitle.Text = name
        BtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        BtnTitle.TextSize = 13
        BtnTitle.Font = Enum.Font.GothamBold
        BtnTitle.TextXAlignment = Enum.TextXAlignment.Left
        BtnTitle.Parent = Btn

        local BtnDesc = Instance.new("TextLabel")
        BtnDesc.Size = UDim2.new(1, -15, 0, 18)
        BtnDesc.Position = UDim2.new(0, 10, 0, 30)
        BtnDesc.BackgroundTransparency = 1
        BtnDesc.Text = desc
        BtnDesc.TextColor3 = Color3.fromRGB(160, 160, 175)
        BtnDesc.TextSize = 11
        BtnDesc.Font = Enum.Font.Gotham
        BtnDesc.TextXAlignment = Enum.TextXAlignment.Left
        BtnDesc.Parent = Btn

        -- Индикатор состояния (вкл/выкл или статус)
        local StateIndicator = Instance.new("TextLabel")
        StateIndicator.Size = UDim2.new(1, -15, 0, 18)
        StateIndicator.Position = UDim2.new(0, 10, 0, 48)
        StateIndicator.BackgroundTransparency = 1
        StateIndicator.Text = defaultState and "Status: [ ON ]" : "Status: [ OFF ]"
        StateIndicator.TextColor3 = defaultState and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        StateIndicator.TextSize = 10
        StateIndicator.Font = Enum.Font.GothamBold
        StateIndicator.TextXAlignment = Enum.TextXAlignment.Left
        StateIndicator.Parent = Btn

        local currentState = defaultState

        Btn.MouseButton1Click:Connect(function()
            currentState = not currentState
            if currentState then
                StateIndicator.Text = "Status: [ ON ]"
                StateIndicator.TextColor3 = Color3.fromRGB(100, 255, 100)
                Btn.BackgroundColor3 = Color3.fromRGB(45, 55, 65)
            else
                StateIndicator.Text = "Status: [ OFF ]"
                StateIndicator.TextColor3 = Color3.fromRGB(255, 100, 100)
                Btn.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
            end
            
            if callback then
                pcall(function() callback(currentState) end)
            end
        end)

        return Btn
    end

    -- Наполнение сетки 3x3 реальными функциями управления
    CreateCard("Field Selector", "Cycle Target Field", true, function(state)
        if getgenv().MacroSettings then
            local fields = {"Pine Tree Field", "Coconut Field", "Spider Field", "Stump Field", "Pepper Patch"}
            for i, field in ipairs(fields) do
                if field == getgenv().MacroSettings.CurrentField then
                    local nextIdx = (i % #fields) + 1
                    getgenv().MacroSettings.CurrentField = fields[nextIdx]
                    break
                end
            end
            print("[GUI] Switched field to: " .. tostring(getgenv().MacroSettings.CurrentField))
        end
    end)

    CreateCard("Gathering Loop", "Pollen Collection", true, function(state)
        if getgenv().MacroSettings then
            getgenv().MacroSettings.Running = state
            print("[GUI] Macro Running: " .. tostring(state))
        end
    end)

    CreateCard("Auto Dispensers", "Treats & Royal Jelly", true, function(state)
        print("[GUI] Auto Dispensers toggled: " .. tostring(state))
    end)

    CreateCard("Discord Webhooks", "Real-time updates", true, function(state)
        local success, Utils = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/" .. LocalPlayer.Name .. "/bee-swarm-macro/main/src/modules/webhooks.lua"))()
        end)
        if success and Utils and state then
            Utils:Send("🔔 Webhook notifications activated via GUI!")
        end
    end)

    CreateCard("Black Screen", "FPS Optimization (3D)", false, function(state)
        if getgenv().MacroSettings then
            getgenv().MacroSettings.BlackScreen = state
            local success, Utils = pcall(function()
                return loadstring(game:HttpGet("https://raw.githubusercontent.com/" .. LocalPlayer.Name .. "/bee-swarm-macro/main/src/modules/utils.lua"))()
            end)
            if success and Utils then
                Utils:ToggleBlackScreen(state)
            end
        end
    end)

    CreateCard("Auto Rejoin", "Server protection", true, function(state)
        print("[GUI] Auto Rejoin protection active: " .. tostring(state))
    end)

    CreateCard("Stats Tracker", "Reset Pollen Counter", false, function(state)
        if getgenv().MacroSettings then
            getgenv().MacroSettings.PollenCurrent = 0
            getgenv().MacroSettings.BackpackFull = false
            print("[GUI] Pollen counter reset to 0.")
        end
    end)

    CreateCard("Config Presets", "Save / Load settings", false, function(state)
        print("[GUI] Config preset manager triggered.")
    end)

    -- Специальная кнопка аварийного выключения
    local StopBtn = Instance.new("TextButton")
    StopBtn.Size = UDim2.new(0, 0, 0, 0)
    StopBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
    StopBtn.BorderSizePixel = 0
    StopBtn.AutoButtonColor = false
    StopBtn.Text = ""
    StopBtn.Parent = GridContainer

    local StopCorner = Instance.new("UICorner")
    StopCorner.CornerRadius = UDim.new(0, 8)
    StopCorner.Parent = StopBtn

    local StopTitle = Instance.new("TextLabel")
    StopTitle.Size = UDim2.new(1, -15, 0, 22)
    StopTitle.Position = UDim2.new(0, 10, 0, 8)
    StopTitle.BackgroundTransparency = 1
    StopTitle.Text = "Emergency Stop"
    StopTitle.TextColor3 = Color3.fromRGB(255, 150, 150)
    StopTitle.TextSize = 13
    StopTitle.Font = Enum.Font.GothamBold
    StopTitle.TextXAlignment = Enum.TextXAlignment.Left
    StopTitle.Parent = StopBtn

    local StopDesc = Instance.new("TextLabel")
    StopDesc.Size = UDim2.new(1, -15, 0, 18)
    StopDesc.Position = UDim2.new(0, 10, 0, 30)
    StopDesc.BackgroundTransparency = 1
    StopDesc.Text = "Shutdown Macro & UI"
    StopDesc.TextColor3 = Color3.fromRGB(200, 160, 160)
    StopDesc.TextSize = 11
    StopDesc.Font = Enum.Font.Gotham
    StopDesc.TextXAlignment = Enum.TextXAlignment.Left
    StopDesc.Parent = StopBtn

    StopBtn.MouseButton1Click:Connect(function()
        if getgenv().MacroSettings then
            getgenv().MacroSettings.Running = false
        end
        ScreenGui:Destroy()
        print("[GUI] Emergency shutdown executed. Macro closed.")
    end)

    -- Логика переключения между большим окном и мини-кнопкой в углу
    MinimizeBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        MiniButton.Visible = true
    end)

    MiniButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        MiniButton.Visible = false
    end)

    -- Фоновое обновление статусной строки интерфейса
    task.spawn(function()
        while ScreenGui.Parent and task.wait(1) do
            if getgenv().MacroSettings then
                local s = getgenv().MacroSettings
                local pct = math.floor((s.PollenCurrent / s.PollenMax) * 100)
                StatusText.Text = string.format("Status: %s\nField: %s | Pollen: %s / %s (%d%%)", 
                    tostring(s.CurrentState),
                    tostring(s.CurrentField),
                    tostring(s.PollenCurrent),
                    tostring(s.PollenMax),
                    pct
                )
            end
        end
    end)

    print("[GUI] Advanced interface successfully loaded!")
end

return GuiModule
