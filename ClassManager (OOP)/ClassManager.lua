local ClassCounter = 0
local ClassManager = {}

function ClassManager:SetClass(class)
    if type(class) == "string" then
        class = require(class)
    end

    local inherit = class.inherit or nil

    return setmetatable(class, {__index = function(_, k)
        if k == 'new' then
            return function(...)
                ClassCounter = ClassCounter + 1

                local instance = setmetatable({
                    Id = ClassCounter,
                    base = function(self, k, ...)
                        assert(k ~= "new", "Cannot active the 'new' function")
                        assert(inherit, "Can call 'base' function, because the module does not inherit anything")

                        inherit[k](self, ...)
                    end
                }, {
                    __newindex = function(self, k, v)
                        assert(k ~= "Id", "Attempt to modify read-only key")

                        rawset(self, k , v)
                    end,

                    __index = function(_, k)
                        if rawget(class, k) then
                            return class[k]
                        elseif inherit and type(inherit) == "table" then
                            return inherit[k]
                        end
                    end,

                    Destroy = function(self)
                        setmetatable(self, nil)

                        for k in pairs(self) do 
                            rawset(self, k, nil)
                        end

                        self = nil

                        collectgarbage()
                    end,
                })

                if rawget(class, '__init__') then
                    instance:__init__(...)
                end

                if rawget(class, '__listener__') then
                    instance:__listener__(...)
                end

                return instance
            end
        end
    end,})
end

return ClassManager