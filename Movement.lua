local Movement = {}

Movement.Direction = {
    UP          = "UP",
    DOWN        = "DOWN",
    FORWARD     = "FORWARD",
    BACKWARD    = "BACKWARD"
}

function Movement.fuelLevel()
    local limit = turtle.getFuelLimit()
    local level = turtle.getFuelLevel()
    return limit / level
end

function Movement.reverseMove(direction)
    local success = false
    if (direction == Movement.Direction.UP) then
        success = Movement.move(Movement.Direction.DOWN)
    elseif (direction == Movement.Direction.DOWN) then
        success = Movement.move(Movement.Direction.UP)
    elseif (direction == Movement.Direction.FORWARD) then
        success = Movement.move(Movement.Direction.BACKWARD)
    elseif (direction == Movement.Direction.BACKWARD) then
        success = Movement.move(Movement.Direction.FORWARD)
    else
        print("No Direction provided") 
    end

    return success
end

function Movement.move(direction)
    local success;
    
    -- Check Direction
    if (direction == Movement.Direction.UP) then
        success = turtle.up()
    elseif (direction == Movement.Direction.DOWN) then
        success = turtle.down()
    elseif (direction == Movement.Direction.FORWARD) then
        success = turtle.forward()
    elseif (direction == Movement.Direction.BACKWARD) then
        success = turtle.back()
    else
        print("No Direction provided") 
        success = false
    end

    -- Check Error Reason
    if (success == false) then
        local errorMsg = "[Movement.move] - ERROR - ("..direction..")"
        local foundReason = false;

        if (Movement.fuelLevel() == 0) then
            errorMsg = errorMsg .. " No Fuel"
            foundReason = true
        end

        if foundReason == false then
            local isBlocked, blockId;
            if (direction == Movement.Direction.UP) then
                isBlocked, blockId = turtle.inspectUp()
            elseif (direction == Movement.Direction.DOWN) then
                isBlocked, blockId = turtle.inspectDown()
            elseif (direction == Movement.Direction.FORWARD) then
                isBlocked, blockId = turtle.inspect()
            elseif (direction == Movement.Direction.BACKWARD) then
                turtle.turnRight(2)
                isBlocked, blockId = turtle.inspect()
                turtle.turnLeft(2)
            end

            if isBlocked then
                errorMsg = errorMsg .. " Path Blocked by '"..blockId["name"]:gsub("minecraft:","").."'"
                foundReason = true
            end
        end

        if foundReason == false then 
            errorMsg = errorMsg .. " unknown error"
        end

        print(errorMsg)
    end
    return success
end


return Movement