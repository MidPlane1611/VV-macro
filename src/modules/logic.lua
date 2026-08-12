-- [[ LOGIC MODULE ]]
-- Handles core macro tasks, priority queue, dispensers, and farming loop

local LogicModule = {}

-- Главная очередь приоритетов (вызывается каждые 5 секунд из main.lua)
function LogicModule:RunQueue()
    local settings = getgenv().MacroSettings
    if not settings or not settings.Running then return end

    -- Шаг 1: Проверка и сбор с диспенсеров (Treat Dispenser, Royal Jelly Dispenser и т.д.)
    self:CheckDispensers()

    -- Шаг 2: Проверка бустов и полей
    self:CheckBoosts()

    -- Шаг 3: Основной фарм пыльцы
    self:GatherPollen()
end

-- Логика диспенсеров
function LogicModule:CheckDispensers()
    -- Здесь в будущем будет код взаимодействия с объектами на базе (Hive)
    -- print("[Logic] Checking dispensers...")
end

-- Логика бустов
function LogicModule:CheckBoosts()
    -- Здесь в будущем будет код для использования предметов или активации полей
    -- print("[Logic] Checking active boosts...")
end

-- Логика фарма пыльцы
function LogicModule:GatherPollen()
    local settings = getgenv().MacroSettings
    if not settings then return end

    -- Симуляция процесса фарма для демонстрации работы системы
    if settings.PollenCurrent < settings.PollenMax then
        settings.PollenCurrent = math.min(settings.PollenMax, settings.PollenCurrent + 65000)
        settings.BackpackFull = false
        settings.CurrentState = "Gathering pollen in " .. tostring(settings.CurrentField)
    else
        settings.BackpackFull = true
        settings.CurrentState = "Backpack Full! Converting at Hive..."
        
        -- Здесь будет триггер возврата к улью
        -- task.wait(5) -- имитация конвертации
        settings.PollenCurrent = 0 -- сброс после конвертации
    end
end

return LogicModule
