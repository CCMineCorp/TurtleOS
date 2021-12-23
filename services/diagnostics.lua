local Logger = require("lib.Logger")
local System = require("lib.System")


local Diagnostics = {Tests={}}

Diagnostics.States = {
    WARNING = "WARN",
    ERROR   = "ERR",
    OK      = "OK",
    UNKNOWN = "-"
}

function string.justify(str, length) 
    str = str and str or ""
    local n = string.len(str)
    for i = 1, (length - n), 1 do
        str = str.." "
    end
    return str
end

local function logReport(report)
    for system, value in pairs(report) do
        if value.STATUS == Diagnostics.States.Error then
            term.setTextColor(colors.red)
        elseif value.STATUS == Diagnostics.States.Warning then
            term.setTextColor(colors.yellow)
        else
            term.setTextColor(colors.green)
        end

        local idx = string.justify(system, 8)
        local val = string.justify(value.VALUE, 15)
        local status = string.justify(value.STATUS, 4)
        term.write(idx..val..status)
        term.setTextColor(colors.white)
    end
end

-- TESTS

-- Test: Fuel Level
function Diagnostics.Tests.fuel() 
    local fuel = System.Fuel.level()
    local result = {
        VALUE=fuel.." ("..(string.format("%.f", System.Fuel.percentage()*100)).."%)",
        STATUS=Diagnostics.States.UNKNOWN
    }
    if fuel > 2000 then
        result.STATUS = Diagnostics.States.OK
    elseif fuel > 0 then
        result.STATUS = Diagnostics.States.WARNING
    else
        result.STATUS = Diagnostics.States.ERROR
    end

    return result
end


function Diagnostics.report(log)
    local report = {
        FUEL = Diagnostics.Tests.fuel(),
    }

    if log then
        logReport(report)
    end

    return report
end


function Diagnostics.test()
    for key, status in pairs(Diagnostics.report(true)) do
        if status.STATUS ~= Diagnostics.States.OK then
            print("ERROR: "..key.."  "..value)
        end
    end

    return fuelReport
end

return Diagnostics