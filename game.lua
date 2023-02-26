local timer = require 'timer'
local game = class('game')

function game:initialize(time)
    self.gameCompleted = false
    self.gameFail = false
    self.gameSucceed = false
    self.timerMax = time
    self.timer = timer:new(self.timerMax)
end

function game:update(dt)
    self.timer:update(dt)

    if self.gameFail or self.gameSucceed then
        if not self.timer:hasFinished() then
            return
        end
        self.gameCompleted = true
    end

    if self.timer:hasFinished() then
        self:gameOver()
    end
end

function game:pauseTimer(b)
    self.timer:pause(b)
end

function game:gameOver()
    self.gameFail = true
    self.timer = timer:new(2)
end

function game:gameWin()
    self.gameSucceed = true
    self.timer = timer:new(2)
end

return game