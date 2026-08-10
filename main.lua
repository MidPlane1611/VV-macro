-- Замени ссылки ниже на свои реальные Raw-ссылки с GitHub после загрузки файлов
local settingsUrl = "https://raw.githubusercontent.com/MidPlane1611/VV-macro/refs/heads/main/settings.lua"
local guiUrl = "https://raw.githubusercontent.com/MidPlane1611/VV-macro/refs/heads/main/gui%2Clua"

local successSettings, Settings = pcall(function()
    return loadstring(game:HttpGet(settingsUrl))()
end)

local successGui, Gui = pcall(function()
    return loadstring(game:HttpGet(guiUrl))()
end)

if successSettings and successGui then
    print("DeathNote V GUI: Всё успешно запущенно!")
else
    warn("DeathNote V GUI: Ошибка загрузки файлов.")
end
