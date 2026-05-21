--[[
    WordBank-DogeVoid
    Probability-based Word Bomb auto search
]]

local wordsfile = nil
getgenv().deletewhendupefound = true

print("loading lib")

local lib = loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Lib-18698"))()

print("done loading lib")

lib.makelib("Word Bank DogeVoid")

local main = lib.maketab("Main")

local labelstatus = lib.makelabel("Loading words...", main)

pcall(function()
    wordsfile = readfile("ALLWORDSFILE.txt")
end)

local ALLWORDS = nil

if wordsfile ~= nil then
    ALLWORDS = wordsfile
    lib.updatelabel("Loaded local dictionary!", labelstatus)
else
    lib.updatelabel("Downloading dictionary...", labelstatus)

    ALLWORDS = game:HttpGet("https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt")

    writefile("ALLWORDSFILE.txt", ALLWORDS)
end

lib.updatelabel("Dictionary ready!", labelstatus)

local words = string.split(ALLWORDS, "\n")

local numtolongest = 1
local lettercap = math.huge
local autocopy = false
local lastcontains = ""

local labelword

lib.maketextbox("# Priority Word", main, function(num)
    numtolongest = tonumber(num) or 1
end)

lib.maketextbox("Letter Cap", main, function(num)
    lettercap = tonumber(num) or math.huge
end)

local function getProbability(word)
    local score = 0

    local rareLetters = {
        q = 15,
        z = 14,
        x = 13,
        j = 12,
        k = 8,
        v = 6
    }

    for i = 1, #word do
        local c = word:sub(i, i):lower()

        if rareLetters[c] then
            score += rareLetters[c]
        else
            score += 1
        end
    end

    score += (#word * 2)

    return score
end

function copyword(bruteforce)

    local gamecontainer =
        game.Players.LocalPlayer.PlayerGui.GameUI.Container.GameSpace.DefaultUI.GameContainer

    if #gamecontainer.DesktopContainer.InfoFrameContainer:GetChildren() > 0 then
        gamecontainer =
            gamecontainer.DesktopContainer.InfoFrameContainer.InfoFrame.TextFrame
    else
        gamecontainer =
            gamecontainer.Mobile.MobileContainer.InfoFrame.TextFrame
    end

    local contains = ""

    for i, v in pairs(gamecontainer:GetChildren()) do
        if v:FindFirstChild("Letter") and v.Visible == true then
            contains = contains .. v.Letter.TextLabel.Text
        end
    end

    contains = contains:lower()

    if lastcontains == contains and bruteforce == nil then
        return
    end

    lastcontains = contains

    local foundwords = {}

    for i, v in pairs(words) do
        if string.find(v:lower(), contains) and #v <= lettercap then
            table.insert(foundwords, v)
        end
    end

    table.sort(foundwords, function(a, b)
        return getProbability(a) > getProbability(b)
    end)

    local finalword = foundwords[numtolongest]

    if finalword then
        setclipboard(finalword)

        print(finalword)

        lib.updatelabel(
            finalword ..
            " | Prob: " ..
            tostring(getProbability(finalword)),
            labelword
        )
    else
        lib.updatelabel("Word Not Found", labelword)
    end
end

lib.makebutton("Copy Word", main, function()
    copyword(true)
end)

lib.maketoggle("Auto Copy Word", main, function(bool)
    autocopy = bool

    while autocopy do
        task.wait(0.15)

        pcall(function()
            copyword()
        end)
    end
end)

labelword = lib.makelabel("Waiting...", main)

lib.ondestroyedfunc = function()
    autocopy = false
end