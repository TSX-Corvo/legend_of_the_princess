
Bow = Class{}

function Bow:init(x, y, player)
    self.x = x
    self.y = y
    self.player = player
    self.direction = player.direction
end

function Bow:update(dt)
    self.x = self.player.x
    self.y = self.player.y
    self.direction = self.player.direction
end

function Bow:fire()
    local direction = self.player.direction
    local arrowX, arrowY

    if direction == 'left' then
        arrowX = self.player.x
        arrowY = self.player.y + self.player.height / 2 + 5
    elseif direction == 'right' then
        arrowX = self.player.x + self.player.width
        arrowY = self.player.y + self.player.height / 2
    elseif direction == 'up' then
        arrowX = self.player.x + 5
        arrowY = self.player.y
    else
        arrowX = self.player.x + 10
        arrowY = self.player.y + 10
    end

    local arrow = {
        x = arrowX,
        y = arrowY,
        width = 8,
        height = 8,
        render = function (self_, x_, y_)
            love.graphics.draw(TEXTURES['arrow'], FRAMES['arrow'][1], 
                self_.x + x_, self_.y +  y_,
                directionToAngle(self.direction),
                0.5,
                0.5
            )      
        end
    }

    return arrow
end

function Bow:render()
    love.graphics.draw(TEXTURES['bow'], FRAMES['bow'][1], 
        self.x, self.y, directionToAngle(self.direction))
end