# translationGame
Babbel interview technical assignment

Thanks for taking the time to look over the technical assignment.
This readme will explain a bit of my thought process.
This is written first thing during my development process, any edits are appended and not replaced to see the transition. 

App logic:
----------
I attached a diagram that explain the Main App Logic. 
I will have 4 main compartments:
  1. GameProtocol 
    * This part is responsible to communicate with any part that needs edit the current game.
    * It is responsible for starting, resetting, verifying, getting the next level, and quitting the game.
    * This protocol will have a weak reference of the Logic protocol as well to know what to do with the data/input.
    * This Protocol will also have the counters for correct/incorrect answers.

  2. LogicProtocol
    * This part controls the logic of our game.
    * This part determines if the answer is correct or not.
    * This part is responsible to retrieve the game data and store it

  3. LevelProtocol
    * This part is a struct that has a specific question and answers

  4. PlayerProtocol
    * This part is the player playing this game

Now it might not sound logical that I have a player protocol instead of a regular current player object, the reason behind it is what if we were to introduce a multiplayer game where 2 or more players can participate	in a quiz like competition.

Infrastructure:
---------------
I will be using those 3 libraries, imported via cocoa pods
  1. RxCocoa
  2. RxSwift
  3. Snapkit

Snap kit is a library used to set the constraints of the UI in a more readable way.
I will be using MVVM as a development pattern


UI:
---
I will be using UIKit to create my UI using anonymous closure style.
The reason behind it is that it run a lot smoother and compiles faster than storyboards, and it has a much wider compatibility bracket than SwiftUI.

Testing:
--------
I will not be using any 3rd party library for unit tests, instead I will be relying on the native XCTest platform provided by Apple.

This should give enough insight to how I will be tackling the development. 

-----------------------------------------------------------------------------------

Ending Notes:
-------------
It was really fun working on this assignment

I know the requirements said to animate the Spanish word, but I added a bit of text to it to make it look nicer, so I chose to animate the english word instead.

The architecture is almost intact, I modified the functions a bit, but it is still there.


Time:
-----
It took me around 6 hours for the whole thing
1:00 hours Ideating, setting the architecture, and drawing the diagram
2:00 hours implementing the diagram (TDD)
1:00 hour creating the UI
1:00 hour 2nd and 3rd milestore
1:00 hour testing + double checking unit tests

Decisions:
----------

I personally prefer to have the timer display as a circle filling up, but due to time constraints i stuck to a label.
That would be the first thing I revisit!

I would definitely revisit the design, adjusting the fonts and the general layout.

Looking forward to hearing from you.
