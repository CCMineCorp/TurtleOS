
Const = {
    fieldsize = 9
}


local function traverseField()
    local pathlength = (Const.fieldsize - 1)

    -- Traverse
    for i = 1, 4, 1 do
        for k = 1, 4, 1 do
            for j = 1, (pathlength - (k==4 and 1 or 0)), 1 do
                turtle.forward()
                turtle.digDown()
            end
            turtle.turnRight()
        end
        if i~=4 then
            turtle.forward()
        end
        pathlength = pathlength-2
    end

    -- Return to Start
    turtle.turnRight()
    turtle.turnRight()
    for k = 1, 3, 1 do
        turtle.forward()
    end
    turtle.turnRight()
    for k = 1, 4, 1 do
        turtle.forward()
    end
    turtle.turnRight()
end

local function moveToField(fieldID)
end
term.clear()
traverseField()
