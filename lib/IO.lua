local Logger = require("lib.Logger")

local IO = {Network={}}


IO.Types = {
    MODEM = "modem"
}

IO.Sides = {
    "left",
    "right",
}


function IO.list()
    local io_list = {}
    for i = 1, 2, 1 do
        local iotype = peripheral.getType(side)
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