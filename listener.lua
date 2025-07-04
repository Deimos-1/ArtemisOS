--TO DO:
--  - assert GUI initialized successfully before reporting to prompt

local variables = require("rom/aros/variables")
local gui = require("rom/aros/gui")

--used to split input into command arguments; arg_1, ..., arg_n
function splitBySpaces(input)
    local words = {}
    for word in input:gmatch("%S+") do -- Matches non-space sequences
        table.insert(words, word)
    end
    return words
end




function listenForCommands()
    while true do
        local input = read() 
        local split = splitBySpaces(input)

        -- Save command
        if split[1] == "save"  then -- INDEXING STARTS @ 1
            if split[2] ~= nil then
                variables.save(split[2])
                print(string.format("AROS> Saved variables to %s", split[2]))
            else 
                print("ERROR> No filename provided. Usage: \nsave [filename.lua]")
            end
                
        -- Load command
        elseif split[1] == "load" then
            if split[2] ~= nil then
                variables.load(split[2])
                print(string.format("AROS> Loaded variables from %s", split[2]))
            else 
                print("ERROR> No filename provided. Usage: \nload [filename.lua]")
            end

        -- Reboot comand
        elseif split[1] == "reboot" then
            os.reboot()

        -- GUI commands
        elseif split[1] == "gui" then
            -- initialization
            if split[2] == "init" then 
                gui.init()
                print("AROS> initialized the GUI")
            else
                print("ERROR> correct usage: gui [init]")
            end

        -- Freeze command
        elseif split[1] == "freeze" then
            if variables.running == false then
                print("AROS> the simulation is already frozen")
            else
                variables.running = false
                print("AROS> the simulation is now frozen")
            end

        -- Resume command
        elseif split[1] == "resume" then
        if variables.running == true then
            print("AROS> the simulation is already ticking")
        else
            variables.running = true
            print("AROS> the simulation resumed")
        end
        

        else 
            print(
[[
ERROR> invalid command. Valid commands are:
    - save [filename.lua]
    - load [filename.lua]
    - reboot
    - gui [init]
    - freeze
    - resume
]]
            )
                
        end
    end
end

return {
    listenForCmd = listenForCommands
}