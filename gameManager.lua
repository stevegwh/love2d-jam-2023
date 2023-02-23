local cableGame = require 'cableGame'
local catGame = require 'catGame'
--local testGame = require 'testGame'
local dvdBounce = require 'dvdBounce'
local gameManager = class('gameManager')

function gameManager:initialize()
    self.allMiniGames = {dvdBounce, cableGame, catGame}
    self.currentMiniGame = self:getRandomMiniGame()
    self.catGame = catGame:new()
end

function gameManager:getRandomMiniGame()
    return self.allMiniGames[math.random(#self.allMiniGames)]:new()
end

function gameManager:update(dt)
    if self.currentMiniGame.gameCompleted then
        self.currentMiniGame = self:getRandomMiniGame()
    end
    self.currentMiniGame:update(dt)
end

function gameManager:draw()
   self.currentMiniGame:draw()
end

return gameManager
