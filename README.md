As part of my latests interviewing process, I was asked to complete a coding challenge and was asked to made it public.

  

This is the result of such exercise. It is my believe that it showcases my coding and architecting skills.

  

A few notes/considerations:

- Why `freeza`? Names change often, so I give all my projects code names. Lately, I’ve been using [DBZ characters](https://en.wikipedia.org/wiki/Freeza).

- For the image downloads I turned `Allow arbitrary loads` instead of whitelisting domains because I don’t know where those images will be coming from. I’m no reddit API expert and it exceed the scope of this exercise.

- I did a round of testing for leaks and found none.

- As a performance improvement, downloaded thumbnails should be stored in disk and fetched from the table view cells instead of stored in the cell’s view model. It uses too much memory this way. I judge it, again, out of the scope of this exercise.

  

For the bonus points:

* Saving pictures in the picture gallery

Since I’m explicitly asked not to implement IMGUR API I can’t obtain the image, thus, can’t save it to the __picture gallery__.

  

* App state preservation/restoration

Would require a bit more effort than I’m ready to put into the exercise. Would require to store all model, view models, and state of the app. Some of those may become out of sync, specially paging… In short, too complex for the chosen architecture.

  

* Support iPhone 6/ 6+ screen size (hint: size classes)

iPhone 6/ 6+ already supported with autolayout.

  

  


  

Reddit API : http://www.reddit.com/dev/api

Apigee :https://apigee.com/console/reddit


Cesar's Documentation

The project is using cocoa pods, for this reason is important to execute pod install before start testing the code

These are the new requirements for this project:
1.  Remove the deprecated components(UIWebView)
2.  Add a tab bar controller with the following options(top, favorite, settings)
3.  Add a favorite screen with the options to see the favorite items, the user is able to uncheck it and remove it from the list
4.  Add a settings screen, This will have an option to change the state of Safe (NSFW disabled)(between ON/OFF) the default option will be OFF.
5.  In the top list if the Safe (NSFW disabled) option is enabled, the app will show all the content without any restrictions , in the case it's OFF the list will be put a mask over image of the NSFW content and when the user presses over the row the cell will have a shake animation
6.  The top list will have a heart button per row, it will work to add or remove a favorite
7.  The touch action in the top list will be for all the row not only the image, an important point here, we are going to add a heart button this means the row will have 2 actions if you press the button this will execute the logic for the favorite feature, if you touch any other area of the row, this will open the detail view
8.  The detail view will have the heart button too(right upper corner) This will be the same feature we have in the point 6
9.  Analytics and Crashlytics are nice to have and we are going to put them in our wish list
10.  Elements showing more than 24 hours in the creating field will be replaced by the word: "Older", Example: in this moment the app is showing this: a day ago, instead of this text the app will show Older(check the image in this message)

The project is using an architecture called clean swift:  https://clean-swift.com
The DB used is: Realm: https://realm.io
The app is using KVO to detect the changes in the safe value(settings screen) in this way the app is able to refresh the views
The app is observing the changes in the DB also it's encrypted in the DB
The app is using the repository pattern to be able to switch the data between the real API and some mock data, this is helpful for the unit tests
I did refactor in the previous work to be able to reuse as much as possible for the new Favorites Scene

The project has warnings related with tab bar icons, this is because the project should support iOS 12 and some of those icons were introduced on iOS 13 or 14. I didn't want to spend time looking for those icons I preferred to spend it in the refactor and complete the test

Recommendations:
1. Add the protocol Decodable to the EntryModel, in this way the map between a json an a native object will be better
2. Replace the way how the images are retrieving from internet, the current way is expensive because it downloads the image every time the user does scroll
3. Add a typed library to avoid used the normal strings to make references to colors, strings, etc, This is an example: https://github.com/mac-cain13/R.swift
4. Improve the way how the errors are handled in the map, this means create a structure that contains all the errors like an enum to avoid use strings for errors, in this way is better to compare in this case if it's necessary

