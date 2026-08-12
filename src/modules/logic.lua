local Logic = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local FieldData = {
    ["Dandelion Field"] = Vector3.new(-75, 4, 185)
}

function Logic:GetCoreStats()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        local coreStats = playerGui:FindFirstChild("CoreStats")
        if coreStats then
            local pollen = coreStats:FindFirstChild("Pollen")
            local capacity = coreStats:FindFirstChild("Capacity")
            if pollen and capacity then
                return pollen.Value, capacity.Value
            end
        end
    end
    return 0, 100
end

function Logic:WalkTo(targetPosition)
    local humanoid = Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:MoveTo(targetPosition)
        humanoid.MoveToFinished:Wait()
    end
end

function Logic:FarmSquare(centerPos)
    local size = 12
    local step = 3
    for x = -size, size, step do
        for z = -size, size, step do
            local settings = getgenv().MacroSettings
            if not settings or not settings.Running then return end
            
            local offset = Vector3.new(x, 0, z)
            self:WalkTo(centerPos + offset)
            task.wait(0.2)
        end
    end
end

function Logic:RunGather()
    local settings = getgenv().MacroSettings
    if not settings then return end

    local currentField = settings.CurrentField
    local basePos = FieldData[currentField] or FieldData["Dandelion Field"]

    local pollen, capacity = self:GetCoreStats()
    if pollen >= capacity then
        print("[Logic] Backpack is full! Returning to hive...")
        self:WalkTo(Vector3.new(0, 0, 0)) -- Здесь будет позиция улья
        task.wait(3)
        return
    end

    print("[Logic] Farming field: " .. currentField)
    self:FarmSquare(basePos)
end

return Logic
