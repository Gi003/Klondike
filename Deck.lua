function refill(stack, source_table, num)
    -- Empty stack into reserve
    while stack:num_cards() > 0 do                           -- THIS IS BECAUSE GOOFFY AHH HAS BOUNDS IN CARDS LIS
        card = stack:remove(1)
        table.insert(source_table, card)
    end

    -- Add from reserve
    for i=1, num do 
        local index = math.random(1, #source_table)
        card = table.remove(source_table, index)
        stack:insert(card)
    end
end

function refill_stacks(stack, source_table, num)
    -- Empty stack into reserve
    while stack:num_cards() > 0 do                           -- THIS IS BECAUSE GOOFFY AHH HAS BOUNDS IN CARDS LIS
        card = stack:remove(1)
        source_table:insert(card)
    end

    -- Add from reserve
    for i=1, num do 
        local index = math.random(1, source_table:num_cards())
        card = source_table:remove(index)
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
        local stack = Stack:constructor(i*100, 50, "spread")
        refill(stack, deck, i)
        stack:open_top_card()
        table.insert(board, stack)
    end

    -- Foundation
    for i=1, 4 do
        local stack = Stack:constructor(200 + (i*100), 400, "overlap")
        table.insert(board, stack)
    end

    --  Reserve 
    local stack = Stack:constructor(200, 400, "spread")
    refill(stack, deck, 3)
    stack:open_cards()
    table.insert(board, stack)

    -- Reserve pile
    local stack = Stack:constructor(100, 400, "overlap", "reserve")
    refill(stack, deck, #deck)
    stack:close_cards()
    stack:open_top_card()
    table.insert(board, stack)

    for i=1, #board do
        board[i]:update_position()
    end

    return board
end



