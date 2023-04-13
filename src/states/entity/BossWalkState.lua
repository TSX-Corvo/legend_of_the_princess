--[[
    ISPPJ1 2023
    Study Case: The Legend of the Princess (ARPG)

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Modified by Alejandro Mujica (alejandro.j.mujic4@gmail.com) for teaching purpose.

    This file contains the class EntityWalkState.
]]
BossWalkState = Class{__includes = EntityWalkState}


function BossWalkState:processAI(params, dt)
    local room = params.room
    local directions = {'left', 'right', 'up', 'down'}

    if self.moveDuration == 0 or self.bumped then
        
        -- set an initial move duration and direction
        self.moveDuration = math.random(5)
        self.entity.direction = directions[math.random(#directions)]
        self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
    elseif self.movementTimer > self.moveDuration then
        self.movementTimer = 0

        -- chance to shoot fireball
        if math.random(5) == 1 then
            local player = room.player
            local angle = math.atan2(-player.y + self.entity.y, -player.x + self.entity.x) + math.pi
            local props = {
                x = self.entity.x + 16,
                y = self.entity.y + 16,
                width = 8,
                height = 8,
                render = function (self_, x_, y_)
                    love.graphics.draw(TEXTURES['fireball'], FRAMES['fireball'][1], 
                        self_.x, self_.y,
                        angle,
                        1.0,
                        1.0
                    )    
                end
            }
            
            local fireball = BossProjectile(props, angle)
            table.insert(room.projectiles, fireball)
        end

        -- chance to go idle
        if math.random(3) == 1 then
            self.entity:changeState('idle')
        else
            self.moveDuration = math.random(5)
            self.entity.direction = directions[math.random(#directions)]
            self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
        end
    end

    self.movementTimer = self.movementTimer + dt
end