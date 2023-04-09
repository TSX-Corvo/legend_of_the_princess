-- This function assumes default direction to be right
function directionToAngle(direction)
    if direction == 'left' then
        return math.pi
    elseif direction == 'up' then
        return 3 * math.pi / 2
    elseif direction == 'down' then
        return math.pi / 2
    else
        return 0
    end
end