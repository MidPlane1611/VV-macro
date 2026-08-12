local MiniUI = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

function MiniUI:Create(mainFrameCallback)
    if PlayerGui:FindFirstChild("VVMacroMiniGui") then
        PlayerGui.VVMacroMiniGui:Destroy()
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

    toggleButton.MouseButton1Click:Connect(function()
        if mainFrameCallback then
            mainFrameCallback()
        end
    end)
end

return MiniUI
