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

        if split[1] == "save"  then -- INDEXING STARTS @ 1
            if split[2] ~= nil then
                variables.save(split[2])
                print(string.format("AROS> Saved variables to %s", split[2]))
            else 
                print("ERROR> No filename provided. Usage: \nsave [filename.lua]")
            end
                

        elseif split[1] == "load" then
            if split[2] ~= nil then
                variables.load(split[2])
                print(string.format("AROS> Loaded variables from %s", split[2]))
            else 
                print("ERROR> No filename provided. Usage: \nload [filename.lua]")
            end


        elseif split[1] == "reboot" then
            os.reboot()

        
        elseif split[1] == "gui" then
            if split[2] == "init" then 
                gui.init()
                print("AROS> initialized the GUI")
            else
                print("ERROR> correct usage: gui [init]")
            end

        else 
            print("ERROR> invalid command. Valid commands are: \n - save [filename.lua] \n - load [filename.lua] \n - reboot\n - gui [init]") 
        end

    end
end

return {
    listenForCmd = listenForCommands
}