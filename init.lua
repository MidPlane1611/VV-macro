getgenv().MacroSettings = {
    Running = false,
    CurrentField = "Dandelion Field",
    FarmType = "Random",
    BackpackMethod = "Convert Hive",
    HiveSlot = 1
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("VVMacroMiniGui") then
    PlayerGui.VVMacroMiniGui:Destroy()
end
if PlayerGui:FindFirstChild("VVMacroMainGui") then
    PlayerGui.VVMacroMainGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VVMacroMiniGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local toggleButton = Instance.new("ImageButton")
toggleButton.Name = "ToggleMainGuiBtn"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 20, 0, 150)
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.BackgroundTransparency = 0.2
toggleButton.Image = "rbxassetid://112576205931289"
toggleButton.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = toggleButton

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(255, 215, 0)
uiStroke.Thickness = 2
uiStroke.Parent = toggleButton

local mainGui = Instance.new("ScreenGui")
mainGui.Name = "VVMacroMainGui"
mainGui.ResetOnSpawn = false
mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
mainGui.Parent = PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 340, 0, 420)
mainFrame.Position = UDim2.new(0.5, -170, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false
mainFrame.ZIndex = 10
mainFrame.Parent = mainGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(60, 60, 60)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "VV MACRO"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.ZIndex = 11
titleLabel.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.ZIndex = 11
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Выбор полей
local fields = {
    "Dandelion Field", "Sunflower Field", "Mushroom Field", "Blue Flower Field",
    "Clover Field", "Spider Field", "Strawberry Field", "Bamboo Field",
    "Pineapple Patch", "Stump Field", "Cactus Field", "Pumpkin Patch",
    "Pine Tree Forest", "Rose Field", "Mountain Top Field", "Coconut Field"
}
local fieldIndex = 1

local fieldBtn = Instance.new("TextButton")
fieldBtn.Size = UDim2.new(0.9, 0, 0, 35)
fieldBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
fieldBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
fieldBtn.Text = "Field: Dandelion Field"
fieldBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
fieldBtn.TextSize = 13
fieldBtn.Font = Enum.Font.Gotham
fieldBtn.ZIndex = 11
fieldBtn.Parent = mainFrame

local fCorner = Instance.new("UICorner")
fCorner.CornerRadius = UDim.new(0, 6)
fCorner.Parent = fieldBtn

fieldBtn.MouseButton1Click:Connect(function()
    fieldIndex = fieldIndex % #fields + 1
    local newField = fields[fieldIndex]
    getgenv().MacroSettings.CurrentField = newField
    fieldBtn.Text = "Field: " .. newField
end)

-- Выбор типа фарма (Random / Token Collector)
local farmTypes = {"Random", "Token Collector"}
local farmTypeIndex = 1

local farmTypeBtn = Instance.new("TextButton")
farmTypeBtn.Size = UDim2.new(0.9, 0, 0, 35)
farmTypeBtn.Position = UDim2.new(0.05, 0, 0.28, 0)
farmTypeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
farmTypeBtn.Text = "Farm Type: Random"
farmTypeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
farmTypeBtn.TextSize = 13
farmTypeBtn.Font = Enum.Font.Gotham
farmTypeBtn.ZIndex = 11
farmTypeBtn.Parent = mainFrame

local ftCorner = Instance.new("UICorner")
ftCorner.CornerRadius = UDim.new(0, 6)
ftCorner.Parent = farmTypeBtn

farmTypeBtn.MouseButton1Click:Connect(function()
    farmTypeIndex = farmTypeIndex % #farmTypes + 1
    local newType = farmTypes[farmTypeIndex]
    getgenv().MacroSettings.FarmType = newType
    farmTypeBtn.Text = "Farm Type: " .. newType
end)

-- Выбор метода переработки (Convert Hive / Reset)
local backpackMethods = {"Convert Hive", "Reset"}
local methodIndex = 1

local methodBtn = Instance.new("TextButton")
methodBtn.Size = UDim2.new(0.9, 0, 0, 35)
methodBtn.Position = UDim2.new(0.05, 0, 0.44, 0)
methodBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
methodBtn.Text = "Backpack Method: Convert Hive"
methodBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
methodBtn.TextSize = 13
methodBtn.Font = Enum.Font.Gotham
methodBtn.ZIndex = 11
methodBtn.Parent = mainFrame

local mCorner = Instance.new("UICorner")
mCorner.CornerRadius = UDim.new(0, 6)
mCorner.Parent = methodBtn

methodBtn.MouseButton1Click:Connect(function()
    methodIndex = methodIndex % #backpackMethods + 1
    local newMethod = backpackMethods[methodIndex]
    getgenv().MacroSettings.BackpackMethod = newMethod
    methodBtn.Text = "Backpack Method: " .. newMethod
end)

-- Выбор слота улья (1 - 6)
local hiveSlotBtn = Instance.new("TextButton")
hiveSlotBtn.Size = UDim2.new(0.9, 0, 0, 35)
hiveSlotBtn.Position = UDim2.new(0.05, 0, 0.60, 0)
hiveSlotBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
hiveSlotBtn.Text = "Hive Slot: 1"
hiveSlotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hiveSlotBtn.TextSize = 13
hiveSlotBtn.Font = Enum.Font.Gotham
hiveSlotBtn.ZIndex = 11
hiveSlotBtn.Parent = mainFrame

local hCorner = Instance.new("UICorner")
hCorner.CornerRadius = UDim.new(0, 6)
hCorner.Parent = hiveSlotBtn

hiveSlotBtn.MouseButton1Click:Connect(function()
    local currentSlot = getgenv().MacroSettings.HiveSlot
    currentSlot = currentSlot % 6 + 1
    getgenv().MacroSettings.HiveSlot = currentSlot
    hiveSlotBtn.Text = "Hive Slot: " .. currentSlot
end)

-- Кнопка старт/стоп
local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(0.9, 0, 0, 45)
startButton.Position = UDim2.new(0.05, 0, 0.78, 0)
startButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
startButton.Text = "START MACRO"
startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
startButton.TextSize = 14
startButton.Font = Enum.Font.GothamBold
startButton.ZIndex = 11
startButton.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = startButton

toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

startButton.MouseButton1Click:Connect(function()
    local settings = getgenv().MacroSettings
    if settings then
        settings.Running = not settings.Running
        if settings.Running then
            startButton.Text = "STOP MACRO"
            startButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
            task.spawn(function()
                local FieldData = {
                    ["Dandelion Field"] = Vector3.new(-75, 4, 185),
                    ["Sunflower Field"] = Vector3.new(-200, 4, 160),
                    ["Mushroom Field"] = Vector3.new(-105, 4, 45),
                    ["Blue Flower Field"] = Vector3.new(115, 4, 130),
                    ["Clover Field"] = Vector3.new(170, 32, 190),
                    ["Spider Field"] = Vector3.new(-55, 18, -20),
                    ["Strawberry Field"] = Vector3.new(-180, 20, -10),
                    ["Bamboo Field"] = Vector3.new(145, 20, -5),
                    ["Pineapple Patch"] = Vector3.new(260, 68, -195),
                    ["Stump Field"] = Vector3.new(437, 98, -175),
                    ["Cactus Field"] = Vector3.new(-195, 68, -110),
                    ["Pumpkin Patch"] = Vector3.new(180, 68, -110),
                    ["Pine Tree Forest"] = Vector3.new(-325, 68, -175),
                    ["Rose Field"] = Vector3.new(-130, 4, -135),
                    ["Mountain Top Field"] = Vector3.new(75, 176, -165),
                    ["Coconut Field"] = Vector3.new(-265, 72, 460)
                }
                while settings.Running do
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    local currentField = settings.CurrentField
                    local basePos = FieldData[currentField] or Vector3.new(0, 0, 0)
                    
                    if humanoid then
                        if settings.FarmType == "Random" then
                            for x = -12, 12, 3 do
                                for z = -12, 12, 3 do
                                    if not settings.Running then break end
                                    humanoid:MoveTo(basePos + Vector3.new(math.random(-6, 6), 0, math.random(-6, 6)))
                                    humanoid.MoveToFinished:Wait()
                                end
                            end
                        else
                            for x = -12, 12, 3 do
                                for z = -12, 12, 3 do
                                    if not settings.Running then break end
                                    humanoid:MoveTo(basePos + Vector3.new(x, 0, z))
                                    humanoid.MoveToFinished:Wait()
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
    end
end)
