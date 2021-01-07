As part of my latests interviewing process, I was asked to complete a coding challenge and was asked to made it public.

This is the result of such exercise. It is my believe that it showcases my coding and architecting skills.

- For the image downloads I turned `Allow arbitrary loads` instead of whitelisting domains because I don’t know where those images will be coming from. I’m no reddit API expert and it exceed the scope of this exercise.


Reddit API : http://www.reddit.com/dev/api

 These are the points we are going to cover for this update:  

1.  Remove the deprecated components(UIWebView)
2.  Add a tab bar controller with the following options(top, favorite, settings)
3.  Add a favorite screen with the options to see the favorite items, the user is able to uncheck it and remove it from the list
4.  Add a settings screen, This will have an option to change the state of SAFE(between ON/OFF) the default option will be OFF.
5.  In the top list if the SAFE option is enabled, the app will show all the content without any restrictions , in the case it's OFF the list will be put a mask over image of the NSFW content and when the user presses over the row we have two options: a) the app does nothing, or the app can show a message indicating to the user the following: Title: This is not safe content, Message: If you want to see this content, please go to the settings screen and set your preference there. Button: Ok. Please let me know which option do you prefer or if you want to change the text of this dialogue
6.  The top list will have a heart button per row, it will work to add or remove a favorite
7.  The touch action in the top list will be for all the row not only the image, an important point here, we are going to add a heart button this means the row will have 2 actions if you press the button this will execute the logic for the favorite feature, if you touch any other area of the row, this will open the detail view
8.  The detail view will have the heart button too(right upper corner) This will be the same feature we have in the point 6
9.  Analytics and Crashlytics are nice to have and we are going to put them in our wish list
10.  Elements showing more than 24 hours in the creating field will be replaced by the word: "Older", Example: in this moment the app is showing this: a day ago, instead of this text the app will show Older(check the image in this message)
  

The project is using cocoa pods, for this reason is important to execute pod install before start testing the code

The project is using an architecture called clean swift:  https://clean-swift.com

The DB used is: Realm: https://realm.io

The app is using KVO to detect the changes in the safe value(settings screen) in this way the app is able to refresh the views

The app is observing the changes in the DB also it's encrypted in the DB

The app is using the repository pattern to be able to switch the data between the real API and some mock data, this is helpful for the unit tests

I did refactor in the previous work to be able to reuse as much as possible for the new Favorites Scene


Recommendations:

1. Add the protocol Decodable to the EntryModel, in this way the map between a json an a native object will be better

3. Add a typed library to avoid used the normal strings to make references to colors, strings, etc, This is an example: https://github.com/mac-cain13/R.swift

4. Improve the way how the errors are handled in the map, this means create a structure that contains all the errors like an enum to avoid use strings for errors, in this way is better to compare in this case if it's necessary