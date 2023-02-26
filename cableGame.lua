local cableGame = class('cableGame')
local timer = require('timer')

local collision_area = {x = love.graphics.getWidth()/2 - 50, y = 0, width = 100, height = 100}
function cableGame:initialize()
    self.cable = {
        pos = {x = 500, y = 500},
        moveSpeed = 700,
        spacePressed = false,
        sprite = love.graphics.newImage('img/usbcable.png')
    }
    self.gameCompleted = false
    self.gameFail = false
    self.gameSucceed = false
    self.timerMax = 3
    self.timer = timer:new(self.timerMax)
    --self.cable.sprite = love.graphics.newImage('img/usbcable.png')
    self.phoneSprite = love.graphics.newImage('img/phone.png')
end

function cableGame:checkCollision()
    return self.cable.pos.y < collision_area.y + collision_area.height and self.cable.pos.y + self.cable.sprite:getHeight() 
    > collision_area.y and self.cable.pos.x < collision_area.x + collision_area.width and self.cable.pos.x + 
    self.cable.sprite:getWidth() > collision_area.x
end

function cableGame:update(dt)
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

    if self.cable.spacePressed then
        self.cable.pos.y = self.cable.pos.y - math.abs(self.cable.moveSpeed) * dt
          -- Check if the USB cable collides with the collision area
        if self:checkCollision() then
            self:gameWin()
        end
        if self.cable.pos.y < 0 then
            self:gameOver()
        end
    else
        if self.cable.pos.x > 400 * 2 or self.cable.pos.x <= 200 then
            self.cable.moveSpeed = self.cable.moveSpeed * -1
        end
        self.cable.pos.x = self.cable.pos.x + self.cable.moveSpeed * dt
    end

    if love.mouse.isDown(1) then
        self.cable.spacePressed = true
        self.timer:pause(true)
    end
end

function cableGame:gameOver()
    self.gameFail = true
    self.timer = timer:new(2)
end

function cableGame:gameWin()
    self.gameSucceed = true
    self.timer = timer:new(2)
end

function cableGame:draw()
    love.graphics.setBackgroundColor(0, 0.5, 1)
    if self.gameFail then
        love.graphics.print("FAILED!", 450, 300)
    elseif self.gameSucceed then
        love.graphics.print("SUCCESS!", 450, 300)
    else
        love.graphics.setColor(0.8, 0.8, 0.8)
          -- Draw the collision area (for debugging purposes only)
        love.graphics.rectangle("fill", collision_area.x, collision_area.y, collision_area.width, collision_area.height + 8)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(self.timerMax - math.floor(self.timer.count), 0, 0)
        love.graphics.print("PLUG IN THE CABLE!", 450, 300)
        love.graphics.draw(self.cable.sprite, self.cable.pos.x, self.cable.pos.y, 0, 4, 4)
        love.graphics.draw(self.phoneSprite, love.graphics:getWidth()/2 - self.phoneSprite:getWidth()*3, -self.phoneSprite:getHeight()*5, 0, 6, 6)
    end
end

return cableGame