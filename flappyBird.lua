local flappyBird = class('flappybird')


function flappyBird:initialize()
    self.player = {
        pos = {x = 500, y = 500},
        moveSpeed = 700,
        spacePressed = false,
        sprite = love.graphics.newImage('img/cupid.png')
    }
    self.gameCompleted = false
    self.gameFail = false
    self.gameSucceed = false
    self.timerMax = 15
    self.timer = timer:new(self.timerMax)
end

function flappyBird:update(dt)
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
        self.timer:pause(true)
    end
end

function flappyBird:gameOver()
    self.gameFail = true
    self.timer = timer:new(2)
end

function flappyBird:gameWin()
    self.gameSucceed = true
    self.timer = timer:new(2)
end

function flappyBird:draw()
    love.graphics.setBackgroundColor(0, 0.5, 1)
    if self.gameFail then
        love.graphics.print("FAILED!", 450, 300)
    elseif self.gameSucceed then
        love.graphics.print("SUCCESS!", 450, 300)
    else
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(self.timerMax - math.floor(self.timer.count), 0, 0)
        love.graphics.print("FLAP THE CUPID", 0, 300)
        love.graphics.draw(self.player.sprite, self.player.pos.x, self.player.pos.y)
        
    end
end

return flappyBird