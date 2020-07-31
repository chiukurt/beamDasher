# beamDasher

### Current plan

* Experiment with calculation optimization, 3D rendering, AI (potentially)
* Multi-leveled survival game
* Player and enemies create a trail when moving
* Player collision with the trail will end the game
* Quantity of enemies will increase with level (potentially their intelligence as well)
* The goal of the game is to advance to the next level by being the 'last one standing'
* Player potentially has the ability to boost speed and jump (Maybe pickup powerup with timers)
* Score will be shown after game over. Score will be shown as time taken and stage achieved

<hr>


### TODO / Current questions
 
* Optimize collision detection

        Split the map into 'chunks' 
        Perform collision detection only within these localized areas
        
        Extend Renderable to create a 'Collidable' class
        Eventually extend Collidable to create a 'Movable' class
        
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
