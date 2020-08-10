# beamDasher

### Current plan

* Experiment with calculation optimization, 3D rendering, AI (potentially)
* Multi-leveled survival game with scaling difficulty

* Player potentially has the ability to boost speed and jump (Maybe pickup powerup with timers)
* Player and enemies create a trail when moving
* Player or enemy collision with any trail will destroy the entity
* If the Player is destroyed, the game is considered over
* Score will be shown after game over. Score will be shown as time taken and stage achieved
* The goal of the game is to advance to the next level by being the 'last one standing'
* Quantity of enemies will increase with level (potentially their intelligence, turning ability, etc)



<hr>

Up
### TODO / Current questions
 
* Optimize collision detection

        Split the map into 'chunks' 
        Perform collision detection only within these localized areas
        
        --Non-moving point strategy--
        Use a 2D array to store 'Chunk' object
        Each 100x100 area will be considered a 'Chunk'
        Each 'Chunk' will have an arrayList containing all beamPoints within the 100x100 area
        This will be accomplished by adding the BeamPoint to the ArrayList upon BeamPoint initialization
        To determine which 'Chunk' a point resides in, divide each coordinate by 100 and round down
        Example: Point(543,8295) would be in Chunk(5,82)
        
        This will be used for both Player to BeamPoint collision as well as Enemy navigation 
        
        Extend Renderable to create a 'Collidable' class
        Eventually extend Collidable to create a 'Movable' class
        
* Enemy navigation
        
        Given the chunk the Enemy is in, check a number of chunks ahead of Enemy
        Check a number of chunks to the left and right of that chunk
        Check each chunk to determine if they have any BeamPoints
        For each chunk free of BeamPoints, randomly pick a chunk to move towards
        Adjust the heading angle/goal of the Enemy to navigate towards the chunk
        Once the chunk is reached, perform process again
        This method will give each Enemy a slight delay in reaction time, which will give the player the edge
        
* Customize lighting

      Distinguish between Renderable objects that are and aren't affected by lighting
 
* Make a UI that follows the player camera and angle
      
      Give the UI a 'not affected by light' attribute 
      rotate and skew the UI to fit the user viewpoint
      
* Create enemies that scale in number based on level
        
        Optimize calculations to allow for this without being too taxing on memory (able to run smoothly on android)
        Enemies will have the same base speed and turn speed as the player
        Enemies will be able to look ahead forward and to both sides in order to plan their turns and avoid collisions
        
  
 * <del> Fix jumping collision </del>
 * <del> Handle multiple tap inputs on android to allow jumping and acceleration independant from turning  </del>
 * <del> <del> Turn double click to jump into an upwards swipe to jump </del>
 * <del> Turn acceleration into double tap </del>
 
 
 

 
 * re-enable death
<hr>


<hr>
