
-- all variables are kept in this table:
v = {
    reactivity = 0,
    n_flux = 0,
    temperature = 0,
    pressure = 0,
    flow_1 = 0
}

function save(filename)
    file = io.open(string.format("storage/%s", filename), "w+") --All existing data is removed if file exists or new file is created with read write permissions.
    file:write("return {\n")  -- Start the table

    for var, val in pairs(v) do
        local formattedVar = type(var) == "string" and string.format("[%q]", var) or "[" .. var .. "]"

         -- Write values based on type
         if type(value) == "number" or type(value) == "boolean" then
            file:write(string.format("    %s = %s,\n", formattedKey, tostring(value)))
        elseif type(value) == "string" then
            file:write(string.format("    %s = %q,\n", formattedKey, value))
        elseif type(value) == "table" then
            file:write(string.format("    %s = {\n", formattedKey))
            for _, v in ipairs(value) do
                file:write(string.format("        %s,\n", tostring(v)))
            end
            file:write("    },\n")
        end
    end
    file:write("}\n")  -- Close the table
    file:close()
    return true

end 


function load(filename)
    file = io.open(filename, "r") --Read only
    file:write(v)
end


return {
    var = v, save = save, load = load
}