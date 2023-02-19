local testGame = class('testGame')
local timer = require('timer')

function testGame:initialize()
    self.gameCompleted = false
    self.timer = timer:new(1)
end

function testGame:update(dt)
    self.timer:update(dt)
    if self.timer:hasFinished() then
        self.gameCompleted = true
    end
end

function testGame:draw()
    love.graphics.print(self.timer.count, 0, 0)
    love.graphics.print("Game 2 >:3!! ", 400, 300)
end

return testGame
