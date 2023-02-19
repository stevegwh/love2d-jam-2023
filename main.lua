class = require 'lib.middleclass'
local _baton = require 'lib.baton'
function love.setup()

end

function love.load()
    Input = _baton.new {
        controls = {
            left = { 'key:left', 'key:a', 'axis:leftx-', 'button:dpleft' },
            right = { 'key:right', 'key:d', 'axis:leftx+', 'button:dpright' },
            up = { 'key:up', 'key:w', 'axis:lefty-', 'button:dpup' },
            down = { 'key:down', 'key:s', 'axis:lefty+', 'button:dpdown' },
            action = { 'key:space', 'button:a' },
            bomb = { 'key:e', 'button:y' },
            shift = { 'key:lshift', 'button:x' },
            pause = { 'key:k' },
        },
        pairs = {
            move = { 'left', 'right', 'up', 'down' }
        },
    }
end

function love.draw()
    love.graphics.print('Hello World!', 400, 300)
end

function love.update()
end

function love.keypressed(key, u)
    if key == "escape" then --set to whatever key you want to use
        love.event.quit()
    end
end