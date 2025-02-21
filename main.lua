name = "monitor_2"

--defining usefull functions here:
function pos(...) return term.setCursorPos(...) end
function clear(...) return term.clear() end
function tCol(...) return term.setTextColor(...) end
function bCol(...) return term.setBackgroundColor(...) end
function box(...) return paintutils.drawFilledBox(...) end
function line(...) return paintutils.drawLine(...) end

if peripheral.isPresent(name) then
    main_screen = peripheral.wrap(name)
    width, height = main_screen.getSize()
    term.redirect(main_screen)
 
    --reset the screen on startup
    term.clear()
    box(1,1,width,height,colors.black) --Background reset
    box(1,2,width,height,colors.gray) --Background new
    tCol(colors.white)
    
    term.setCursorPos(1,1)
    term.setBackgroundColor(colors.black)
    print("Main screen")
 
else print("-> monitor",name,"was not found") end