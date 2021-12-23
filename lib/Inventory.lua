local Logger = require("lib.Logger")
local Inventory = {}

Inventory.Direction = {
    UP          = "UP",
    DOWN        = "DOWN",
    FORWARD     = "FORWARD",
    BACKWARD    = "BACKWARD"
}


function Inventory.findItem(itemID)
    for slot = 1, 16, 1 do
        local itemDetail = turtle.getItemDetail(slot)
        if itemDetail ~= nil and itemDetail.name == itemID then
            return slot
        end
    end
end

return Inventory