--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local bronze = love.graphics.newImage('bronze.png')

local silver = love.graphics.newImage('Silver.png')

local gold = love.graphics.newImage('Gold.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    --display medal and message depending on score
    if self.score < 5 then 
        love.graphics.printf('Congratulations! You\'ve earned a Bronze medal!', 0, 120, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(bronze, 0, 5, 0, 0.25, 0.25)
    elseif self.score > 4 and self.score < 10 then
        love.graphics.printf('Congratulations! You\'ve earned a Silver medal!', 0, 120, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(silver, 0, 5, 0, 0.15, 0.15)
    else 
        love.graphics.printf('Congratulations! You\'ve earned a Gold medal!', 0, 120, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(gold, 0, 5, 0, 0.15, 0.15)
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end