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
- ListView is overlapped by take Photo button
- going back from preview freezes camera

## Sources
- [Camera](https://medium.com/@fernnandoptr/how-to-use-camera-in-flutter-flutter-camera-package-44defe81d2da)
- [Button Navigation Bar](https://www.fluttercampus.com/guide/77/how-to-set-notched-floating-action-button-in-bottom-navigation-bar/)
- [Fetch data with http](https://docs.flutter.dev/cookbook/networking/fetch-data)