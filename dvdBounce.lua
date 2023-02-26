local game = require 'game'
local dvdBounce = class('dvdBounce', game)
local timer = require('timer')

function dvdBounce:initialize()
    -- Load sprites
    self.sprite = love.graphics.newImage('img/dvdheart.png')
    
    -- Set initial sprite positions and velocities
    self.sprites = {
        {image = self.sprite, x = 0, y = 0, dx = 500, dy = 300},
        {image = self.sprite, x = 100, y = 100, dx = -200, dy = 200},
        {image = self.sprite, x = 200, y = 200, dx = 500, dy = -200}
    }
    
    -- Set sprite dimensions
    self.spriteWidth = self.sprite:getWidth()
    self.spriteHeight = self.sprite:getHeight()
    game.initialize(self, 3)
end

function dvdBounce:update(dt)
    game.update(self, dt)

    -- Update sprite positions
    for i, sprite in ipairs(self.sprites) do
        sprite.x = sprite.x + sprite.dx * dt
        sprite.y = sprite.y + sprite.dy * dt
        
        -- Check for collision with screen edges
        if sprite.x < 0 or sprite.x > love.graphics.getWidth() - self.spriteWidth then
            sprite.dx = -sprite.dx
        end
        if sprite.y < 0 or sprite.y > love.graphics.getHeight() - self.spriteHeight then
            sprite.dy = -sprite.dy
        end
    end

    if love.mouse.isDown(1) then
        local x = love.mouse:getX()
        local y = love.mouse:getY()
        for i, sprite in ipairs(self.sprites) do
            if x >= sprite.x and x <= sprite.x + self.spriteWidth and
               y >= sprite.y and y <= sprite.y + self.spriteHeight then
                -- Destroy sprite
                table.remove(self.sprites, i)
                break
            end
        end
    end

    if #self.sprites == 0 then
        self:gameWin()
    end
end

function dvdBounce:draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    if self.gameFail then
        love.graphics.print("FAILED!", 450, 300)
    elseif self.gameSucceed then
        love.graphics.print("SUCCESS!", 450, 300)
    else
        love.graphics.print("CLICK ON THE HEARTS!!", 450, 300)
        -- Draw sprites
        for i, sprite in ipairs(self.sprites) do
            love.graphics.draw(sprite.image, sprite.x, sprite.y)
        end
        love.graphics.print(self.timerMax - math.floor(self.timer.count), 0, 0)
    end
    --love.graphics.setColor(0, 0, 0)
end

return dvdBounce
