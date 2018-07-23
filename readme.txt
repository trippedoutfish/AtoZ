A-to-Z Game
-----------
This is a very basic A to Z game addon, allowing for play in guild chat by default. 
It uses a list of several thousand commonly used english words. 
If you change the code to talk outside of guild, please be kind to the people around you that may not want to play.


Starting a game
----------------
Type a2z start in chat.

Get current words status of a game
----------------
type a2z status

Stopping a game 
----------------
Type a2z fail in chat.


Configuring for non guild chat
-------------------------------
Open AtoZ.lua and locate the lines below:
frame:RegisterEvent("CHAT_MSG_GUILD")
SendChatMessage(text, "GUILD")

Change CHAT_MSG_GUILD to one of the following:
CHAT_MSG_PARTY
CHAT_MSG_SAY
CHAT_MSG_RAID

Change GUILD to one of the following that goes with the previous change:
PARTY
SAY
RAID

That is it! It likely works in other channels as well, but has only been tested in say and guild. 
Any words added to the wordlist must be in alphabetical order.