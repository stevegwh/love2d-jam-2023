local cableGame = require 'cableGame'
local testGame = require 'testGame'

local gameManager = class('gameManager')

function gameManager:initialize()
    self.allMiniGames = {cableGame, testGame}
    self.currentMiniGame = self:getRandomMiniGame()
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
