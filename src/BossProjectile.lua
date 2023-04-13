--[[
    ISPPJ1 2023
    Study Case: The Legend of the Princess (ARPG)

    Author: Alejandro Mujica
    alejandro.j.mujic4@gmail.com

    This file contains the class Projectile.
]]
local PROJECTILE_SPEED = 150
local PROJECTILE_MAX_TILES = 16

BossProjectile = Class{__includes=Projectile}

function BossProjectile:init(obj, direction)
    Projectile.init(self, obj, direction)
    self.owner = 'mob'
end

function BossProjectile:update(dt)
    if self.dead then
        return
    end

    local d = PROJECTILE_SPEED*dt

    local dx = d * math.cos(self.direction)
    local dy = d * math.sin(self.direction)
    
    self.obj.x = self.obj.x + dx
    self.obj.y = self.obj.y + dy

    if self.obj.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.obj.height / 2 then 
        self.obj.y = MAP_RENDER_OFFSET_Y + TILE_SIZE - self.obj.height / 2
        self.dead = true
    end

    local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
        + MAP_RENDER_OFFSET_Y - TILE_SIZE

    if self.obj.y + self.obj.height >= bottomEdge then
        self.obj.y = bottomEdge - self.obj.height
        self.dead = true
    end

    if self.obj.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then 
        self.obj.x = MAP_RENDER_OFFSET_X + TILE_SIZE
        self.dead = true
    end

    if self.obj.x + self.obj.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
        self.obj.x = VIRTUAL_WIDTH - TILE_SIZE * 2 - self.obj.width
        self.dead = true
    end

    if self.dead then
        return
    end

    self.distance = self.distance + d

    if self.distance > PROJECTILE_MAX_TILES*TILE_SIZE then
        self.dead = true
    end
end
