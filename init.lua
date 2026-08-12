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
mainGui.Parent = PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 380)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false
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
titleLabel.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(0.9, 0, 0, 45)
startButton.Position = UDim2.new(0.05, 0, 0.8, 0)
startButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
startButton.Text = "START MACRO"
startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
startButton.TextSize = 14
startButton.Font = Enum.Font.GothamBold
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
                    ["Dandelion Field"] = Vector3.new(-75, 4, 185)
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
