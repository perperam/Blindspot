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
## Building the app
### Requirements
[Install Android Studio](https://docs.flutter.dev/development/tools/android-studio) or another IDE of your choice. Then clone this repository and open it.
```
git clone https://github.com/perperam/Blindspot.git
```
### Build the App
Install the necessary dart and flutter packages. More information about the packages used and the versions can be found in the `pubspec.yaml` file.

```
flutter pub get
flutter pub upgrade
```

To Build the App to an APK use this command:

```
flutter build apk --release --split-per-abi
``` 

### Installation
Move your APK to your Android device and install it with the necessary permissions:

- The app Requires access to the camera
- The app needs access to the microphone.

### Troubleshooting
If the app icons do not work properly, reload them.
```
flutter pub get
flutter pub run flutter_launcher_icons
```


## Directory structure
The directory is structured as follows. The basic directory contains `main.dart`, which is used to run the app. The 'pubspack.yaml' contains information about the libraries used. The functionality of the app is divided into the directories `assets`, `config`, `screens` and `reusable` .

| directory | function |
| - | - |
| `assets` | Here all constant files are stored |
| `config` | Configuration like colours or URIs are stored here. |
| `screens` | Gives the "physical" structure of the app. Here you will find the various pages that can be called up and in the `_tab` directories the tabs are sorted according to their screens. |
| `reusable/widgets` | This is where the widgets are stored that are accessed from different places or screens. |
| `reusable/functions` | This is where functions are stored that are used repeatedly in various places in the app. | 

The rest of the directory follows the familiar Flutter and Android Studio structure. See [Flutter documentation](https://docs.flutter.dev/) for more information.

## External functions
### API
A YOLOv5 classifier is integrated as a REST API. This can be configured via the `api_access.dart` file in the config directory.

### Cloud and login
The cloud and login is realised via Firebase and Firestore from Google. More information about this can be found in the `firebase_options.dart` file.

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
			- Google login option<br />
			- Create Account</td>
		</tr>
        <tr>
			<td>AF4<br />
			Cloud Sync</td>
			<td>Dark Mode in Firestore</td>
		</tr>
	</tbody>
</table> 


# TO-DO's
- more comments
- naming of functions and classes
- rename option for preview screen
- ListView is overlapped by take Photo button
- going back from preview sometimes freezes camera
- Navigate with named routes
- delete files when logout?
- screen_imageview local storage abstraction not used
- rework this readme
- working logout
- rework camera screen layout (add close button, etc.)
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
- [Change App Name](https://www.flutterbeads.com/change-app-name-in-flutter/)

## Benennung

Separation of concern

- Function -> lowerCamelCase (english verb)
- Class -> CamelCase
- Screen -> ___Screen (bsp. HomeScreen)
- Files -> snake_case 
- Variables -> lowerCamelCase
