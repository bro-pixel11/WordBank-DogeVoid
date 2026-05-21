local url = "https://raw.githubusercontent.com/bro-pixel11/WordBank-DogeVoid/main/script.lua"

local success, result = pcall(function()
    return game:HttpGet(url)
end)

if not success then
    warn("Failed to load script")
    return
end

local func = loadstring(result)

if func then
    func()
else
    warn("Loadstring error")
end