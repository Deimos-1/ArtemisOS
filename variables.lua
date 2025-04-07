--TO DO: 
--  - assert the load file is present

-- all reactor variables are kept in this table:
v = {
    reactivity = 1000,
    n_flux = 1000,
    temperature = 100,
    pressure = 10000,
    flow_1 = 10000,
    power_defect = 10,
    T_cold = 100,
    thermal_power = 1000
}
-- programm variables are handled separately:
running = false

function save(filename)
    file, err = io.open(string.format("storage/%s", filename), "w+") --All existing data is removed if file exists or new file is created with read write permissions.
    file:write("return {\n")  -- Start the table

    for var, val in pairs(v) do
        local formattedVar = type(var) == "string" and string.format("[%q]", var) or "[" .. var .. "]"
         -- Write vals based on type
        if type(val) == "number" or type(val) == "boolean" then
            file:write(string.format("    %s = %s,\n", formattedVar, tostring(val)))
        elseif type(val) == "string" then
            file:write(string.format("    %s = %q,\n", formattedVar, val))
        elseif type(val) == "table" then
            file:write(string.format("    %s = {\n", formattedVar))
            for _, v in ipairs(val) do
                file:write(string.format("        %s,\n", tostring(v)))
            end
            file:write("    },\n")
        end
    end
    file:write("}\n")  -- Close the table
    file:close()
    return true

end 


function tick() -- code taken from the python simulation, which worked quite well
    v.n_flux = v.n_flux + (v.reactivity - v.power_defect)
    -- non-negativity check: 
    if v.n_flux < 0 then v.n_flux = 0 end
    -- non-zero flow check: 
    if v.flow_1 == 0 then v.flow_1 = 0.01 end
    -- then the the following won't devide by 0: 
    v.temperature = v.T_cold + v.thermal_power * 1000000 / v.flow_1 / 4180
    --The nominal thermal power is around 3000 MWh corresponding to a temperature of 350°C and a primary flow of 16 m3/s
end


function load(filename)
    --updating v 'in-place' so other files have access to the new data:
    for k, val in pairs(dofile(string.format("storage/%s", filename))) do
        v[k] = val
    end
end


return {
    v = v, save = save, load = load, running = running, tick = tick
}