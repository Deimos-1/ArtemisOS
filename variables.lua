--TO DO: 
--  - assert the load file is present

-- all reactor variables are kept in this table:
v = {
    reactivity = 0,
    n_flux = 0,
    temperature = 0,
    pressure = 0,
    flow_1 = 0
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


function tick()
    -- (...)
end


function load(filename)
    --updating v 'in-place' so other files have access to the new data:
    for k, val in pairs(dofile(string.format("storage/%s", filename))) do
        v[k] = val
    end
end


return {
    v = v, save = save, load = load, running = running
}