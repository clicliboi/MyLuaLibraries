local ClassManager = require("ClassManager")

local SubClass = require("_templates.SubClass")

love.load = function()
    ClassManager:SetClass('_templates.SubClass')

    local instance = SubClass.new("Hello there brother!")
    instance:PrintOut()
    instance:ChangeMessage("Hello there sister!")
    instance:PrintOut()
end