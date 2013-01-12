--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 12/01/13
-- Time: 10:45
-- To change this template use File | Settings | File Templates.
--
include("sb/classes/HudComponent.lua")
local C = CLASS
local surface = surface

-- TODO gradual increase/decrease

local oldIsA = C.isA
function C:isA(className)
    return oldIsA(self) or className == "HudBarIndicator"
end

local oldInit = C.init
function C:init(x, y, width, height, name, valueLambda, colorLambda, maxValueLambda)
    oldInit(self, x, y)
    self.width = width
    self.height = height
    self.getValue = valueLambda
    self.getColor = colorLambda
    self.name = name
    self.getMaxValue = maxValueLambda or function() return 100 end
end

local value_color, bg_color, value, maxvalue
function C:render()
    value_color = self:getColor()
    bg_color = Color( 50,50,50,220)
    value = self:getValue()
    maxvalue = self:getMaxValue()

    surface.SetDrawColor( value_color )           -- Outline of Background of the bar
    surface.DrawOutlinedRect( self.x + self.width * 0.05, self.y + self.height * 0.2, self.width * 0.9, self.height * 0.4 )

    surface.SetDrawColor( bg_color )        -- Background of Bar
    surface.DrawRect( self.x + self.width * 0.05, self.y  + self.height * 0.2, self.width * 0.9, self.height * 0.4 )

    surface.SetDrawColor( value_color )          --Value of Bar
    surface.DrawRect( self.x + self.width * 0.05, self.y  + self.height * 0.2, self.width * ( value / maxvalue ) * 0.9, self.height * 0.4 )

    self:DrawText( self.x, self.y + (self.height - self.height/8), self.width, string.format( "Breath: %i%s", math.Round( value ), "%" ), value_color )
end