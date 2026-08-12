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
mainFrame.Size = UDim2.new(0, 300, 0, 260)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -130)
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

local fieldLabel = Instance.new("TextLabel")
fieldLabel.Size = UDim2.new(0.9, 0, 0, 25)
fieldLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
fieldLabel.BackgroundTransparency = 1
fieldLabel.Text = "Field: Dandelion Field"
fieldLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fieldLabel.TextSize = 14
fieldLabel.Font = Enum.Font.Gotham
fieldLabel.TextXAlignment = Enum.TextXAlignment.Left
fieldLabel.ZIndex = 11
fieldLabel.Parent = mainFrame

local changeFieldBtn = Instance.new("TextButton")
changeFieldBtn.Size = UDim2.new(0.9, 0, 0, 40)
changeFieldBtn.Position = UDim2.new(0.05, 0, 0.32, 0)
changeFieldBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
changeFieldBtn.Text = "Change Field"
changeFieldBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
changeFieldBtn.TextSize = 14
changeFieldBtn.Font = Enum.Font.Gotham
changeFieldBtn.ZIndex = 11
changeFieldBtn.Parent = mainFrame

local fieldCorner = Instance.new("UICorner")
fieldCorner.CornerRadius = UDim.new(0, 8)
fieldCorner.Parent = changeFieldBtn

local fields = {"Dandelion Field", "Sunflower Field", "Mushroom Field"}
local fieldIndex = 1

changeFieldBtn.MouseButton1Click:Connect(function()
    fieldIndex = fieldIndex % #fields + 1
    local newField = fields[fieldIndex]
    getgenv().MacroSettings.CurrentField = newField
    fieldLabel.Text = "Field: " .. newField
end)

local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(0.9, 0, 0, 45)
startButton.Position = UDim2.new(0.05, 0, 0.65, 0)
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
                    ["Mushroom Field"] = Vector3.new(-105, 4, 45)
                }
                while settings.Running do
                    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    local currentField = settings.CurrentField
                    local basePos = FieldData[currentField] or FieldData["Dandelion Field"]
                    
                    if humanoid then
                        for x = -12, 12, 3 do
                            for z = -12, 12, 3 do
                                if not settings.Running then break end
                                humanoid:MoveTo(basePos + Vector3.new(x, 0, z))
                                humanoid.MoveToFinished:Wait()
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
