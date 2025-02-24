print("\nSTARTUP> starting up... ")

--copying all file to the virtual computer (for development)
mounter.mount("rom/aros", "C:/Users/Stefan/Documents/Code/ArtemisOS")


--defining monitor labels
main_monitor = "main_monitor"


--emulating monitors (for developement)
periphemu.create(main_monitor, "monitor")
print("STARTUP> attached",main_monitor)


--import all modules
local gui = require("rom/aros/gui")


--the program:
gui.init()      --setting all screens on default

















