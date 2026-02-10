local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ls_globals = require(ReplicatedStorage.Shared.LSharp["ls-globals"])

--[[
    used to inherit from a class during class definition inside a namespace definition
]]
return function(identifier:string)
    -- validate identifier
    if typeof(identifier) ~= "string" then
        error("Invalid identifier when inheriting class, expected string, got "..typeof(identifier))
    end

    -- check if a class is being defined
    if typeof(ls_globals.defining_class) == "nil" then
        error("Cannot use 'inherits' outside of a class definition")
    end

    -- check if the class to inherit from actually exists in the namespace we are using
    local defining_ns = ls_globals.defining_namespace
    local used_ns = ls_globals.environments[coroutine.running()]

    local from_ns = used_ns or defining_ns
    local parent = from_ns.classes[identifier]
    if typeof(parent) == "nil" then
        error("Class "..identifier.." does not exist in "..from_ns.name)
    end

    return parent
end