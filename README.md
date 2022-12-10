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
- Kommentare
- Benennung
- Safe/Delete butten bei Photopreview
- ListView is overlapped by take Photo button
- going back from preview freezes camera
- Navigate with named routes

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

- Funktion -> lowerCamelCase (englisches verb)
- Class -> CamelCase
- Screen -> ___Screen (bsp. HomeScreen)
- Datein -> snake_case 
- Variablen -> lowerCamelCase