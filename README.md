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

## Sources
- [Camera](https://medium.com/@fernnandoptr/how-to-use-camera-in-flutter-flutter-camera-package-44defe81d2da)
- [Button Navigation Bar](https://www.fluttercampus.com/guide/77/how-to-set-notched-floating-action-button-in-bottom-navigation-bar/)
- [Fetch data with http](https://docs.flutter.dev/cookbook/networking/fetch-data)
- [Base64 Images](https://www.bezkoder.com/dart-base64-image/)
- [Navigaor](https://stackoverflow.com/questions/59212860/how-can-i-pop-to-specific-screen-in-flutter)
- [AppBar Buttons](https://www.didierboelens.com/2018/04/hint-1-hide-back-arrow-and-use-close-button/)
- [Navigate with named routes](https://docs.flutter.dev/cookbook/navigation/named-routes)

## Benennung
Separation of concern

- Function -> lowerCamelCase (english verb)
- Class -> CamelCase
- Screen -> ___Screen (bsp. HomeScreen)
- Files -> snake_case 
- Variables -> lowerCamelCase