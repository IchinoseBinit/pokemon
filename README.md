# Flutter Pokédex App

Welcome to the PokeApp! This app allows you to view a list of Pokémon with their names, images, and types. You can also filter the list by entering keywords to find specific Pokémon.

## Requirements

Before running the app, make sure you have the following requirements:

- Flutter SDK: Make sure you have installed the Flutter SDK on your machine. You can download it from the official website: https://flutter.dev/docs/get-started/install
- Dart: Flutter projects require Dart language support. Ensure you have Dart installed as well.
- Dart Frog: A fast, minimalistic backend framework for Dart 🎯. You can install it from here: https://pub.dev/packages/dart_frog
- Android Emulator or iOS Simulator: You can run the app on a physical device or a simulator/emulator.
- Internet Connection: The app relies on the PokeAPI to fetch Pokémon data. Please ensure you have an active internet connection.

## Getting Started

Follow these steps to set up and run the PokeApp:

- Clone the repository:

        git clone https://github.com/IchinoseBinit/pokemon.git
        cd poke_backend

- Install dart frog 
  
        dart pub global activate dart_frog_cli
        
- Run the server

        dart_frog dev

- Change directory to the flutter app

        cd ..
        cd poke_app

- Get the IP of the device

        - ipconfig (for windows)
        - ifconfig (for mac/linux)

- Paste the IP in the urls file
    ``` dart
    // Inside the AppUrls class,
    static const _baseUrl = "http://192.168.1.67:8080";
    // Change the ip to your device IP
    // If the device IP is 192.168.0.100, like this
    static const _baseUrl = "http://192.168.0.100:8080";
    ```


- Install Dependencies
  
        flutter pub get

- Run the app
  
        flutter run




## Features

- View a list of Pokémon with their names, images, and types.
- Use the search field to filter Pokémon by name.
- Cached API responses for an hour to improve performance.


## Technology Stack

- Flutter: The framework for building the cross-platform mobile app.
- Dart: The programming language used with Flutter.
- Riverpod: The package used for managing states.
- Dart Frog: The backend framework for Dart used for proxying API calls from mobile app to https://pokeapi.co
- Dio: A powerful HTTP client for fetching data from the Dart Frog server.
- Hive: A local database used for caching API responses.

## Website URL

The current developed website is hosted using firebase at: https://poke-app-e5dad.web.app/#/

## Contributing

We welcome contributions to improve the Flutter Pokédex App. If you find any bugs or have feature requests, please open an issue or submit a pull request.

Happy Pokémon hunting! 🐾
