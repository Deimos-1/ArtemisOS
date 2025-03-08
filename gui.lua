--defining usefull functions here:
function pos(...) return term.setCursorPos(...) end
function clear(...) return term.clear() end
function tCol(...) return term.setTextColor(...) end
function bCol(...) return term.setBackgroundColor(...) end
function box(...) return paintutils.drawFilledBox(...) end
function line(...) return paintutils.drawLine(...) end



--TO DO:
-- custom print (given a variable and space available)

local function cprint(title, value, unit, space)
    title = title or ""
    value = value or 0
    unit = unit or ""
    space = space or 28

    -- We dedicate the following space to each argument; 11, 12, 7
    local interval_1 =  11 - string.len(title)
    local interval_2 = 12 - string.len(value) 
    local interval_3 = 7 - string.len(unit)

    --verifying inputs
    assert(type(title) == "string", "ERROR> Provided title is not a string")
    assert(type(unit) == "string", "ERROR> Provided title is not a string")
    assert(type(space) == "number", "ERROR> Provided length is NaN")
    assert(type(value) == "number", "ERROR> Provided length is NaN")

    string = string.format("%s%s%.2f%s%s", title, string.rep(" ",interval_1+interval_2), value, string.rep(" ",interval_3), unit)

    --assert(string.len(string) <= space, "ERROR> Text is longer than provided space")
    print(string)
end


local function init()

    --initializing main_monitor
    if peripheral.isPresent(main_monitor) then

        main_screen = peripheral.wrap(main_monitor)
        width, height = main_screen.getSize()
        term.redirect(main_screen)
     
        --reset the screen
        term.clear()
        box(1,1,width,height,colors.black) --Background reset
        box(1,2,width,height,colors.gray) --Background new
        tCol(colors.white)
        
        --title
        term.setCursorPos(1,1)
        term.setBackgroundColor(colors.black)
        print("Main screen")
    
        --variables
        term.setCursorPos(3,3)
        cprint("Reactivity:",0,"[%]")
        term.setCursorPos(3,4)
        cprint("Neutron flux:",0,"[%n]")
        term.setCursorPos(3,5)
        cprint("Temperature:",0,"[C]")
        term.setCursorPos(3,6)
        cprint("Pressure:",0,"[kPa]")
        term.setCursorPos(3,7)
        cprint("Primary flow:",0,"[m3/s]")










    else print("-> monitor",name,"was not found")
    end
    
end    


return {
    init = init
}