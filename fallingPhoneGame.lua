local fallingPhoneGame = class('fallingPhoneGame')
local timer = require('timer')

function fallingPhoneGame:initialize()
    self.cushion = {
        pos = {x = 500, y = 500},
        moveSpeed = 700,
        spacePressed = false,
        sprite = love.graphics.newImage('img/cushion.png')
    }
    self.gameCompleted = false
    self.gameFail = false
    self.gameSucceed = false
    self.timer = timer:new(10000)
    self.phone =  {
        pos = {x = 0, y = 0},
        sprite = love.graphics.newImage('img/phone2.png')
    }
    self.phone.pos.x = math.random(self.phone.sprite:getWidth(), love.graphics:getWidth() - self.phone.sprite:getWidth())
    self.phone.pos.y = self.phone.sprite:getHeight()*2

end

function fallingPhoneGame:checkCollision()
    local a = self.cushion
    local b = self.phone
    return  a.pos.x < b.pos.x + b.sprite:getWidth() and
            b.pos.x < a.pos.x + a.sprite:getWidth() and
            a.pos.y < b.pos.y + b.sprite:getHeight() and
            b.pos.y < a.pos.y + a.sprite:getHeight()
end

function fallingPhoneGame:update(dt)
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

    if self.timer.count > 2 then
        self.phone.pos.y = self.phone.pos.y - 3
    end

    local phonePositionPositive = self.phone.pos.y * -1
    if phonePositionPositive > love.graphics:getHeight() then
        self:gameOver()
    end

    print(self:checkCollision())
    if self:checkCollision() then
        self:gameWin()
    end


    if love.keyboard.isDown("right") and self.cushion.pos.x < (love.graphics:getWidth() - (self.cushion.sprite:getWidth()*4)) then
        self.cushion.pos.x = self.cushion.pos.x + 5
        end
    if love.keyboard.isDown("left") and self.cushion.pos.x > self.cushion.sprite:getWidth() then
        self.cushion.pos.x = self.cushion.pos.x - 5
    end
end

function fallingPhoneGame:gameOver()
    self.gameFail = true
    self.timer = timer:new(2)
end

function fallingPhoneGame:gameWin()
    self.gameSucceed = true
    self.timer = timer:new(2)
end

function fallingPhoneGame:draw()
    love.graphics.setBackgroundColor(0, 0.2, 1)
    if self.gameFail then
        love.graphics.print("FAILED!", 450, 300)
    elseif self.gameSucceed then
        love.graphics.print("SUCCEED!", 450, 300)
    else
        love.graphics.setColor(0.8, 0.8, 0.8)
          -- Draw the collision area (for debugging purposes only)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(self.timer.count, 0, 0)
        love.graphics.print("CATCH THE PHONE!", 450, 300)
        love.graphics.draw(self.cushion.sprite, self.cushion.pos.x, self.cushion.pos.y, 0, 4, 4)
        love.graphics.draw(self.phone.sprite, self.phone.pos.x, -self.phone.pos.y, 0, 4, 4)
    end
end

return fallingPhoneGame
