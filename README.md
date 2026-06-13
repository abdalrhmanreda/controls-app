# Control App 📱🔒

A premium, modern Flutter application built for smart home control, device management, and secure authentication. The app is crafted using clean architecture principles, featuring responsive design, localization, and robust state management.

---

## 🚀 Key Features

- 👤 **Secure Authentication Flow**: Integrated login, session validation, and secure credential storage.
- 📺 **Smart TV Dashboard**: A interactive virtual remote control with Room Selection, Channel D-pad, Volume Sliders, and Toggle Switch widgets.
- 📹 **Entrance Camera Integration**: Live camera feeds and entry logs.
- 🌓 **Dynamic Theme System**: Sleek light/dark mode configuration powered by a state-managed `ThemeCubit`.
- 🌐 **Multi-language Support**: Fully localized in English (`en`) and Arabic (`ar`) using `easy_localization`.
- 📱 **Responsive Layouts**: Designed around a 375x812 design viewport using `flutter_screenutil` to maintain visual consistency across all screen sizes.

---

## 🛠️ Technology Stack

| Library | Purpose |
| :--- | :--- |
| **`flutter_bloc`** | State Management (BLoC / Cubit pattern) |
| **`get_it`** | Dependency Injection & Service Locator |
| **`dio` & `retrofit`** | Networking Client & Type-safe HTTP Client Generation |
| **`sqflite`** | Local relational SQL Database |
| **`flutter_secure_storage`** | Encrypted key-value caching (e.g., token management) |
| **`easy_localization`** | Multi-locale translation framework |
| **`flutter_screenutil`** | Pixel-perfect responsive screen adaptation |

---

## 📂 Project Structure

The project follows a **Feature-first / Clean Architecture** directory structure:

```
lib/
├── config/                 # App configurations
│   ├── colors/            # Curated harmonious color palettes
│   ├── routes/            # Route configurations & names (AppRouter)
│   └── themes/            # Dark and light material design systems
├── core/                   # Core shared utilities, services, and widgets
│   ├── animation/         # Custom UI transition & transaction animations
│   ├── api/               # API clients, network requests (Dio & Retrofit)
│   ├── cache/             # Storage caching (SQLite, Secure Storage, SharedPreferences)
│   ├── constants/         # Dimensions, Durations, Asset Paths, and String keys
│   ├── di/                # Dependency Injection register setup (GetIt)
│   ├── extensions/        # Context, Nav, String, Locale, and Date extensions
│   ├── helpers/           # Cubit states, validators, observers, and helpers
│   ├── translations/      # Generated translation keys
│   ├── utils/             # Modular UI elements (buttons, bottom sheets, snackbars)
│   └── widgets/           # Global re-usable widgets (skeletons, refresh loaders)
├── features/               # Independent feature layers
│   ├── auth/              # Login pages, user models, repositories, and state logic
│   ├── camera/            # Entrance monitoring UI pages
│   └── dashboard/         # Smart TV controls, room selectors, remote D-pads
├── main.dart               # App entry point (initializes services & localization)
├── services.dart           # Bootstrap initialization routine for DI & local databases
└── control_app.dart        # MaterialApp setup (Theme configuration, routes integration)
```

---

## 🛠️ Getting Started

### Prerequisites

Ensure you have the following installed on your machine:
- **Flutter SDK** (Recommended `3.19.x` or newer)
- **Dart SDK**
- IDE (VS Code or Android Studio) with Flutter & Dart extensions

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/abdalrhmanreda/controls-app.git
   cd controls-app
   ```

2. **Retrieve Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run Code Generation:**
   The project uses build generation for network layers (Retrofit) and icons/assets. Run the following command to generate the necessary boilerplate files:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Launch the Application:**
   To run the app in debug mode on your connected emulator or device:
   ```bash
   flutter run
   ```

---

## 🧪 Verification & Testing

Verify that widget behaviors and features build cleanly by running:
```bash
flutter test
```
