-- Refill from a table
function fill(stack, source_table, num)
    -- Empty stack into reserve
    while stack:num_cards() > 0 do
        card = stack:remove(1, "single")
        table.insert(source_table, card)
    end

    -- Add from reserve
    for i=1, num do 
        local index = math.random(1, #source_table)
        card = table.remove(source_table, index)
        stack:insert(card)
    end
end

-- Refill from stack data type
function refill_stacks(stack, source_table, num)
    print("Source Table", source_table:num_cards())
    -- Empty stack into reserve
    while stack:num_cards() > 0 do
        card = stack:remove(1, "single")
        source_table:insert(card)
    end

    if source_table:num_cards() <= 3 then --------------------------------BAD: refill shoudnt be in charge of handling
        num = source_table:num_cards()
    end
    -- Add from reserve
    for i=1, num do 
        local index = math.random(1, source_table:num_cards())
        card = source_table:remove(index, "single")
        stack:insert(card)
    end
end


function generate_deck()
    local deck = {}
    local suits = {
        red = {"heart", "diamond"}, 
        black = {"spade", "club"}
    }

    for color, symbols in pairs(suits) do
        for index, symbol in ipairs(symbols) do
            for i=1, 13 do 
                local card = Card:constructor()
                card:add_data(color, symbol, i)
                table.insert(deck, card)
            end
        end
    end

    return deck
end


function initialize_board(deck)
    local board = {}
    -- Tableu
    for i=1, 7 do
        local stack = Stack:constructor(i*100 + 200, 50, "spread")
        fill(stack, deck, i)
        stack:open_top_card()
        table.insert(board, stack)
    end

    -- Foundation
    for i=1, 4 do
        local stack = Stack:constructor(1100, (i*100) - 50, "overlap", "foundation")
        table.insert(board, stack)
    end

    --  Reserve 
    local stack = Stack:constructor(100, 150, "spread")
    fill(stack, deck, 3)
    stack:open_cards()
    table.insert(board, stack)

    -- Shuffle button
    local stack = Stack:constructor(100, 50, "overlap", "reserve")
    fill(stack, deck, #deck)
    stack:close_cards()
    stack:open_top_card()
    table.insert(board, stack)

    for i=1, #board do
        board[i]:update_position()
    end

    return board
end

function solitaire_rules(deck, stack, card, card_i)
    print(stack:get_type())
    if stack:get_type() == "foundation" then 
        -- Empty stack
        if stack:get_last() == nil then 
            if card.number ~= 1 then return false else return true end
        elseif stack:get_last().suite ~= card.suite then
            return false
        elseif stack:get_last().number+1 ~= card.number then
            return false
        end
        return true
    else
    -- Empty stack - Wrong entry card
    if stack:get_last() == nil and card.number ~= 13 then 
        print("Empty stack no king")
        return false
     end
    -- Non empty stack - Wrong color - Wrong number
    if card.color == stack:get_last().color then 
        print("Wrong color")
        print(card.color)
        print(stack:get_last().color)
        print(stack:get_last().number)
        print(stack:get_last().suite)
        return false 
    end
    if card.number ~= (stack:get_last().number-1) then
        print("Wrong number")
         return false
    end
    return true
    end 
end

function check_win(board) 
    for i, stack in ipairs(board) do
        if stack:get_type() == "foundation" then
            if stack:num_cards() ~= 13 then
                return false
            end
        end
    end
    return true
end