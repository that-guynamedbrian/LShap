local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ls_globals = require(ReplicatedStorage.Shared.LSharp["ls-globals"])
local ls_types = require(ReplicatedStorage.Shared.LSharp["ls-types"])

local namespaceMt = {}
namespaceMt.__type = "namespace"
namespaceMt.__index = namespaceMt
namespaceMt.__call = function(self:ls_types.namespace)
    error("Attempt to re-define namespace: "..self.name, 1)
end

--[[
    if a namespace exists, get it, otherwise start defining a namespace
]]
return function(identifier:string)
    -- validate identifier
    if typeof(identifier) ~= "string" then
        error("Invalid identifier when defining namespace, expected string, got "..typeof(identifier))
    end
    -- get existing
    local namespace: ls_types.namespace = ls_globals.namespaces[identifier]
    if namespace ~= nil then -- return if namespace exists
        return namespace
    end
    
    -- create new
    namespace = setmetatable({
        name = identifier;
        classes = {};
    }, namespaceMt)
    ls_globals.defining_namespace = namespace -- store so classes know which namespace to insert themselves into
    
    return function(definition)
        ls_globals.defining_namespace = nil
        
        -- validation
        if typeof(definition) ~= "table" then
            error("Invalid namespace definition, expected table, got "..typeof(definition))
        elseif #definition == 0 then
            error("Cannot define a namespace: "..identifier.." with no classes")
        end

        ls_globals.namespaces[identifier] = namespace -- cache namespace 
    end
end
