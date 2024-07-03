<p align="center">
  <img style="border-radius: 20%; width: 240px;" src="assets/images/icon/ic_recovie.png">
</p>

# Recovie App

Recovie adalah aplikasi yang diperuntukan bagi anak muda yang ingin melihat rekomendasi film manca negara atau yang berada dalam negara.

## Documentation

**Document :**

For [Documentation API](https://developer.themoviedb.org/reference/account-details)

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

- Flutter version : `3.19.4`
- Dart version : `3.3.2`
- You can read Dependency Version on `pubspec.lock`

## Run this Project

- If you useing IDE Visual Studio Code please open menu `Run and Debug` and select environment then click icon RUN.

**For Install or get packages :**

```BASH
flutter pub get
```

**For Run useing command line plese run this :**

```BASH
flutter run
```

## Build APK and Upload to Store

**Step 1:**

Create file `.env` in project root directory.

```BASH
API_KEY_AUTH=[API_KEY_AUTH]
ACCESS_TOKEN_AUTH=[ACCESS_TOKEN_AUTH]
```

:warning: Please replace value inside [ ] with real keys.

Then, run this command to run the generator.

```BASH
dart run build_runner build
```

:warning: Ensure that the `env.g.dart` file and generated file are added to the ignore list.

**Step 3:**

For build APK and share to testing team please run this command.

```BASH
flutter build apk --split-per-abi
```
