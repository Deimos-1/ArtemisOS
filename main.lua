print("\nSTARTUP> starting up... ")

-- defining monitor labels
main_monitor = "main_monitor"

-- copying all file to the virtual computer (for development)
-- the path depends on your local installation !!!
mounter.mount("rom/aros", "C:\\Users\\Public\\ArtemisOS")
mounter.mount("storage", "C:\\Users\\Public\\ArtemisOS\\storage")

-- emulating monitors (for developement)
periphemu.create(main_monitor, "monitor")
print("STARTUP> attached",main_monitor)

-- import all modules
local gui = require("rom/aros/gui")
local variables = require("rom/aros/variables")
local listener = require("rom/aros/listener")


local function main()
    while true do
        if variables.running == true then
            variables.tick()
            gui.init() -- rebooting the whole display until gui.update() is implemented
        end
        sleep(1) -- the simulation will run at 1 FPS
    end
end


--the program:
parallel.waitForAny(main, listener.listenForCmd)     -- setting all screens on default
