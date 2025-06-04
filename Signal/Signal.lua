local unpack = unpack or table.unpack

local function _await(self, arg1, arg2)
    local _upper = self
    local _function = arg2 or arg1
    assert(type(_function) == "function", "First argument requires a callback")

    --- @class connection
    local connection = setmetatable({
        _function = _function,

        ---@overload fun()
        Disconnect = function(self)
            for i = 1, #_upper, 1 do
                if _upper[i] == self then
                    table.remove(_upper, i)
                    break
                end
            end

            for k in pairs(self) do
                self[k] = nil
            end

            setmetatable(self, nil)
        end,
    }, {
        __newindex = function()
            error("Cannot add items into an already existing connection")
        end,
    })

    local metatable = getmetatable(self)
    setmetatable(self, nil)
    table.insert(self, connection)
    setmetatable(self, metatable)
    return connection
end

--- @class signal
local signal = {
    ---@overload fun(self: signal, func: function): connection
    Await = setmetatable({},
    {
        __newindex = function()
            error("Await function does not accept direct item additions")
        end,

        __call = _await,
    }),

    ---@overload fun(self: signal, func: function)
    Once = function(self, func)
        local await = _await(self.Await, func)

        local metatable = getmetatable(await)
        setmetatable(await, nil)
        await['_once'] = true
        setmetatable(await, metatable)
    end,

    ---@overload fun(self: signal, ...: any)
    Fire = function(self, ...)
        local args = {...}

        for _, await in ipairs(self.Await) do
            coroutine.wrap(function()
                local succes, err = pcall(await._function, unpack(args))
                if not succes then
                    error(err)
                end

                if await._once then
                    await:Disconnect()
                end
            end)()
        end
    end,

    ---@overload fun(self: signal)
    Destroy = function(self)
        for k, v in pairs(self) do
            if type(v) == "table" then
                setmetatable(v, nil)
            end

            rawset(self, k, nil)
        end

        setmetatable(self, nil)
        self = nil
    end,
}


return {
    new = function()
        return setmetatable({}, {__index = signal})
    end
}
