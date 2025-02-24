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
    space = space or 30

    --verifying inputs
    assert(type(title) == "string", "ERROR> Provided title is not a string")
    assert(type(unit) == "string", "ERROR> Provided title is not a string")
    assert(type(space) == "number", "ERROR> Provided length is NaN")
    assert(type(value) == "number", "ERROR> Provided length is NaN")

    --assert(string.len(title) <= space, "ERROR> Text is longer than provided space")
    print(title)
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
        cprint("Reactivity:",0,"[%]",20)
        term.setCursorPos(3,4)
        print("Neutron flux:")
        term.setCursorPos(3,5)
        print("Temperature:")
        term.setCursorPos(3,6)
        print("Pressure:")
        term.setCursorPos(3,7)
        print("Primary flow:")










    else print("-> monitor",name,"was not found")
    end
    
end    


return {
    init = init
}