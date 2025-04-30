-- CARD CLASS ---------------------------------------
Card = {}
Card.__index = Card

function Card:constructor()
    local self = {}
    setmetatable(self, Card)
    self.x = 0
    self.y = 0
    self.w = 250 * 0.2
    self.h = 350 * 0.2
    self.state = "closed"
    self.offsetX = 0
    self.offsetY = 0 
    
    self.color = nul
    self.suite = nul
    self.number = nul
    return self
end

function Card:drag_move(x, y)
    self.x = x - self.offsetX
    self.y = y - self.offsetY
end

function Card:move2(x,y)
    self.x = x
    self.y = y
end

function Card:set_offset(x,y)
    self.offsetX = x - self.x
    self.offsetY = y - self.y
end

function Card:change_location(x, y)
    self.x = x
    self.y = y
end

function Card:draw()
    if (self.state == "idle") then
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h, 10, 10)
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, 10, 10)
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.print(self.color, self.x, self.y, center);
        love.graphics.print(self.suite, self.x, self.y + 20, center);
        love.graphics.print(self.number, self.x, self.y + 40, center);
    else 
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h, 10, 10)
        love.graphics.setColor(0.25,0.25,0.9)
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, 10, 10)
    end
end

function Card:is_valid(x,y)
    if (self:is_idle()) and (self:in_bounds(x,y)) then 
        return true
    else 
        return false
    end
end

function Card:is_idle()
    return self.state == "idle"
end

function Card:in_bounds(x, y)
    print("in bounds", (x > self.x and x < self.x + self.w) and (y > self.y and y < self.y + self.h))
    return (x > self.x and x < self.x + self.w) and (y > self.y and y < self.y + self.h)
end

function Card:add_data(color, suite, number)
    self.color = color
    self.suite = suite
    self.number = number
end

function Card:change_state(state)
    self.state = state
end


-- BOUNDS OBJECT------------------------------------
Bounds = {}
Bounds.__index = Bounds

function Bounds:constructor()
    local self = {}
    setmetatable(self, Bounds)
    self.x = 0
    self.y = 0
    self.w = 250 * 0.2
    self.h = 350 * 0.2
    return self
end

function Bounds:draw()
    love.graphics.setColor(0,1,0,0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h, 20, 20)
end

-- Using Axis-Aligned Bounding Box (AABB) collision detection:
function Bounds:isOverlapping(b)
    return self.x < b.x + b.w and
           self.x + self.w > b.x and
           self.y < b.y + b.h and
           self.y + self.h > b.y
end

function Bounds:move2(x, y)
    self.x = x
    self.y = y
end