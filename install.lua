local FileURLS = {
    -- Libraries
    {
        NAME="Logging Library",
        REPO="https://raw.githubusercontent.com/CCMineCorp/TurtleOS/{BRANCH}",
        PATH="/lib/Logger.lua"
    },
    {
        NAME="Movement Library",
        REPO="https://raw.githubusercontent.com/CCMineCorp/TurtleOS/{BRANCH}",
        PATH="/lib/Movement.lua"
    },
    {
        NAME="System Library",
        REPO="https://raw.githubusercontent.com/CCMineCorp/TurtleOS/{BRANCH}",
        PATH="/lib/System.lua"
    },
    {
        NAME="IO Library",
        REPO="https://raw.githubusercontent.com/CCMineCorp/TurtleOS/{BRANCH}",
        PATH="/lib/IO.lua"
    },

    -- Services
    {
        NAME="Diagnostics Service",
        REPO="https://raw.githubusercontent.com/CCMineCorp/TurtleOS/{BRANCH}",
        PATH="/services/diagnostics.lua"
    },

    -- Programs
    {
        NAME="Farmbot Software",
        REPO="https://raw.githubusercontent.com/CCMineCorp/TurtleOS/{BRANCH}",
        PATH="/programs/farmbot.lua"
    }
}



local function downloadFiles()
    for i = 1, table.getn(FileURLS), 1 do
        local file = FileURLS[i]
        print("downloading '"..file.NAME.."'")

        -- Load File from URL
        local url = (file.REPO:gsub("{BRANCH}", "main"))..file.PATH
        local content = http.get(url).readAll()

        -- Check For Path
        local pathComponents = {}

        for str in string.gmatch(file.PATH, "([^/]+)") do
            table.insert(pathComponents, str)
        end

        for k = 1, table.getn(pathComponents)-1, 1 do
            local pathComponent = pathComponents[k]
            if fs.isDir(pathComponent) == false then
                fs.makeDir(pathComponent)
            end
        end

        -- Write File to Path
        local file = fs.open(file.PATH, "w")
        file.write(content)
        file.close()
    end
end

local function completeInstall()
end

downloadFiles()
completeInstall()