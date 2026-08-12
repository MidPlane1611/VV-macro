-- [[ WEBHOOK MODULE ]]
-- Handles Discord notifications and real-time status updates

local HttpService = game:GetService("HttpService")
local WebhookModule = {}

-- Функция отправки обычного сообщения
function WebhookModule:Send(content)
    local url = getgenv().MacroSettings and getgenv().MacroSettings.WebhookUrl
    if not url or url == "" then return end
    
    local data = {
        ["content"] = content
    }
    
    pcall(function()
        request({
            Url = url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(data)
        })
    end)
end

-- Функция динамического обновления статуса (информация о фарме и рюкзаке)
function WebhookModule:UpdateStatus()
    local url = getgenv().MacroSettings and getgenv().MacroSettings.WebhookUrl
    if not url or url == "" then return end

    local settings = getgenv().MacroSettings
    local pollenPercent = math.floor((settings.PollenCurrent / settings.PollenMax) * 100)
    
    local statusText = string.format("```ansi\n\27[36m[STATUS]\27[0m Field: %s | Pollen: %d/%d (%d%%) | Backpack Full: %s\n```",
        settings.CurrentField,
        settings.PollenCurrent,
        settings.PollenMax,
        pollenPercent,
        tostring(settings.BackpackFull)
    )

    local data = {
        ["content"] = statusText
    }

    pcall(function()
        request({
            Url = url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(data)
        })
    end)
end

return WebhookModule
