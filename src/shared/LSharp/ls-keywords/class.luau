local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ls_globals = require(ReplicatedStorage.Shared.LSharp["ls-globals"])
local ls_types = require(ReplicatedStorage.Shared.LSharp["ls-types"])
local ls_utils = require(ReplicatedStorage.Shared.LSharp["ls-utils"])


local classMt = {}
classMt.__type = "class"
classMt.__index = classMt

return function(identifier:string)
    -- validate identifier
    if typeof(identifier) ~= "string" then
        error("Invalid identifier when defining class, expected string, got "..typeof(identifier))
    end

    local function construct()
        
    end

    local class:ls_types.class = setmetatable({
        __type = "class";
        hooks = {};
        mutables = {};
        immutables = {};
    }, classMt)
    ls_globals.defining_class = class

    return function(arg2)
        local parent:ls_types.class = ls_utils.gettype(arg2) == "class" and arg2 or nil
        if parent ~= nil then
            for index, item in parent.mutables do 
                class.mutables[item.key] = item.name
            end
        end


        return construct
    end
end
