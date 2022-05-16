# Numbers Interview Takehome

This app provides the core functionality requested in the take home assignment.I chose a basic MVVM architecture with a simple dependency injection container. The API client uses a 'functional' implementation rather than a protocol. I've been experimenting a bit with functional Swift recently and its been useful. To avoid mutable state and optional values in views, so I chose to not use storyboards in favor of custom initializers on all view controllers. I am happy to use Storyboards, but when given the choice I prefer #nibless.

## Specs & Features ##

- Built in XCode 13.1
- iOS 14+ support
- Universal (iPad & iPhone)
- Newer UISplitViewController apis used to provide nav stack in compact size and side by side on an iPad
- Fetch and display a list of numbers
- Display a detail view with text and image of number
- All device sizes and orientations
- Colors change for each row state
- 50% split between primary & secondary 

## Incomplete / Remaining issues ##

- Ran into a strange issue getting autolayout to work in the detail view of the splitview, so I fell back to using layout mask for the DetailVC, this is not acceptable for production, but should suffice for now.
- Needs unit tests on the view controllers
- Didn't write any ObjC classes, but I certainly could have. 


