
local Inventory = require("lib.Inventory")

Const = {
    plots = arg[2] and arg[2] or 1,
    plotsize = 9,
    crop = "minecraft:wheat",
    seed = "minecraft:wheat_seeds",
    grown_state = 7
}

local function harvestAndPlant()
    -- Harvest (Harvest and use hoe)
    local shovelSlot = Inventory.findItem("minecraft:diamond_shovel")
    turtle.select(shovelSlot)
    turtle.equipRight()
    turtle.digDown()
    turtle.suckDown()
    turtle.equipRight()
    turtle.digDown()

    -- Plant
    local slot = Inventory.findItem(Const.seed)
    if slot == nil then
        print("ERROR")
    else
        turtle.select(slot)
        turtle.placeDown()
    end
end

local function processPlot()
    local hasBlock, info = turtle.inspectDown()
    turtle.suckDown()

    if hasBlock == false then
        harvestAndPlant()
        return
    end

    if info.name ~= Const.crop then
        print("ERROR")
        return
    end

    if info.state.age == Const.grown_state then
        harvestAndPlant()
    else
        print("NOT COMPLETED")
    end
end

local function iteratePlot()
    local pathlength = (Const.plotsize - 1)

    -- Traverse
    for i = 1, 4, 1 do
        for k = 1, 4, 1 do
            for j = 1, (pathlength - (k==4 and 1 or 0)), 1 do
                processPlot()
                turtle.forward()
            end
            turtle.turnRight()
        end
        if i~=4 then
            turtle.forward()
        end
        processPlot()
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

local function iterateFields()
    for i = 1, Const.plots, 1 do
        turtle.forward()
        for k = 1,2,1 do
            iteratePlot()
        end
        turtle.back()
        
        if i ~= Const.plots then
            turtle.up()
            turtle.up()
            turtle.up()
        else
            for i = 1, Const.plots-1, 1 do 
                turtle.down()
                turtle.down()
                turtle.down()
            end
        end
    end
end

term.clear()
iterateFields()
