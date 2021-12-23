
local Cache = {}

function Cache.save(key, value) 
    if key == nil then
        return
    end
    if fs.exists("/cache") == false then
        fs.makeDir("/cache")
    end

    local path = "/cache/"..key..".cache"
    local valueType = type(value)
    local cacheFile = fs.open(path, "w")

    if valueType == "string" then
        cacheFile.write(value)
    elseif valueType == "number" then
        cacheFile.write(value)
    elseif valueType == "table" then
        cacheFile.write(textutils.serialise(value))
    end

    cacheFile.close()
end

function Cache.load(key)
    if key == nil then
        return
    end

    local path = "/cache/"..key..".cache"
    if fs.exists(path) == false then
        return nil
    end
    
    if fs.exists(path) == false then
        return nil
    end

    local cacheFile = fs.open(path, "r")
    local content = cacheFile.readAll()
    cacheFile.close()

    return content
end

function Cache.loadString(key)
    return Cache.load(key)
end

function Cache.loadNumber(key)
    local content = Cache.load(key)
    return tonumber(content)
end

function Cache.loadTable(key)
    local content = Cache.load(key)
    return textutils.unserialise(content)
end

return Cache