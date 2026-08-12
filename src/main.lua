-- [[ BEE SWARM ULTIMATE MACRO - MAIN LOADER ]]
-- Coordinates all modules and runs the core background loop

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

print("[Main] Initializing Bee Swarm Ultimate Macro...")

-- 1. Создаем глобальную таблицу настроек и состояния макроса
getgenv().MacroSettings = {
    Running = true,
    CurrentField = "Pine Tree Field",
    PollenCurrent = 0,
    PollenMax = 1080640,
    BackpackFull = false,
    BlackScreen = false,
    CurrentState = "Initializing...",
    WebhookUrl = "",
    Priorities = {
        Gathering = true,
        AutoDispenser = true,
        Boosting = true
    }
}

-- 2. Функция безопасной загрузки модулей с твоего GitHub
local function LoadModule(moduleName)
    local owner = LocalPlayer.Name -- Автоматически подставляет твой ник на GitHub
    local url = string.format("https://raw.githubusercontent.com/%s/bee-swarm-macro/main/src/modules/%s.lua", owner, moduleName)
    
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    
    if success and result then
        print(string.format("[Main] Module '%s' successfully loaded!", moduleName))
        return result
    else
        warn(string.format("[Main] Failed to load module '%s': %s", moduleName, tostring(result)))
        return nil
    end
end

-- 3. Загружаем остальные компоненты макроса
local UtilsModule = LoadModule("utils")
local WebhookModule = LoadModule("webhooks")
local LogicModule = LoadModule("logic")
local GuiModule = LoadModule("gui")

-- 4. Инициализация графического интерфейса
if GuiModule and type(GuiModule.Setup) == "function" then
    pcall(function()
        GuiModule:Setup()
    end)
end

-- 5. Главный фоновый цикл макроса (работает пока Running = true)
task.spawn(function()
    while task.wait(1) do
        local settings = getgenv().MacroSettings
        if settings and settings.Running then
            
            -- Выполняем основную логику из модуля logic.lua
            if LogicModule and type(LogicModule.RunQueue) == "function" then
                pcall(function()
                    LogicModule:RunQueue()
                end)
            end

        end
    end
    print("[Main] Macro background loop stopped.")
end)

print("[Main] Macro fully loaded and operational!")
