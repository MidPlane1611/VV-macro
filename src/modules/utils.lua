-- [[ UTILS MODULE ]]
-- Handles FPS optimization, Black Screen, and Server Rejoin/Hop

local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local UtilsModule = {}

-- Управление режимом Черного Экрана (отключение 3D рендеринга для экономии ресурсов)
function UtilsModule:ToggleBlackScreen(state)
    pcall(function()
        RunService:Set3dRenderingEnabled(not state)
        if state then
            print("[Utils] Black Screen Enabled: FPS Optimized")
        else
            print("[Utils] Black Screen Disabled: Normal Rendering")
        end
    end)
end

-- Функция перезахода на тот же сервер (Rejoin)
function UtilsModule:RejoinServer()
    print("[Utils] Rejoining server...")
    pcall(function()
        if #Players:GetPlayers() <= 1 then
            LocalPlayer:Kick("\n[Macro] Rejoining...")
            task.wait(1)
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    end)
end

-- Функция смены сервера (Server Hop)
function UtilsModule:ServerHop()
    print("[Utils] Hopping to a new server...")
    pcall(function()
        -- Используем публичное API для поиска свободного сервера
        local serversUrl = string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100", game.PlaceId)
        local success, result = pcall(function()
            return game:HttpGet(serversUrl)
        end)
        
        if success then
            local HttpService = game:GetService("HttpService")
            local data = HttpService:JSONDecode(result)
            if data and data.data then
                for _, server in ipairs(data.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                        return
                    end
                end
            end
        end
        
        -- Запасной вариант, если список серверов не загрузился
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
end

return UtilsModule
