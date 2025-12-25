# Evently - Flutter Event Management App

[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/AYAEMAD0/Evently_App)

Evently is a comprehensive event management application built with Flutter. It allows users to discover, create, and manage events with ease. The app features robust user authentication, interactive maps for event location, and a personalized experience with theme and language customization.

## ✨ Features

- **User Authentication**: Secure sign-up and login with email/password and Google Sign-In. Includes password reset functionality.
- **Onboarding Experience**: A smooth introduction for new users, allowing them to select their preferred language (English/Arabic) and theme (Light/Dark).
- **Event Management (CRUD)**:
    - **Create**: Add new events with details like title, description, date, time, category, and location.
    - **Read**: Browse all events or filter them by categories such as Sports, Birthdays, Meetings, and more.
    - **Update**: Easily edit a nd update the details of existing events.
    - **Delete**: Remove events you no longer need.
- **Interactive Map View**:
    - Discover events visually on an integrated Google Map.
    - Select event locations precisely using a location picker when creating or editing events.
- **Favorites**: Mark events as favorites for quick access from a dedicated "Love" tab.
-**Profile Management**: View your profile details, including your chosen avatar, name, and email, and securely log out.
- **Localization**: Full support for English (`en`) and Arabic (`ar`) languages.
- **Dynamic Theming**: Seamlessly switch between a beautiful light mode and a sleek dark mode.
- **Event Notifications**: Get timely reminders for upcoming events with local notifications.

## 🏛️ Architecture

The application is built using Flutter and follows the principles of Clean Architecture to ensure a scalable, maintainable, and testable codebase.

- **Presentation Layer**: Built with Flutter and `flutter_bloc` (using Cubits) for state management. The UI is organized into features like `auth`, `onboarding`, and `dashboard`.
- **Domain Layer**: Contains the core business logic, entities (`UserEntity`, `EventEntity`), and use cases (e.g., `AddEventUseCase`, `LoginUseCase`). It is completely independent of other layers.
- **Data Layer**: Implements the repositories defined in the domain layer. It handles data operations, fetching from remote sources (Firebase) and local sources (`shared_preferences`).
- **Dependency Injection**: Utilizes `get_it` and `injectable` for managing dependencies throughout the application.

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- A Firebase project.
- A Google Maps API key.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/ayaemad0/evently_app.git
    cd evently_app
    ```

2.  **Set up Environment Variables:**
    Create a `.env` file in the root of the project and add your Firebase and Google Maps API keys. The app is configured to use different Firebase credentials for each platform.

    ```dotenv
    # Firebase - Android
    FIREBASE_API_KEY_ANDROID=AIz...
    FIREBASE_APP_ID_ANDROID=1:123...
    FIREBASE_MESSAGING_SENDER_ID_ANDROID=...
    FIREBASE_PROJECT_ID_ANDROID=...
    FIREBASE_STORAGE_BUCKET_ANDROID=...

    # Firebase - iOS
    FIREBASE_API_KEY_IOS=AIz...
    FIREBASE_APP_ID_IOS=1:456...
    FIREBASE_MESSAGING_SENDER_ID_IOS=...
    FIREBASE_PROJECT_ID_IOS=...
    FIREBASE_STORAGE_BUCKET_IOS=...

    # Google Maps API Key (for Android & iOS)
    MAPS_API_KEY=AIz...
    ```

3.  **Update Android & iOS Configurations:**
    -   **Android**: The Google Maps API key is automatically read from `MAPS_API_KEY` in your `.env` file. Ensure the `local.properties` file is configured if your Android SDK location is non-standard.
    -   **iOS**: The Google Maps API key is passed in `ios/Runner/AppDelegate.swift`. The build process uses this placeholder.

4.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

5.  **Generate necessary files:**
    The project uses `injectable` for dependency injection and requires code generation.
    ```sh
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

6.  **Run the application:**
    ```sh
    flutter run
    ```

## 📂 Project Structure

The project follows a feature-first, clean architecture pattern.

```
lib/
├── core/                   # Core components: routing, themes, widgets, di
├── data/                   # Data layer: repositories, data sources, models (DTOs)
│   ├── data_sources/       # Remote (Firebase) and local data sources
│   ├── mappers/            # Converts DTOs to Entities and vice-versa
│   ├── model/              # Data Transfer Objects (DTOs) for Firebase
│   └── repo_impl/          # Implementation of domain repositories
├── domain/                 # Domain layer: business logic
│   ├── entities/           # Business objects
│   ├── repo/               # Abstract repository interfaces
│   └── usecases/           # Business logic for specific features
├── features/               # Presentation layer: UI and State Management
│   ├── auth/               # Authentication screens (Login, Signup)
│   ├── dashboard/          # Main dashboard with tabs (Home, Map, Fav, Profile)
│   ├── onboarding/         # Onboarding screens
│   └── my_app.dart         # Root widget of the application
└── main.dart               # Entry point of the application
