# ClassManager

`ClassManager.lua` is a lightweight Lua OOP (Object-Oriented Programming) system for creating classes, supporting inheritance, constructors, and instance methods. Inspired by familiar OOP patterns, it allows you to define base classes, inherit from them, and manage instances easily.

## Features
- Simple class definition syntax
- Single inheritance support
- Automatic constructor (`__init__`) calling
- Instance methods and fields
- Base method calls for parent class logic
- Instance destruction and cleanup

## Code Example

### Defining a Base Class
```lua
-- Module 'BaseClass.lua'
local BaseClass = {
    __init__ = function(self, msg)
        self.msg = msg
    end,
}

return BaseClass
```

### Defining a Subclass
```lua
-- Module 'SubClass.lua'
local SubClass = {
    inherit = require "_templates.BaseClass",
    __init__ = function(self, msg)
        self:base("__init__", msg)
    end,

    PrintOut = function(self)
        print(self.msg)
    end,

    ChangeMessage = function(self, newMsg)
        self.msg = newMsg
    end,
}

return SubClass
```

### Registering and Using a Class
```lua
-- Requiring 'ClassManager.lua'
local ClassManager = require("ClassManager")

-- Creating a new class
local SubClass = ClassManager:SetClass("SubClass")

-- Creating a new instance of 'BaseClass'
local instance = SubClass.new("Hello World!")
instance:PrintOut() -- prints: Hello World!
instance:ChangeMessage("Hello Lua!")
instance:PrintOut() -- prints: Hello Lua!
```

### Destroying an Instance
```lua
instance:Destroy() -- cleans up the instance
```

## How It Works
- Define your class as a table with methods and an optional `inherit` field for inheritance.
- Use `__init__` for your constructor logic.
- Register your class with `ClassManager:SetClass(yourClass)` before using `.new()`.
- Use `self:base("methodName", ...)` to call parent methods from a subclass.

### Templates
<a href="_templates/BaseClass.lua">BaseClass Template<a>

<a href="_templates/SubClass.lua">SubClass Template<a>
