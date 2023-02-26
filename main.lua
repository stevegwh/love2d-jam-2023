class = require 'lib.middleclass'
local _baton = require 'lib.baton'
local timer = require 'timer'
local gm = require('gameManager') ---@type gameManager
local mMenu = require 'mainMenu' ---@type mainMenu
local gameManager ---@type gameManager
local mainMenu ---@type mainMenu
local gameStarted = false
local buttonPressed = false
local buttonPressDelayTimer = 0
local buttonPressMaxDelay = 0.2
function startGame()
    buttonPressed = true
    buttonPressDelayTimer = 0
end

function love.setup()

end

function love.load()
    font = love.graphics.newFont(20)
    gameManager = gm:new() -- not sure if 'forward declaring' gameManager is necessary
    mainMenu = mMenu:new()
end

function love.draw()
    love.graphics.setFont(font)
    if gameStarted then
        gameManager:draw()
    else
        mainMenu:draw()
    end
end

function love.update(dt)
    -- I am sorry
    if buttonPressed then
        if buttonPressDelayTimer >= buttonPressMaxDelay then
            gameStarted = true
            buttonPressed = false
        else
            buttonPressDelayTimer = buttonPressDelayTimer + dt
        end
    end
    if gameStarted then
        gameManager:update(dt)
    else
        mainMenu:update(dt)
    end
end

function love.keypressed(key, u)
    if key == "escape" then --set to whatever key you want to use
        love.event.quit()
    end
end