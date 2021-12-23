local Logger = require("lib.Logger")

local IO = {Network={}}


IO.Types = {
    MODEM = "modem"
}

IO.Sides = {
    LEFT = "left",
    RIGHT = "right",
}


function IO.list()
    local io_list = {}
    for i = 1, 2, 1 do
        local side = IO.Sides[i]
        local iotype = peripheral.getType(IO.Sides[i])
        io_list[side] = iotype
    end
    return io_list
end

function IO.hasType(type)
    for i = 1, 2, 1 do
        if peripheral.getType(IO.Sides[i]) == type then
            return true
        end
    end

    return false
end

function IO.Network.isPresent()
    IO.hasType(IO.Types.Modem)
end


return IO