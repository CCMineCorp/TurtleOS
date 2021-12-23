

local System = {Fuel={}}

-- Turtle Fuel Level
function System.Fuel.level()
    return turtle.getFuelLevel()
end

-- Turtle Fuel Limit
function System.Fuel.limit()
    return turtle.getFuelLimit()
end

-- Turtle Fuel Percentage (level/limit)
function System.Fuel.percentage()
    return (System.Fuel.level() / System.Fuel.limit())
end


return System