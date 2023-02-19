local testGame = class('testGame')
local timer = require('timer')

function testGame:initialize()
    self.gameCompleted = false
    self.timer = timer:new(3)
    self.text = "DO ABSOLUTELY NOTHING"
    self.displayedFinishText = false
end

function testGame:update(dt)
    self.timer:update(dt)
    if self.timer:hasFinished() then
        if not self.displayedFinishText then
            self.timer = timer:new(1)
            self.text = "WELL DONE!!!"
            self.displayedFinishText = true
        else
            self.gameCompleted = true
        end
    end
end

function testGame:draw()
    love.graphics.print(self.timer.count, 0, 0)
    love.graphics.print(self.text, 400, 300)
end

return testGame
