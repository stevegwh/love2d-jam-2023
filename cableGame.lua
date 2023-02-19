local cableGame = class('cableGame')
local timer = require('timer')

function cableGame:initialize()
    self.gameCompleted = false
    self.timer = timer:new(1)
end

function cableGame:update(dt)
    self.timer:update(dt)
    if self.timer:hasFinished() then
        self.gameCompleted = true
    end
end

function cableGame:draw()
    love.graphics.print(self.timer.count, 0, 0)
    love.graphics.print("Game 1 >:3!! ", 400, 300)
end

return cableGame
