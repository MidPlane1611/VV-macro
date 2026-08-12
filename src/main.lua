-- [[ BEE SWARM ULTIMATE MACRO - MAIN.LUA ]]
-- Modular Architecture Loader with Auto-Detection

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Базовые настройки макроса
getgenv().MacroSettings = {
    Running = true,
    CurrentState = "Initializing...",
    PollenCurrent = 0,
    PollenMax = 1080640,
    BackpackFull = false,
    CurrentField = "Pine Tree Field",
    WebhookUrl = ""
}

print("[Macro] Initializing core systems...")

-- Автоматическое определение GitHub-пользователя (если ник в Roblox совпадает с GitHub)
-- Если твой ник на GitHub отличается, замени LocalPlayer.Name на "ТвойНикНаGitHub" в кавычках
local GITHUB_USER = LocalPlayer.Name 
local REPO_NAME = "bee-swarm-macro"

local BASE_URL = string.format("https://raw.githubusercontent.com/%s/%s/main/src/modules/", GITHUB_USER, REPO_NAME)

-- Безопасная загрузка модулей
local success, GUI = pcall(function()
    return loadstring(game:HttpGet(BASE_URL .. "gui.lua"))()
end)

local successLogic, Logic = pcall(function()
    return loadstring(game:HttpGet(BASE_URL .. "logic.lua"))()
end)

local successWebhooks, Webhooks = pcall(function()
    return loadstring(game:HttpGet(BASE_URL .. "webhooks.lua"))()
end)

local successUtils, Utils = pcall(function()
    return loadstring(game:HttpGet(BASE_URL .. "utils.lua"))()
end)

-- Инициализация интерфейса
if success and GUI then
    print("[Macro] GUI Module Loaded Successfully.")
    GUI:Setup()
else
    warn("[Macro] Failed to load GUI module!")
end

-- Отправка стартового уведомления в Discord
if successWebhooks and Webhooks then
    print("[Macro] Webhook Module Loaded Successfully.")
    Webhooks:Send("🚀 Macro successfully loaded and initialized on a new server! Hive claimed.")
end

-- Основной цикл работы макроса (каждые 5 секунд)
task.spawn(function()
    while task.wait(5) do
        if MacroSettings.Running then
            -- Динамическое обновление статуса в Discord
            if Webhooks then
                Webhooks:UpdateStatus()
            end
            
            -- Выполнение логики (приоритеты: Диспенсеры -> Бусты -> Фарм)
            if Logic then
                Logic:RunQueue()
            end
        end
    end
end)

print("[Macro] Main script fully executed!")
