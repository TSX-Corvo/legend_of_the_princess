
PlayerFireState = Class{__includes = BaseState}

function PlayerFireState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 0

    self.duration = 0.5
    self.counter = 0

    -- create hitbox based on where the player is and facing
    local direction = self.player.direction
    
    local bowX, bowY

    if direction == 'left' then
        bowX = self.player.x + 12
        bowY = self.player.y + self.player.height / 2 + 12
    elseif direction == 'right' then
        bowX = self.player.x + self.player.width - 12
        bowY = self.player.y + self.player.height / 2 - 12
    elseif direction == 'up' then
        bowX = self.player.x - 5
        bowY = self.player.y + 20
    else
        bowX = self.player.x + 22
        bowY = self.player.y + 10
    end

    self.bow = Bow(bowX, bowY, player)
end

function PlayerFireState:enter(params)
    -- Create the arrow
    local arrow = self.bow:fire()
    table.insert(self.dungeon.currentRoom.projectiles, Projectile(arrow, self.player.direction))
    self.player.currentAnimation:refresh()
    print(dump(self.dungeon.currentRoom.projectiles))
end

function PlayerFireState:update(dt)
    self.counter = self.counter + dt

    if self.counter >= self.duration then
        self.counter = 0
        self.player:changeState('idle')
    end

end

function PlayerFireState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
    
    self.bow:render()

    -- debug for player and hurtbox collision rects
    -- love.graphics.setColor(love.math.colorFromBytes(255, 0, 255, 255))
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.swordHitbox.x, self.swordHitbox.y,
    -- self.swordHitbox.width, self.swordHitbox.height)
    -- love.graphics.setColor(love.math.colorFromBytes(255, 255, 255, 255))
end