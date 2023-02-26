local cableGame = require 'cableGame'
local fallingPhoneGame = require 'fallingPhoneGame'
local catGame = require 'catGame'
--local testGame = require 'testGame'
local dvdBounce = require 'dvdBounce'
local runningMan = require 'runningMan'
local blowUp = require 'blowUp'
local gameManager = class('gameManager')

function gameManager:initialize()
    --self.allMiniGames = {dvdBounce, cableGame, catGame, runningMan, fallingPhoneGame}
    self.allMiniGames = {blowUp}
    self.playedMiniGames = {}
    self.currentMiniGame = nil
    self:getRandomMiniGame()
    self.catGame = catGame:new()
end

function gameManager:getRandomMiniGame()
    if #self.allMiniGames == 0 then
        self.allMiniGames = self.playedMiniGames
        self.playedMiniGames = {}
    end
    local randNum = math.floor(math.random(#self.allMiniGames))
    self.currentMiniGame = self.allMiniGames[randNum]:new()
    table.insert(self.playedMiniGames, #self.playedMiniGames + 1, self.allMiniGames[randNum])
    table.remove(self.allMiniGames, randNum)
end

function gameManager:update(dt)
    if self.currentMiniGame.gameCompleted then
        self:getRandomMiniGame()
    end
    self.currentMiniGame:update(dt)
end

function gameManager:draw()
   self.currentMiniGame:draw()
end

return gameManager
