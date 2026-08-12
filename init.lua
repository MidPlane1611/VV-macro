getgenv().MacroSettings = {
    Running = false,
    CurrentField = "Dandelion Field",
    FarmType = "Random",
    BackpackMethod = "Convert Hive",
    HiveSlot = 1,
    Farm = 1,
    Convert = 0
}

local MiniUI = loadstring(readfile("src/ui/mini.lua"))()
local MainUI = loadstring(readfile("src/ui/main.lua"))()

local mainFrame = MainUI:Create()

MiniUI:Create(function()
    mainFrame.Visible = not mainFrame.Visible
end)
