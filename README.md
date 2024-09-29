# YouApp Technical Test

This is a Flutter project for the YouApp technical test. The application demonstrates the use of various Flutter packages and state management solutions to create a functional mobile application.

## Features

- State management using `flutter_bloc`.
- User authentication and profile management.
- Image picking functionality.
- Local storage with `shared_preferences` and `sqflite`.
- Cached network images for efficient loading.
- Responsive UI with `Google Fonts`.

## Dependencies

The following dependencies are used in this project:

- `flutter_bloc`: For state management.
- `equatable`: For value comparison in Bloc.
- `google_fonts`: To use Google Fonts in the app.
- `http`: For making HTTP requests.
- `shared_preferences`: For storing simple key-value pairs.
- `intl`: For internationalization and date formatting.
- `image_picker`: For picking images from the gallery or camera.
- `cached_network_image`: For caching images from the network.
- `sqflite`: For SQLite database access.
- `flutter_cache_manager`: For managing cached files.
- `path_provider`: For accessing commonly used locations on the filesystem.
- `hydrated_bloc`: For persisting Bloc state across app restarts.
- `go_router`: For routing and navigation.

## Folder Structure

The project follows a modular folder structure for better organization:

```
lib/
├── core/
│   ├── api/
│   ├── assets/
│   ├── constants/
│   ├── extensions/
│   ├── router/
│   └── secret/
├── data/
│   ├── models/
│   └── repositories/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

## Getting Started

To get started with this project, clone the repository and run the following commands:

```bash
flutter pub get
```

### Running the App

To run the application on a simulator or a physical device, use:

```bash
flutter run
```

### Building APK

To build an APK for Android, use:

```bash
flutter build apk --release
```

## Usage

This application serves as a technical test for evaluating your skills in Flutter development. You can explore the various features implemented and modify them as needed.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

Feel free to adjust any section as needed! If you have more questions or need further assistance, let me know!