-- Stack class ---------------------------------------
Stack = {}
Stack.__index = Stack

function Stack:constructor(x, y, spread, type)
    local self = {}
    self.card_stack = {}
    self.data = {}
    self.data.x = x
    self.data.y = y
    self.data.y_interval = 25
    self.data.type = type or "normal"
    self.data.display = spread
    self.cap = Bounds:constructor()
    setmetatable(self, Stack)
    return self
end

-- Access functions---------------------------------------------
function Stack:num_cards()
    return #self.card_stack
end

function Stack:get_bounds()
    return self.cap
end

function Stack:get_last()
    return self.card_stack[self:num_cards()]
end

function Stack:get_cap()
    return self.cap
end

function Stack:get_display()
    return self.data.display
end

function Stack:get_type()
    return self.data.type
end


-- Methods----------------------------------------------------

function Stack:remove(item_index)
    card = self.card_stack[item_index]
    table.remove(self.card_stack, item_index)
    return card
end

function Stack:insert(item)
    table.insert(self.card_stack, item)
end

function Stack:open_top_card()
    if self:num_cards() > 0 then
        local card = self.card_stack[self:num_cards()]
        card:change_state("idle")
    end
end

function Stack:close_cards()
    for i=1, self:num_cards() do 
        self.card_stack[i]:change_state("closed")
    end 
end

function Stack:open_cards()
    for i=1, self:num_cards() do 
        self.card_stack[i]:change_state("idle")
    end 
end

function Stack:find_card(x,y)
    for i=1,self:num_cards() do
        local card = self.card_stack[i]
        if (card:is_valid(x,y)) then
            return card, i
        end
    end
        print("Couldnt find card")
        return nil, nil
end

function Stack:update_position()
    if self.data.display == "spread" then 
        for i=1, self:num_cards() do 
            self.card_stack[i]:move2(self.data.x, self.data.y + (self.data.y_interval* (i-1)))
        end
        self.cap:move2(self.data.x, self.data.y + (self.data.y_interval* (self:num_cards())))
    else 
        for i=1, self:num_cards() do 
            self.card_stack[i]:move2(self.data.x, self.data.y)
        end 
        self.cap:move2(self.data.x, self.data.y)
    end

end

function Stack:draw()
    for i=1, self:num_cards() do 
        local card = self.card_stack[i]
        card:draw()
    end
        self.cap:draw()
end