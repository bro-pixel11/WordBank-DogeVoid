--[[
    Word Bank DogeVoid
    Stable Probability Auto Search
]]

local wordsfile = nil
getgenv().deletewhendupefound = true

print("loading lib")

local lib =
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Lib-18698"))()

print("done loading lib")

lib.makelib("Word Bank DogeVoid")

local main = lib.maketab("Main")

local labelstatus =
lib.makelabel("Loading... (This may take ~1 minute)", main)

pcall(function()
    wordsfile = readfile("ALLWORDSFILE.txt")
end)

local ALLWORDS = nil

if wordsfile ~= nil then

    ALLWORDS = wordsfile

    lib.updatelabel(
        "Got Words from Workspace!",
        labelstatus
    )

else

    lib.updatelabel(
        "Loading Words from Internet",
        labelstatus
    )

    ALLWORDS =
    game:HttpGet(
        "https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt"
    )

    writefile("ALLWORDSFILE.txt", ALLWORDS)
end

lib.updatelabel("Done Loading!", labelstatus)

local words =
string.split(ALLWORDS, "\n")

local numtopick = 1

lib.maketextbox("# To Pick", main, function(num)
    numtopick = tonumber(num) or 1
end)

local lettercap = math.huge

lib.maketextbox("Letter Cap", main, function(num)
    lettercap = tonumber(num) or math.huge
end)

local lastcontains = ""
local labelword

local numclose = .001

local function probability(word)

    local score = 0

    local rare = {
        q = 25,
        z = 20,
        x = 18,
        j = 16,
        k = 12,
        v = 8
    }

    for i = 1, #word do

        local c =
        word:sub(i, i):lower()

        score += rare[c] or 1
    end

    score += #word * 2

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

    for i,v in pairs(gamecontainer:GetChildren()) do

        if v:FindFirstChild("Letter") and v.Visible == true then

            local lettercolor =
            v.Letter.ImageColor3

            local lettercolor2 =
            Color3.fromRGB(142,148,171)

            local lettercolor3 =
            Color3.fromRGB(129,156,255)

            if
            (
                math.abs(lettercolor.R - lettercolor2.R) < numclose
                and
                math.abs(lettercolor.G - lettercolor2.G) < numclose
                and
                math.abs(lettercolor.B - lettercolor2.B) < numclose
            )
            or
            (
                math.abs(lettercolor.R - lettercolor3.R) < numclose
                and
                math.abs(lettercolor.G - lettercolor3.G) < numclose
                and
                math.abs(lettercolor.B - lettercolor3.B) < numclose
            )
            then

                contains =
                contains .. v.Letter.TextLabel.Text
            end
        end
    end

    contains = contains:lower()

    if contains == "" then
        return
    end

    local finalword

    if lastcontains ~= contains or bruteforce then

        lastcontains = contains

        local foundwords = {}

        for i,v in pairs(words) do

            v = v:lower()

            if string.find(v, contains) and string.len(v) <= lettercap then
                table.insert(foundwords, v)
            end
        end

        table.sort(foundwords, function(a,b)

            return probability(a) > probability(b)

        end)

        finalword =
        foundwords[numtopick]

        if finalword then

            setclipboard(finalword)

            print(finalword)

            lib.updatelabel(
                finalword,
                labelword
            )

        else

            lib.updatelabel(
                "Word Not Found",
                labelword
            )
        end
    end
end

lib.makebutton("Search Word", main, function()
    copyword(true)
end)

local autocopy = false

lib.maketoggle("Auto Search", main, function(bool)

    autocopy = bool

    while autocopy do

        task.wait(.1)

        pcall(function()
            copyword()
        end)
    end
end)

labelword =
lib.makelabel("Word", main)

lib.ondestroyedfunc = function()
    autocopy = false
end