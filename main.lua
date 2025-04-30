io.stdout:setvbuf('no')
require("Card")
require("Stack")
require("Deck")

--------------------------------------------------------
function check_move(deck, stack, card, card_i)
    for i=1, #deck do
        bounds = deck[i]:get_cap()
        if bounds:isOverlapping(card) then
            print("Overlap")
            stack:remove(card_i)
            deck[i]:insert(card)
            stack:open_top_card()
            return true
        end
            -- Not in correct area
    end
    return false
end
-- Loading----------------------------------------------
function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0, 0.7, 0.2, 1)
    standard_deck = generate_deck()
    board = initialize_board(standard_deck)
end

-- Logic------------------------------------------------
function love.update()
end
-- Graphics---------------------------------------------
function love.draw()
    for i=1, #board do
        stack = board[i]
        stack:draw()
    end
end

dragging = false
active_card = nil
stack = nil
card = nil
card_index = nil
--Mouse Events------------------------------------
function love.mousepressed(x, y, button)
    if button == 1 then -- left click
        for i=1, #board do
            local stack = board[i]
            card, card_index = stack:find_card(x, y)

            if card ~= nil then
                if stack:get_type() == 'reserve' then
                    refill_stacks(board[#board-1], board[#board], 3)
                    board[#board-1]:open_cards()
                    
                    break
                end
                active_card = card
                active_stack = stack
                dragging = true
                active_card:set_offset(x,y)
                break
            end
        end
    end
end

function love.mousemoved(x,y,dx,dy)
    if dragging then
        active_card:drag_move(x,y)
    end
end

function love.mousereleased(x, y, button)
    if button == 1 then -- left click
        print("Mouse released at", x, y)
        if active_card ~= nil then 
            check_move(board, active_stack, active_card, card_index)
        end
        for i=1, #board do
            board[i]:update_position()
            if board[i]:get_display() == "overlap" and board[i]:get_type() == "normal" then 
                board[i]:close_cards()
                board[i]:open_top_card()
            end
        end
        dragging = false
        active_card = nil
        stack = nil
    end
end