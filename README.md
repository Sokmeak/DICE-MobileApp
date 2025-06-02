# Flutter Mobile Project

A Flutter-based frontend application with JavaScript tooling (via npm) for asset management and build processes.

## Prerequisites

Ensure the following are installed:

- **Flutter SDK** (≥ 3.0.0) – [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart** – Bundled with Flutter
- **Node.js** (≥ 14) with **npm** – [Install Node.js](https://nodejs.org/)
- **Git** – [Install Git](https://git-scm.com/)
- **IDE** – Recommended: VS Code or Android Studio (with Flutter plugin)
- **Device/Emulator** – For Android/iOS testing

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Sokmeak/DICE-MobileApp.git
cd DICE-MobileApp
```

### 2. Install Flutter Dependencies

```bash
flutter pub get
```

> If code generation is used:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Install npm Dependencies

```bash
npm install
npm run build   # Check package.json for available scripts
```

### 4. Run the App

```bash
flutter run
```

Ensure a device or emulator is connected (`flutter devices`).

## Running Tests

- **Unit Tests:**

  ```bash
  flutter test test/unit/
  ```

- **Widget Tests:**

  ```bash
  flutter test test/widget/
  ```

- **Integration Tests:** _(Requires connected device/emulator)_

  ```bash
  flutter test integration_test/
  ```

## Project Structure

```
your-repo/
├── frontend/
│   ├── lib/              # Flutter source code
│   ├── test/             # Unit & widget tests
│   ├── integration_test/ # Integration tests
│   ├── assets/           # Images, fonts, etc.
│   ├── pubspec.yaml      # Flutter dependencies
│   ├── package.json      # npm tooling scripts
└── README.md
```

## Troubleshooting

- Flutter issues:

  ```bash
  flutter clean && flutter pub get
  ```

- npm issues:
  Ensure Node.js is installed, then run `npm install`.

- Device issues:
  Use `flutter doctor` to diagnose setup problems.

## Contributing

1. Fork the repo
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes
4. Push to your branch
5. Open a Pull Request

All contributions are welcome!

## License

This project is licensed under the [MIT License](./LICENSE).
