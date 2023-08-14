# Cloudwalk NASA challenge

Hello, this is a showcase test for the Cloudwalk NASA challenge. In this app we use flutter to
create a simple app that fetches data from the NASA's Astronomy Picture of the Day API and displays
it in a gallery.

The apps contains two screens, the first one is the picture of the day, and the second one is a
gallery with the last 30 days of pictures.

The app is divided into 3 sections:

1. The Home Page - This is the main page of the app. It displays the image of the day, and a list of
   the previous images.
2. The List Page - This page displays a list of the previous images. You can scroll through the
   list, and tap on an image to view it.
3. The Settings Page - This page allows you to control the audio playback of the app. You can toggle
   the audio on/off, and control the audio playback.

## How to run

The project can be expanded to have multiple entrypoints, with different environments.
For now, just have the production entrypoint. Since this is a showcase app.

`flutter run -t ./lib/entrypoint/production.dart`

## How to test

`flutter test`

## How to build

`flutter build apk --release -t ./lib/entrypoint/production.dart`

## Folder and file structure

For this project a mixed and more simply version of
the [Clean Architecture](https://devmuaz.medium.com/flutter-clean-architecture-series-part-1-d2d4c2e75c47)
with (bloc
architecture)[https://medium.com/codechai/architecting-your-flutter-project-bd04e144a8f1]. This was
chosen because to showcase my knowledge in this architectures.

In the root beyond the flutter folders we have the assets folder, divided in fonts, songs and some
animations and images in the root of the folder.
In the lib folder we have:

- entrypoint: The entrypoint of the app, for now just the production entrypoint.
- envs: The environments of the app, for now just the production environment.
- components: The components of the app, that can be used in multiple places. Or is more generic.
- models: The models of the app, that are used to represent the data.
- providers: The providers of the app, that are used provider and control some feature of the
  smartphone, like the audio, haptics and etc...
- services: The services of the app, that are used to fetch data from the internet, or local db.
- src: The main folder of the app, that contains the pages, blocs, repositories and usecases.
- utils: Wasn't used in this project, but is used to store some utils functions, like formatters,
  validators and etc...
- main.dart: The main file of the app, that is called by the entrypoint. In there we have the
  MaterialApp with the routes and the theme of the app.

Struct of src folder:

- home: The home page of the app, that contains the bottom navigation bar and the pages.
    - components: The components of the home page, that are used in multiple places.
        - list: The list page of the app.
        - today: The today page of the app.
        - settings: The settings page of the app.
        - tutorial.dart: The tutorial page of the app. since was a simple page, I decided to put it
          in the components folder.
- splash: The splash page of the app, that is used to show the logo of the app when the app is
  initializing for the first time. We also could create a properly splash screen for Andoird and
  IOS, but I dind't have time to do it.

Struct of the models folder:

- apod: The model of the apod, that is used to represent the data of the apod.
- apod_unions: The unions of the apod and List<Apod>, that is used to represent the state of the
  apod bloc. [freezed]

## Technical debt

- [ ] Create unit tests for the blocs.
- [ ] Bug audio player needs to click twice to pause the audio.
- [ ] Add more tests for the mains widgets[FullView, ListViewPage, TodayView, SettingsView]
- [ ] The bottom bar is not working properly, when you swipe up to appear the bottom bar.
- [ ] Zoom in the image in the full screen mode.
- [ ] Add a proper splash screen for Android and IOS.
- [ ] Add a proper icon for Android and IOS.
- [ ] Hot reload duplicating the audio player.
- [ ] Flutter analyze 2 info's warnings.

## Devices tested

- Grand Prime Duo [phisical] - AOT - works fine landscape and portrait
- Iphone 14 [simulator] - JIT - works fine landscape and portrait

