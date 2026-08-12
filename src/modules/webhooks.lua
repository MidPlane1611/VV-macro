-- [[ ADVANCED WEBHOOK MODULE ]]
-- Handles rich Discord embeds and real-time status updates

local HttpService = game:GetService("HttpService")
local WebhookModule = {}

function WebhookModule:Send(content)
    local url = getgenv().MacroSettings and getgenv().MacroSettings.WebhookUrl
    if not url or url == "" then return end
    
    local data = {
        ["embeds"] = {{
            ["title"] = "🐝 Bee Swarm Macro Notification",
            ["description"] = content,
            ["color"] = 65280, -- Зеленый цвет
            ["footer"] = {["text"] = "Bee Swarm Ultimate Macro v1.0"}
        }}
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

function WebhookModule:UpdateStatus()
    local url = getgenv().MacroSettings and getgenv().MacroSettings.WebhookUrl
    if not url or url == "" then return end

    local settings = getgenv().MacroSettings
    local pollenPercent = math.floor((settings.PollenCurrent / settings.PollenMax) * 100)
    
    local data = {
        ["embeds"] = {{
            ["title"] = "📊 Macro Live Status Tracker",
            ["color"] = 3447003, -- Синий цвет
            ["fields"] = {
                {["name"] = "Current Field", ["value"] = tostring(settings.CurrentField), ["inline"] = true},
                {["name"] = "Pollen Progress", ["value"] = string.format("%d / %d (%d%%)", settings.PollenCurrent, settings.PollenMax, pollenPercent), ["inline"] = true},
                {["name"] = "Backpack Status", ["value"] = settings.BackpackFull and "🔴 Full (Converting)" : "🟢 Collecting", ["inline"] = false}
            },
            ["footer"] = {["text"] = "Auto-updated every 5 seconds"}
        }}
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
