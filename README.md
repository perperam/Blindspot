# User documentation
## First steps
When the app is opened for the first time, you will be redirected to the login screen. From there, you will be taken to the Home screen, which allows you to view your current pictures and adjust your settings. You can also use the actual Blindspot function via the Camera button.
Have fun!

## Login screen
 On the login screen, you will be presented with several options for authenticating yourself in the app.
- Create an account via email
- Login via a Google Account
- Use the app without logging in
These options are all equivalent for using the app's functions.

## Home Screen
The home screen is the central point of the app. From here you can get everywhere. Swipe left or right to switch between the list of pictures you have taken so far and the app settings. You can also use the buttons at the bottom of the screen. If you want to use the Blindspot function, press the camera button.

## Picture list
All pictures taken with the Blindspot function are displayed here. If you want to take a closer look at one, simply select it. You will then be redirected to the picture display.

## Settings
In the settings you can see the following:
- The current login status
- A darkmode setting
- A button with which you can delete all the pictures you have taken so far.
- A button to return to the login screen.
- The version of the app

## Blindspot function
The camera button on the home screen takes you to the camera with which you can take a picture of your surroundings. This is evaluated for you and in a preview you can now see what objects have been detected. Swipe down to see the exact data for the picture. At the top right of the bar you can save the picture and give it a name.
On the left you can discard the picture and return to the home screen.

## Image display
Here you can take a closer look at your saved image. By swiping downwards you can see the exact data for the picture.

# Developer documentation
## 

# MOB Dokumentaion
## Functional Requirements
<table border="1" cellpadding="1" cellspacing="1" style="width:500px;">
	<thead>
		<tr>
			<th scope="col"><p>Task</p>
			</th>
			<th scope="col">In our App</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>AF1<br />
			Routes and Tabs</td>
			<td>- Login Screen<br />
			- Create Account Screen<br />
			- Home Screen<br />
			- Gallery Tab<br />
			- Settings Tab<br />
			- Camera Screen<br />
			- Image preview Screen<br />
			- Image view Screen</td>
		</tr>
		<tr>
			<td>AF2<br />
			ListView or GridView</td>
			<td>- Gallery View<br />
			- Object and metadata View</td>
		</tr>
		<tr>
			<td>AF3<br />
			Sensor or API</td>
			<td>- Camera sensor to take pictures<br />
			- API that evaluates the pictures</td>
		</tr>
		<tr>
			<td>AF4<br />
			Authentication</td>
			<td>- No login option<br />
			- Email login option<br />
			- google login option</td>
		</tr>
        <tr>
			<td>AF4<br />
			Cloud Sync</td>
			<td>NONE?</td>
		</tr>
	</tbody>
</table> 


# App GUI structure (screens)
- login
- home
- image_view

## login
- appbar
- logo
- app title
- user input
- password input
- enter/login button
- on login to home screen 

## home
- swipe between tabs
- take photo tab
- gallery (list view) of photos tab
- settings tab

### TakePhotoTab
- live camera
- take photo button
- 
### GalleryTab
- taken photos in a list view
- short photo info
- on click to image_screen view

### SettingsTab
- darkmode
- api settings
- logout

## image_view screen 
- a more detailed photo view with more metadata

# TO-DO's
- comments
- naming of functions and classes
- rename option for preview screen
- ListView is overlapped by take Photo button
- going back from preview freezes camera
- Navigate with named routes
- delete files when logout?
- screen_imageview local storage abstraction not used
- rework this readme
- save data to cloud
- working logout
- rework camera screen layout (add close button, etc.)
- rework initState when changing something in local storage
- fix @immutable error in classes
- rework file tree

- Settings ImageViewer

## Sources
- [Camera](https://medium.com/@fernnandoptr/how-to-use-camera-in-flutter-flutter-camera-package-44defe81d2da)
- [Button Navigation Bar](https://www.fluttercampus.com/guide/77/how-to-set-notched-floating-action-button-in-bottom-navigation-bar/)
- [Fetch data with http](https://docs.flutter.dev/cookbook/networking/fetch-data)
- [Base64 Images](https://www.bezkoder.com/dart-base64-image/)
- [Navigaor](https://stackoverflow.com/questions/59212860/how-can-i-pop-to-specific-screen-in-flutter)
- [AppBar Buttons](https://www.didierboelens.com/2018/04/hint-1-hide-back-arrow-and-use-close-button/)
- [Navigate with named routes](https://docs.flutter.dev/cookbook/navigation/named-routes)
- [Navigator in async functions](https://stackoverflow.com/questions/69466478/waiting-asynchronously-for-navigator-push-linter-warning-appears-use-build)

## Benennung

Separation of concern

- Function -> lowerCamelCase (english verb)
- Class -> CamelCase
- Screen -> ___Screen (bsp. HomeScreen)
- Files -> snake_case 
- Variables -> lowerCamelCase
