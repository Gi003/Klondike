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

Assets – all made by me/none.