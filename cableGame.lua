local cableGame = class('cableGame')
local timer = require('timer')

function cableGame:initialize()
    self.gameCompleted = false
    self.timer = timer:new(3)
    self.defaultText = 'Game 1 >:3!! PRESS SPACE'
    self.text = self.defaultText
end

function cableGame:update(dt)
    self.timer:update(dt)
    if self.timer:hasFinished() then
        self.gameCompleted = true
    end

    if input:down('action') then
        self.text = 'SPACE PRESSED :D!!!'
    else
        self.text = self.defaultText
    end
end

function cableGame:draw()
    love.graphics.print(self.timer.count, 0, 0)
    love.graphics.print(self.text, 400, 300)
end

return cableGame
