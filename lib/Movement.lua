local Logger = require("lib.Logger")
local System = require("lib.System")
local Movement = {}

Movement.Direction = {
    UP          = "UP",
    DOWN        = "DOWN",
    FORWARD     = "FORWARD",
    BACKWARD    = "BACKWARD"
}


function Movement.reverse(direction)
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
        Logger.error("Movement.reverse", "No Direction provided") 
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
        Logger.error("Movement.move", "No Direction provided")
        success = false
    end

    -- Check Error Reason
    if (success == false) then
        local errorMsg = "("..direction..")"
        local foundReason = false;

        if (System.Fuel.level() == 0) then
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

        Logger.error("Movement.move", errorMsg)
    end
    return success
end


return Movement