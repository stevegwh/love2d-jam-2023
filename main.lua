class = require 'lib.middleclass'
local _baton = require 'lib.baton'
local gm = require('gameManager') ---@type gameManager
local gameManager ---@type gameManager
function love.setup()

end

function love.load()
    input = _baton.new {
        controls = {
            left = { 'key:left', 'key:a', 'axis:leftx-', 'button:dpleft' },
            right = { 'key:right', 'key:d', 'axis:leftx+', 'button:dpright' },
            up = { 'key:up', 'key:w', 'axis:lefty-', 'button:dpup' },
            down = { 'key:down', 'key:s', 'axis:lefty+', 'button:dpdown' },
            action = { 'key:space', 'button:a' },
            shift = { 'key:lshift', 'button:x' },
            pause = { 'key:k' }
        },
        pairs = {
            move = { 'left', 'right', 'up', 'down' }
        },
    }
    gameManager = gm:new() -- not sure if 'forward declaring' gameManager is necessary
end

function love.draw()
    gameManager:draw()
end

function love.update(dt)
    input:update()
    gameManager:update(dt)
end

function love.keypressed(key, u)
    if key == "escape" then --set to whatever key you want to use
        love.event.quit()
    end
end