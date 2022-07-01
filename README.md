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
