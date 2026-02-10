local module = {}

function module.gettype(object)
    local naive_type = typeof(object)
    if naive_type ~= "table" then
        return naive_type
    end
    return object.__type or naive_type
end

return module