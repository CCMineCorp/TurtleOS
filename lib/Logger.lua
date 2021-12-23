
local Logger = {}

Logger.Level = {
    INFO = "INFO",
    WARNING = "WARN",
    ERROR = "ERRO",
    CRITICAL = "CRIT"
}

function Logger.log(level, tag, msg)
    local msg = msg and msg or ""
    local levelTag = "["..level.."]"
    local classTag = "["..tag.."]"
    local logMsg = levelTag.." "..classTag.." "..msg
    print(logMsg)
end

function Logger.info(tag, msg)
    Logger.log(Logger.Level.INFO, tag, msg)
end

function Logger.warning(tag, msg)
    Logger.log(Logger.Level.WARNING, tag, msg)
end

function Logger.error(tag, msg)
    Logger.log(Logger.Level.ERROR, tag, msg)
end

function Logger.critical(tag, msg)
    Logger.log(Logger.Level.CRITICAL, tag, msg)
end

return Logger