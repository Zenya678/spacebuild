--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 19/01/13
-- Time: 21:32
-- To change this template use File | Settings | File Templates.
--

include(fluix.basePath.."classes/HudPanel.lua")
local C = CLASS

function C:calculateSize()
    if self.autosize then
        self:setWidth(self.base_width)
        self:setHeight(self.base_height)
        for k, v in pairs(self.children) do
            if v:getWidth() > self:getWidth() then
                self:setWidth(v:getWidth())
            end
            v:setY(self:getHeight())
            self:setHeight(self:getHeight() + v:getHeight())
        end
        self:setX(self.base_x - self:getWidth() )
        self:setY(self.base_y - self:getHeight() )
    end
end