-- [[ ADVANCED LOGIC MODULE ]]
-- Handles core macro tasks, priority queue, and state machine

local LogicModule = {}

function LogicModule:RunQueue()
    local settings = getgenv().MacroSettings
    if not settings or not settings.Running then return end

    -- Приоритет 1: Проверка диспенсеров и бустов
    self:CheckDispensers()

    -- Приоритет 2: Фарм пыльцы в выбранном поле
    self:GatherPollen()
end

function LogicModule:CheckDispensers()
    local settings = getgenv().MacroSettings
    -- Здесь логика таймеров диспенсеров (Treats, Royal Jelly, Honeystorm)
    settings.CurrentState = "Checking dispensers & boosts..."
end

function LogicModule:GatherPollen()
    local settings = getgenv().MacroSettings
    if not settings then return end

    -- Проверяем, полон ли рюкзак
    if settings.PollenCurrent < settings.PollenMax then
        -- Симуляция процесса сбора пыльцы в зависимости от выбранного поля
        local addAmount = 75000
        if settings.CurrentField == "Pine Tree Field" then
            addAmount = 95000
        elseif settings.CurrentField == "Coconut Field" then
            addAmount = 120000
        end

        settings.PollenCurrent = math.min(settings.PollenMax, settings.PollenCurrent + addAmount)
        settings.BackpackFull = false
        settings.CurrentState = "Farming pollen in " .. tostring(settings.CurrentField)
    else
        -- Рюкзак полон -> идем конвертировать к улью
        settings.BackpackFull = true
        settings.CurrentState = "Backpack Full! Converting honey at hive..."
        
        -- Симуляция конвертации
        task.wait(3)
        settings.PollenCurrent = 0
        settings.BackpackFull = false
        settings.CurrentState = "Resuming farm..."
    end
end

return LogicModule
