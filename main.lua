print("\nSTARTUP> starting up... ")

--defining monitor labels
main_monitor = "main_monitor"

--copying all file to the virtual computer (for development)
--file path depends on your local installation...
mounter.mount("rom/aros", "C:\\Users\\Public\\ArtemisOS")
mounter.mount("storage", "C:\\Users\\Public\\ArtemisOS\\storage")



--emulating monitors (for developement)
periphemu.create(main_monitor, "monitor")
print("STARTUP> attached",main_monitor)


--import all modules
local gui = require("rom/aros/gui")
local variables = require("rom/aros/variables")


--the program:
gui.init()      --setting all screens on default
variables.load("test.lua")