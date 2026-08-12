getgenv().MacroSettings = {
    Running = false,
    CurrentField = "Dandelion Field",
    FarmType = "Random",
    BackpackMethod = "Convert Hive",
    HiveSlot = 1,
    Farm = 1,
    Convert = 0
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

if PlayerGui:FindFirstChild("VVMacroMiniGui") then PlayerGui.VVMacroMiniGui:Destroy() end
if PlayerGui:FindFirstChild("VVMacroMainGui") then PlayerGui.VVMacroMainGui:Destroy() end

local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "VVMacroMiniGui"
screenGui.ResetOnSpawn = false

local toggleButton = Instance.new("ImageButton", screenGui)
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 20, 0, 150)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.BackgroundTransparency = 0.2
toggleButton.Image = "rbxassetid://112576205931289"

Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 12)
local uiStroke = Instance.new("UIStroke", toggleButton)
uiStroke.Color = Color3.fromRGB(255, 215, 0)
uiStroke.Thickness = 2

local mainGui = Instance.new("ScreenGui", PlayerGui)
mainGui.Name = "VVMacroMainGui"
mainGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 340, 0, 420)
mainFrame.Position = UDim2.new(0.5, -170, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false
mainFrame.ZIndex = 5
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.ZIndex = 6
closeButton.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

local fields = {
    "Dandelion Field", "Clover Field", "Blue Flower Field", "Mushroom Field",
    "Sunflower Field", "Spider Field", "Bamboo Field", "Strawberry Field",
    "Pineapple Field", "Stump Field", "Cactus Field", "Pumpkin Field",
    "Pine Tree Field", "Rose Field", "Pepper Field", "Coconut Field"
}
local fieldIndex = 1

local fieldBtn = Instance.new("TextButton", mainFrame)
fieldBtn.Size = UDim2.new(0.9, 0, 0, 35)
fieldBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
fieldBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
fieldBtn.Text = "Field: Dandelion Field"
fieldBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
fieldBtn.TextSize = 13
fieldBtn.ZIndex = 6
Instance.new("UICorner", fieldBtn).CornerRadius = UDim.new(0, 6)

fieldBtn.MouseButton1Click:Connect(function()
    fieldIndex = fieldIndex % #fields + 1
    getgenv().MacroSettings.CurrentField = fields[fieldIndex]
    fieldBtn.Text = "Field: " .. fields[fieldIndex]
end)

local farmTypes = {"Random", "Token Collector"}
local farmTypeIndex = 1

local farmTypeBtn = Instance.new("TextButton", mainFrame)
farmTypeBtn.Size = UDim2.new(0.9, 0, 0, 35)
farmTypeBtn.Position = UDim2.new(0.05, 0, 0.28, 0)
farmTypeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
farmTypeBtn.Text = "Farm Type: Random"
farmTypeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
farmTypeBtn.TextSize = 13
farmTypeBtn.ZIndex = 6
Instance.new("UICorner", farmTypeBtn).CornerRadius = UDim.new(0, 6)

farmTypeBtn.MouseButton1Click:Connect(function()
    farmTypeIndex = farmTypeIndex % #farmTypes + 1
    getgenv().MacroSettings.FarmType = farmTypes[farmTypeIndex]
    farmTypeBtn.Text = "Farm Type: " .. farmTypes[farmTypeIndex]
end)

local backpackMethods = {"Convert Hive", "Reset"}
local methodIndex = 1

local methodBtn = Instance.new("TextButton", mainFrame)
methodBtn.Size = UDim2.new(0.9, 0, 0, 35)
methodBtn.Position = UDim2.new(0.05, 0, 0.44, 0)
methodBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
methodBtn.Text = "Backpack Method: Convert Hive"
methodBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
methodBtn.TextSize = 13
methodBtn.ZIndex = 6
Instance.new("UICorner", methodBtn).CornerRadius = UDim.new(0, 6)

methodBtn.MouseButton1Click:Connect(function()
    methodIndex = methodIndex % #backpackMethods + 1
    getgenv().MacroSettings.BackpackMethod = backpackMethods[methodIndex]
    methodBtn.Text = "Backpack Method: " .. backpackMethods[methodIndex]
end)

local hiveSlotBtn = Instance.new("TextButton", mainFrame)
hiveSlotBtn.Size = UDim2.new(0.9, 0, 0, 35)
hiveSlotBtn.Position = UDim2.new(0.05, 0, 0.60, 0)
hiveSlotBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
hiveSlotBtn.Text = "Hive Slot: 1"
hiveSlotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hiveSlotBtn.TextSize = 13
hiveSlotBtn.ZIndex = 6
Instance.new("UICorner", hiveSlotBtn).CornerRadius = UDim.new(0, 6)

hiveSlotBtn.MouseButton1Click:Connect(function()
    local slot = getgenv().MacroSettings.HiveSlot % 6 + 1
    getgenv().MacroSettings.HiveSlot = slot
    hiveSlotBtn.Text = "Hive Slot: " .. slot
end)

local startButton = Instance.new("TextButton", mainFrame)
startButton.Size = UDim2.new(0.9, 0, 0, 45)
startButton.Position = UDim2.new(0.05, 0, 0.78, 0)
startButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
startButton.Text = "START MACRO"
startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
startButton.TextSize = 14
startButton.Font = Enum.Font.GothamBold
startButton.ZIndex = 6
Instance.new("UICorner", startButton).CornerRadius = UDim.new(0, 8)

toggleButton.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

local HiveCoords = {
    [1] = Vector3.new(-187, 6, 331), [2] = Vector3.new(-150, 6, 331), [3] = Vector3.new(-113, 6, 331),
    [4] = Vector3.new(-77, 6, 331),  [5] = Vector3.new(-40, 6, 331),  [6] = Vector3.new(-3, 6, 331)
}

local FieldData = {
    ["Dandelion Field"]    = Vector3.new(-33, 4, 219),
    ["Clover Field"]       = Vector3.new(154, 34, 193),
    ["Blue Flower Field"]  = Vector3.new(152, 4, 99),
    ["Mushroom Field"]     = Vector3.new(-95, 4, 117),
    ["Sunflower Field"]    = Vector3.new(-212, 4, 177),
    ["Spider Field"]       = Vector3.new(-49, 20, -8),
    ["Bamboo Field"]       = Vector3.new(121, 20, -26),
    ["Strawberry Field"]   = Vector3.new(-175, 20, -7),
    ["Pineapple Field"]    = Vector3.new(249, 68, -207),
    ["Stump Field"]        = Vector3.new(422, 96, -176),
    ["Cactus Field"]       = Vector3.new(-183, 69, -104),
    ["Pumpkin Field"]      = Vector3.new(-189, 69, -183),
    ["Pine Tree Field"]    = Vector3.new(-330, 68, -185),
    ["Rose Field"]         = Vector3.new(-330, 20, 127),
    ["Pepper Field"]       = Vector3.new(-491, 123, 533),
    ["Coconut Field"]      = Vector3.new(-254, 71, 466)
}

local NetworkTokens = {}

local function startCollectibleListener()
    pcall(function()
        for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
            if obj.Name == "CollectibleEvent" and obj:IsA("RemoteEvent") then
                obj.OnClientEvent:Connect(function(...)
                    local args = {...}
                    if args[1] and type(args[1]) == "string" and args[1]:lower():find("spawn") then
                        for i = 2, #args do
                            local arg = args[i]
                            if typeof(arg) == "Vector3" then
                                table.insert(NetworkTokens, {Pos = arg, Time = tick()})
                            elseif type(arg) == "table" then
                                for _, sub in pairs(arg) do
                                    if typeof(sub) == "Vector3" then
                                        table.insert(NetworkTokens, {Pos = sub, Time = tick()})
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
end

local function findSpawnToken(hrpPos, radius)
    local nearestPos = nil
    local shortestDist = radius
    
    for i = #NetworkTokens, 1, -1 do
        if tick() - NetworkTokens[i].Time > 3 then
            table.remove(NetworkTokens, i)
        end
    end
    
    for _, token in ipairs(NetworkTokens) do
        local dist = (Vector3.new(token.Pos.X, hrpPos.Y, token.Pos.Z) - hrpPos).Magnitude
        if dist < shortestDist then
            shortestDist = dist
            nearestPos = token.Pos
        end
    end
    
    return nearestPos
end

-- Функция для получения данных Pollen из Workspace
local function getWorkspacePollen()
    local curr, max = 0, 100
    pcall(function()
        -- Проходим по объектам в Workspace для поиска значений игрока
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name == "Pollen" or obj.Name == "Capacity" then
                -- Убедимся, что это относится к нашему игроку (если папка/модель содержит имя игрока)
                if obj.Parent and (obj.Parent.Name == LocalPlayer.Name or obj.Parent.Parent == LocalPlayer) then
                    if obj.Name == "Pollen" and (obj:IsA("NumberValue") or obj:IsA("IntValue")) then
                        curr = obj.Value
                    elseif obj.Name == "Capacity" and (obj:IsA("NumberValue") or obj:IsA("IntValue")) then
                        max = obj.Value
                    end
                end
            end
        end
    end)
    return curr, max
end

startButton.MouseButton1Click:Connect(function()
    local settings = getgenv().MacroSettings
    settings.Running = not settings.Running
    if settings.Running then
        startButton.Text = "STOP MACRO"
        startButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        
        startCollectibleListener()

        -- Сбор инструментов
        task.spawn(function()
            while settings.Running do
                if settings.Farm == 1 and settings.Convert == 0 then
                    pcall(function()
                        local toolEvent = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("ToolCollect")
                        if toolEvent and toolEvent:IsA("RemoteEvent") then
                            toolEvent:FireServer()
                        end
                    end)
                end
                task.wait(0.05)
            end
        end)

        -- Основной цикл макроса
        task.spawn(function()
            local isConvertingAtHive = false

            while settings.Running do
                local char = LocalPlayer.Character
                local humanoid = char and char:FindFirstChildOfClass("Humanoid")
                
                -- Детект смерти
                if not char or not char:FindFirstChild("HumanoidRootPart") or (humanoid and humanoid.Health <= 0) then
                    settings.Farm = 1
                    settings.Convert = 0
                    isConvertingAtHive = false
                    task.wait(10)
                    repeat task.wait(0.5)
                        char = LocalPlayer.Character
                    until char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") and char:FindFirstChildOfClass("Humanoid").Health > 0
                    
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local basePos = FieldData[settings.CurrentField] or Vector3.new(0, 5, 0)
                    if hrp then
                        hrp.CFrame = CFrame.new(basePos + Vector3.new(0, 5, 0))
                    end
                    task.wait(1)
                end

                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    humanoid = char:FindFirstChildOfClass("Humanoid")
                    
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end

                    -- ЧТЕНИЕ ПЫЛЬЦЫ ИЗ WORKSPACE
                    local currPollen, maxPollen = getWorkspacePollen()
                    
                    if currPollen >= maxPollen and settings.Farm == 1 then
                        settings.Farm = 0
                        settings.Convert = 1
                    elseif currPollen == 0 and settings.Convert == 1 then
                        settings.Farm = 1
                        settings.Convert = 0
                        isConvertingAtHive = false
                    end

                    -- 1. ФАРМ (Строго когда Farm == 1 и Convert == 0)
                    if settings.Farm == 1 and settings.Convert == 0 then
                        local basePos = FieldData[settings.CurrentField] or Vector3.new(0, 5, 0)
                        
                        if (hrp.Position - basePos).Magnitude > 30 then
                            hrp.CFrame = CFrame.new(basePos + Vector3.new(0, 5, 0))
                        end
                        
                        if humanoid then
                            if settings.FarmType == "Token Collector" then
                                local tokenPos = findSpawnToken(hrp.Position, 20)
                                if tokenPos then
                                    humanoid:MoveTo(tokenPos)
                                    humanoid.MoveToFinished:Wait()
                                else
                                    humanoid:MoveTo(basePos + Vector3.new(math.random(-4, 4), 0, math.random(-4, 4)))
                                    humanoid.MoveToFinished:Wait()
                                end
                            else
                                for _ = 1, 5 do
                                    if not settings.Running or settings.Farm == 0 or settings.Convert == 1 then break end
                                    humanoid:MoveTo(basePos + Vector3.new(math.random(-12, 12), 0, math.random(-12, 12)))
                                    task.wait(0.5)
                                end
                            end
                        end

                    -- 2. КОНВЕРТАЦИЯ (Строго когда Farm == 0 и Convert == 1)
                    elseif settings.Farm == 0 and settings.Convert == 1 then
                        if not isConvertingAtHive then
                            isConvertingAtHive = true
                            
                            if settings.BackpackMethod == "Reset" then
                                LocalPlayer.Character:BreakJoints()
                                task.wait(4)
                            else
                                local targetHive = HiveCoords[settings.HiveSlot] or HiveCoords[1]
                                hrp.CFrame = CFrame.new(targetHive + Vector3.new(0, 3, 0))
                                task.wait(1.5)
                                
                                pcall(function()
                                    local hiveCommand = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("PlayerHiveCommand")
                                    if hiveCommand and hiveCommand:IsA("RemoteEvent") then
                                        hiveCommand:FireServer("ToggleHoneyMaking")
                                    end
                                end)
                            end
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
    else
        startButton.Text = "START MACRO"
        startButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    end
end)
