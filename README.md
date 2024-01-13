# SFF
A hybrid 2D/3D action platformer, notable features are the engine design, and hacks into flash to help with artist rapid iteration


 -The game was made in actionscript 2012 I started at the time Animate had really great soup to nuts art to code support you could create edit and integrate your code really quickly unfortunately the project grew bigger than the Animate editor could handle so I ended up having to come up with other rapid itteration solutions.


- There are three Main Projects that make up the game, the Level Editor, the game(Level Editor), and Module2. they are all pretty self explanatory what they do barring Module 2 so I'll start explaining what it's purpose was.

 -Module 2 works like a dll.
 
 -StarlingProject The game Engine has a few notable features.. mostly for their absense in most 2d Actionscript games, the Behaviour Tree is a design feature that I look back on now and I was way too into OOP. But nonetheless its still has some interesting features that allow it to run through a combination of different states, making it easy to achieve a really interesting AI. but I think it may have a lot of overhead for very little gain frankly. the Director is pretty cool though, it handles behaviour states to influence at a level of abstraction to tell stories but the specifics of how they are implemented are handles by the individual actors in game. ie the Director will say something generic like these actors  are going to move away from another actor, as a result, the actors can choose based on their individual variables how they will move away, if they are scared defiant etc. The ground path system is interesting as well. I realized that if you have a quick moving character yet your moving in 3d it's hard to get the best camera angle that will also convey the scene the best.. but considering a character is moving quickly there is inertia, if you put them on a path it's really easy for your animators to create really compelling scenes, playing to the camera, and then once you create the scene. you can move the path to an alternate point and the artist can reshoot that scene, and you can just blend between the two of them. giving you a handcrafted feel no matter where the player chooses to move.
