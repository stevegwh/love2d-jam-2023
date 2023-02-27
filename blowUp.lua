local timer = require 'timer'
local blowUp = class('blowup')

function blowUp:initialize()
    self.balloon = {
        sprite = love.graphics.newImage('img/dvdheart.png'),
        scale = 0.1,
        minScale = 0.5,
        maxScale = 1.5
    }
    self.mouseDown = false
    self.gameCompleted = false
    self.gameFail = false
    self.gameSucceed = false
    self.timerMax = 8
    self.timer = timer:new(8)
end

function blowUp:update(dt)
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

    self.balloon.scale = self.balloon.scale - 0.2 * dt
    if self.balloon.scale < self.balloon.minScale then
        self.balloon.scale = self.balloon.minScale
    end
    if love.mouse.isDown(1) and not self.mouseDown then
        self.mouseDown = true
        self.balloon.scale = self.balloon.scale + 30 * dt
    end
    if not love.mouse.isDown(1) then
        self.mouseDown = false
    end
    if self.balloon.scale > self.balloon.maxScale then
        self:gameWin()
    end
end

function blowUp:gameWin()
    self.gameSucceed = true
    self.timer = timer:new(2)
end

function blowUp:gameOver()
    self.gameFail = true
    self.timer = timer:new(2)
end

function blowUp:draw()
    love.graphics.setBackgroundColor(1, 0.5, 1)
    love.graphics.setColor(0, 0, 0)
    if self.gameFail then
        love.graphics.print("FAILED!", 450, 300)
    elseif self.gameSucceed then
        love.graphics.print("SUCCESS!", 450, 300)
    else
        
          -- Draw the collision area (for debugging purposes only)
        --love.graphics.rectangle("fill", collision_area.x, collision_area.y, collision_area.width, collision_area.height + 8)
        
        love.graphics.print(self.timerMax - math.floor(self.timer.count), 0, 0)
        love.graphics.print("BLOW UP THE BALLOON!", 450, 100)
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.balloon.sprite, love.graphics.getWidth()/2 - self.balloon.sprite:getWidth()/2, love.graphics.getHeight()/3*2 - self.balloon.sprite:getHeight()/2, 0, self.balloon.scale, self.balloon.scale)
        --love.graphics.draw(self.phoneSprite, love.graphics:getWidth()/2 - self.phoneSprite:getWidth()*3, -self.phoneSprite:getHeight()*5, 0, 6, 6)
    end

end

return blowUp
