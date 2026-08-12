local MainUI = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

function MainUI:Create()
    if PlayerGui:FindFirstChild("VVMacroMainGui") then
        PlayerGui.VVMacroMainGui:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VVMacroMainGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 320, 0, 380)
    mainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.Visible = false
    mainFrame.Parent = screenGui

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

    startButton.MouseButton1Click:Connect(function()
        local settings = getgenv().MacroSettings
        if settings then
            settings.Running = not settings.Running
            if settings.Running then
                startButton.Text = "STOP MACRO"
                startButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
                task.spawn(function()
                    local Logic = loadstring(readfile("src/modules/logic.lua"))()
                    while settings.Running do
                        Logic:RunGather()
                        task.wait(0.1)
                    end
                end)
            else
                startButton.Text = "START MACRO"
                startButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            end
        end
    end)

    return mainFrame
end

return MainUI
