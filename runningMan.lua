local runningMan = class('runningMan')
local timer = require('timer')

local obstacle = class('obstacle')

function obstacle:initialize(pos, vel, sprite, isBus)
    self.pos = pos
    self.vel = vel
    self.sprite = sprite
    self.isBus = isBus
end

function runningMan:initialize()
    self.groundpos = 500
    self.player = {
        pos = {x = 150, y = self.groundpos},
        vel = {x = 0, y = 0},
        sprite = love.graphics.newImage('img/runningman.png')
    }

    self.allObstacles = {}

    -- Populate list full of obstacles
    for i = 1, 6 do
        local randNum = math.ceil(math.random(-250, 250))
        local sprite = nil
        if randNum > 0 then
            sprite = love.graphics.newImage('img/cat.png')
        else
            sprite = love.graphics.newImage('img/dog.png')
        end

        table.insert(self.allObstacles, #self.allObstacles + 1, obstacle:new(
            {x = i * 1000 + randNum, y = self.groundpos + 25}, 
            {x = 1000, y = 0}, 
            sprite)
        )
    end

    -- Add the bus at the end of the obstacles (the objective)
    table.insert(self.allObstacles, #self.allObstacles + 1, obstacle:new(
        {x = (#self.allObstacles + 1) * 1000, y = self.groundpos - 25}, 
        {x = 1000, y = 0}, 
        love.graphics.newImage('img/bus.png'), true)
    )

    self.gameCompleted = false
    self.gameFail = false
    self.gameSucceed = false
    self.timerMax = 15
    self.timer = timer:new(self.timerMax)
end

function runningMan:checkCollision()

    for i = 1, #self.allObstacles do
        local collision_area = self.allObstacles[i]
        local playerPosX = self.player.pos.x + self.player.sprite:getWidth()/4
        local playerPosY = self.player.pos.y + self.player.sprite:getHeight()/3
        if playerPosY < collision_area.pos.y + collision_area.sprite:getHeight()/2 and playerPosY + self.player.sprite:getHeight()/2 
        > collision_area.pos.y and playerPosX < collision_area.pos.x + collision_area.sprite:getWidth()/2 and playerPosX + 
        self.player.sprite:getWidth()/2 > collision_area.pos.x then
            if collision_area.isBus then
                self:gameWin()
            else
                self:gameOver()
            end
            
        end
    end
end

function runningMan:update(dt)
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

    self:checkCollision()

    for i = 1, #self.allObstacles do
        self.allObstacles[i].pos.x = self.allObstacles[i].pos.x - self.allObstacles[i].vel.x * dt
    end
    
    self.player.pos.y = self.player.pos.y - self.player.vel.y * dt

    if self.player.pos.y >= self.groundpos then
        if love.mouse.isDown(1) then
            self.player.vel.y = 1000
        else
            self.player.vel.y = 0
            self.player.pos.y = self.groundpos
        end
    else
        
        self.player.vel.y = self.player.vel.y - 3000 * dt
    end
end

function runningMan:gameOver()
    self.gameFail = true
    self.timer = timer:new(2)
end

function runningMan:gameWin()
    self.gameSucceed = true
    self.timer = timer:new(2)
end

function runningMan:draw()
    love.graphics.setBackgroundColor(1, 1, 1)
    love.graphics.setColor(0, 0, 0)
    if self.gameFail then
        love.graphics.print("FAILED!", 450, 300)
    elseif self.gameSucceed then
        love.graphics.print("SUCCESS!", 450, 300)
    else
        love.graphics.print(self.timerMax - math.floor(self.timer.count), 0, 0)
        love.graphics.print("CATCH YOUR BUS!", 450, 300)
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.player.sprite, self.player.pos.x, self.player.pos.y)
        --love.graphics.rectangle("fill", self.player.pos.x + self.player.sprite:getWidth()/4, self.player.pos.y + self.player.sprite:getHeight()/3, self.player.sprite:getWidth()/2, self.player.sprite:getHeight()/2) 
        for i = 1, #self.allObstacles do
            local collision_area = self.allObstacles[i]
            --love.graphics.rectangle("fill", collision_area.pos.x, collision_area.pos.y, collision_area.sprite:getWidth(), collision_area.sprite:getHeight())
            love.graphics.draw(self.allObstacles[i].sprite, self.allObstacles[i].pos.x, self.allObstacles[i].pos.y)
        end
    end
end

return runningMan
