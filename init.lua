getgenv().MacroSettings = {
    Running = false,
    CurrentField = "Dandelion Field",
    FarmType = "Token Collector",
    HiveSlot = 1,
    Farm = 1,
    Convert = 0
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

local fields = {"Dandelion Field", "Sunflower Field", "Mushroom Field", "Blue Flower Field", "Clover Field", "Spider Field", "Strawberry Field", "Bamboo Field", "Pineapple Patch", "Stump Field", "Cactus Field", "Pumpkin Patch", "Pine Tree Forest", "Rose Field", "Mountain Top Field", "Coconut Field"}
local fieldIndex = 1

local fieldBtn = Instance.new("TextButton", mainFrame)
fieldBtn.Size = UDim2.new(0.9, 0, 0, 35)
fieldBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
fieldBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
fieldBtn.Text = "Field: Dandelion Field"
fieldBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
fieldBtn.TextSize = 13
Instance.new("UICorner", fieldBtn).CornerRadius = UDim.new(0, 6)

fieldBtn.MouseButton1Click:Connect(function()
    fieldIndex = fieldIndex % #fields + 1
    getgenv().MacroSettings.CurrentField = fields[fieldIndex]
    fieldBtn.Text = "Field: " .. fields[fieldIndex]
end)

local hiveSlotBtn = Instance.new("TextButton", mainFrame)
hiveSlotBtn.Size = UDim2.new(0.9, 0, 0, 35)
hiveSlotBtn.Position = UDim2.new(0.05, 0, 0.60, 0)
hiveSlotBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
hiveSlotBtn.Text = "Hive Slot: 1"
hiveSlotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hiveSlotBtn.TextSize = 13
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
Instance.new("UICorner", startButton).CornerRadius = UDim.new(0, 8)

toggleButton.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

local HiveCoords = {
    [1] = Vector3.new(-187, 6, 331), [2] = Vector3.new(-150, 6, 331), [3] = Vector3.new(-113, 6, 331),
    [4] = Vector3.new(-77, 6, 331),  [5] = Vector3.new(-40, 6, 331),  [6] = Vector3.new(-3, 6, 331)
}

local FieldData = {
    ["Dandelion Field"] = Vector3.new(-75, 4, 185), ["Sunflower Field"] = Vector3.new(-200, 4, 160),
    ["Mushroom Field"] = Vector3.new(-105, 4, 45),   ["Blue Flower Field"] = Vector3.new(115, 4, 130),
    ["Clover Field"] = Vector3.new(170, 32, 190),   ["Spider Field"] = Vector3.new(-55, 18, -20),
    ["Strawberry Field"] = Vector3.new(-180, 20, -10), ["Bamboo Field"] = Vector3.new(145, 20, -5),
    ["Pineapple Patch"] = Vector3.new(260, 68, -195), ["Stump Field"] = Vector3.new(437, 98, -175),
    ["Cactus Field"] = Vector3.new(-195, 68, -110),  ["Pumpkin Patch"] = Vector3.new(180, 68, -110),
    ["Pine Tree Forest"] = Vector3.new(-325, 68, -175), ["Rose Field"] = Vector3.new(-130, 4, -135),
    ["Mountain Top Field"] = Vector3.new(75, 176, -165), ["Coconut Field"] = Vector3.new(-265, 72, 460)
}

-- СЕТЕВОЙ ПЕРЕХВАТЧИК ТОЧНО ПО АРГУМЕНТУ №1 ("Spawn")
local NetworkTokens = {}

local function startCollectibleListener()
    pcall(function()
        for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
            if obj.Name == "CollectibleEvent" and obj:IsA("RemoteEvent") then
                obj.OnClientEvent:Connect(function(...)
                    local args = {...}
                    -- Проверяем, что аргумент номер 1 равен "Spawn" (или содержит это слово)
                    if args[1] and type(args[1]) == "string" and args[1]:lower():find("spawn") then
                        -- Ищем среди остальных аргументов Vector3 (координаты)
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

-- Поиск токена в радиусе (круге)
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

startButton.MouseButton1Click:Connect(function()
    local settings = getgenv().MacroSettings
    settings.Running = not settings.Running
    if settings.Running then
        startButton.Text = "STOP MACRO"
        startButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        
        startCollectibleListener()

        task.spawn(function()
            while settings.Running do
                if settings.Farm == 1 and settings.Convert == 0 then
                    pcall(function()
                        VirtualUser:Button1Down(Vector2.new(0,0))
                        task.wait(0.01)
                        VirtualUser:Button1Up(Vector2.new(0,0))
                    end)
                end
                task.wait(0.05)
            end
        end)

        task.spawn(function()
            while settings.Running do
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end

                    local screenGui = PlayerGui:FindFirstChild("ScreenGui")
                    local pollenLabel = nil
                    if screenGui then
                        for _, desc in ipairs(screenGui:GetDescendants()) do
                            if desc:IsA("TextLabel") and desc.Text:find("/") and (desc.Text:lower():find("pollen") or desc.Text:find("%d+/%d+")) then
                                pollenLabel = desc
                                break
                            end
                        end
                    end

                    if pollenLabel then
                        local cleanText = pollenLabel.Text:gsub(",", "")
                        local current, max = cleanText:match("(%d+)%s*/%s*(%d+)")
                        if current and max then
                            local currNum, maxNum = tonumber(current), tonumber(max)
                            if currNum and maxNum then
                                if currNum >= maxNum then
                                    settings.Farm = 0
                                    settings.Convert = 1
                                elseif currNum == 0 then
                                    settings.Farm = 1
                                    settings.Convert = 0
                                end
                            end
                        end
                    end

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
                                    if not settings.Running or settings.Farm == 0 then break end
                                    humanoid:MoveTo(basePos + Vector3.new(math.random(-12, 12), 0, math.random(-12, 12)))
                                    humanoid.MoveToFinished:Wait()
                                end
                            end
                        end

                    elseif settings.Farm == 0 and settings.Convert == 1 then
                        local targetHive = HiveCoords[settings.HiveSlot] or HiveCoords[1]
                        hrp.CFrame = CFrame.new(targetHive)
                        task.wait(3)
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
