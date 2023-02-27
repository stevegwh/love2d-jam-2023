local catGame = class('catGame', game)
local timer = require('timer')

function catGame:initialize()
    self.cat = {
        pos = {x = 0, y = 0},
        mousePressed = false,
        sprite = love.graphics.newImage('img/cat.png'),
    }
    self.dog = love.graphics.newImage('img/dog.png')

    self.gameCompleted = false
    self.gameFail = false
    self.gameSucceed = false
    self.timerMax = 3
    self.timer = timer:new(self.timerMax)

    self.colMax = math.floor(love.graphics:getHeight() / self.dog:getHeight()) - 2
    self.rowMax = math.floor(love.graphics:getWidth() / self.dog:getWidth()) - 2
    self.randomNumber = math.random(self.colMax * self.rowMax)

end

function catGame:update(dt)
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

    if love.mouse.isDown(1) then
        local x = love.mouse:getX()
        local y = love.mouse:getY()
        
            if x >= self.cat.pos.x and x <= self.cat.pos.x + self.cat.sprite:getWidth() and
               y >= self.cat.pos.y and y <= self.cat.pos.y + self.cat.sprite:getHeight() then
                self:gameWin()
            end
    
    end
end

function catGame:gameOver()
    self.gameFail = true
    self.timer = timer:new(2)
end

function catGame:gameWin()
    self.gameSucceed = true
    self.timer = timer:new(2)
end

function catGame:draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    if self.gameFail then
        love.graphics.print("FAILED!", 450, 300)
    elseif self.gameSucceed then
        love.graphics.print("SUCCESS!", 450, 300)
    else
        love.graphics.print("CLICK ON THE CAT!", love.graphics.getWidth()/2 - 50, 30)
        local isCatDrawn = false

        local index = 0
        for col = 1,  self.colMax do
            index = index + 1
            for row = 1,  self.rowMax do
                index = index + 1
                if index == self.randomNumber and not isCatDrawn then
                    self.cat.pos.x = row * self.dog:getWidth()
                    self.cat.pos.y = col * self.dog:getHeight()
                    love.graphics.draw(self.cat.sprite, row * self.dog:getWidth(), col * self.dog:getHeight())
                    isCatDrawn = true
                else
                    love.graphics.draw(self.dog, row * self.dog:getWidth(), col * self.dog:getHeight())
                end
            end
        end

        love.graphics.setColor(1, 1, 1)
        love.graphics.print(self.timerMax - math.floor(self.timer.count), 0, 0)

    end
end

return catGame
