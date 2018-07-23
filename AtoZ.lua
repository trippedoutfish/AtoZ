local AtoZ = {
    word = '',
}
AtoZ.__index = AtoZ

local __atoz = {}
setmetatable(__atoz, AtoZ)
local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function(_, _, text, playerName)
    __atoz:onGuildMessage(text, playerName)
end)
frame:RegisterEvent("CHAT_MSG_GUILD")

function AtoZ:spam(text)
    SendChatMessage(text, "GUILD")
end

function AtoZ:onGuildMessage(message, author)
    if message == 'a2z start' then
        self:startGame()
    elseif message == 'a2z status' then
        self:announceStatus()
    elseif message == 'a2z fail' then
        self:failGame()
    elseif not message:find(' ') then
        self:guess(message:lower(), author)
    end
end

function AtoZ:startGame()
    local choice = math.floor(math.random() * (table.getn(AtoZ_Words) - 2) + 2)
    self.word = AtoZ_Words[choice]
    self.top = 1
    self.bottom = table.getn(AtoZ_Words)
    self:announceStatus()
end

function AtoZ:failGame()
    self:spam("- Game Cancelled! The Word was " .. self.word)
    self.word = ''
end

function AtoZ:announceStatus()
    local top = AtoZ_Words[self.top]
    local bottom = AtoZ_Words[self.bottom]
    self:spam("- Guess the word between " .. top .. " - " .. bottom)
end

function AtoZ:guess(message, author)
    if self.word == '' then return end
    if message == self.word then
        self:spam("- " .. author .. " wins!  The word was " .. self.word)
        self.word = ''
    else
        local top = AtoZ_Words[self.top]
        local bottom = AtoZ_Words[self.bottom]
        if message > top and message < bottom then
            local idx = self:findWord(message)
            if idx == 0 then
                self:spam("- " .. message .. " is not a recognised word, Guess the word between " .. top .. " - " .. bottom)
            else
                if message < self.word then
                    self.top = idx
                else
                    self.bottom = idx
                end
                self:announceStatus()
            end
        elseif message < top or message > bottom then
            self:spam("- " .. message .. " is not between " .. top .. " - " .. bottom .. ", Guess again")
        elseif message == top or message == bottom then
            self:spam("- " .. message .. " is a current word, Guess between " .. top .. " - " .. bottom)
        end
    end
end

function AtoZ:findWord(seeking)
    for idx, word in ipairs(AtoZ_Words) do
        if word == seeking then return idx end
    end
    return 0
end
