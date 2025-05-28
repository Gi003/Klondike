Prototype Pattern – 
* The key idea for the prototype pattern is that an object can generate other objects similar to itself.
 I used this to populate each tableau card pile. My card creation process reuses a consistent constructor, which acts as the prototype for all 52 cards.

Update Method Pattern
* I applied the Update Method Pattern when drawing cards to the window. 
This pattern was necessary to ensure that the top cards in each tableau pile were updated and displayed correctly.
 By calling update methods on each object every frame, I kept the visual state aligned with the game state.


I struggled to organize my code from the beginning.
I would often get overwhelmed from the interconnected mess I would write the previous session, and try to rewrite it in order to understand how to move forward.
For example, I went from hardcoding card interactions to redesigning a more modular hierarchical setup. 
I ultimately turned in this assignment late due to me attempting to do the extra credit, but I was unable to find a way to do it cleanly.


One of my main pain points is mouse input handling. ‘it feels messy and overly reliant on global variables, which hurts readability. 
I think that using the Command programming pattern would be a smart move for me to decouple input logic from game logic, to improve readability and modularity. 

The people that gave me feedback on my code were Kenshin Chao, Marcus Ochoa and Phinhas.
The feedback that I got was mostly related to my naming of variables, which I was told were unclear. In order to improve on this I decided to use official solitaire pile terminology, and to limit the names of methods to their most essential action that they were performing. As for the patterns, I was told that my main.lua file was readable – though towards the end, I noticed that my deck.lua file was getting a bit out of hand in terms of unorganized code. I sensed I was losing a little bit of steam as I implemented the ending screen and conditions, as my code got more intrusive in accessing data that was previously carefully modularized or performing calculations where it shouldn't. 

Assets – all made by me/none.
