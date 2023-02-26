local mainMenu = class 'mainmenu'
local button = class 'button'
function button:initialize(pos, sprite, callBack)
    self.pos = pos
    self.sprite = sprite
    self.onClick = callBack
end

function mainMenu:initialize()
    self.buttons = {
        button:new({x=love.graphics.getWidth()/2 - 80, y=500}, love.graphics.newImage('img/startButton.png'), 
        function()
            startGame()
        end)
    }

end

function mainMenu:update()

    if love.mouse.isDown(1) then
        local x = love.mouse:getX()
        local y = love.mouse:getY()
        for i, button in ipairs(self.buttons) do
            if x >= button.pos.x and x <= button.pos.x + button.sprite:getWidth() and
               y >= button.pos.y and y <= button.pos.y + button.sprite:getHeight() then
                -- Destroy sprite
                button:onClick()
                break
            end
        end
    end
end

function mainMenu:draw()
    love.graphics.setBackgroundColor(0.2, 0.5, 0.8)
    love.graphics.print("DOKI DOKI CONNECTION", love.graphics.getWidth()/2 - 130, 300)
    for i, button in ipairs(self.buttons) do
        love.graphics.draw(button.sprite, button.pos.x, button.pos.y)
    end
end


return mainMenu