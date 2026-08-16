# E-Commerce Flutter App

**Created at:** January 2023

A Flutter fashion shopping demo that browses ASOS product categories via RapidAPI, shows product details, and stores cart and favourites locally with SQLite.

## Features

- Splash, login, and register screens (UI demo — no backend authentication)
- Home product grid with category filters
- Product details from the ASOS detail API
- Local cart and favourites (separate SQLite databases)
- Bottom navigation: Home / Cart / Favourites

## Tech stack

- Flutter / Dart
- `http` for REST API calls (ASOS RapidAPI)
- `sqflite` for local cart and favourites storage
- StatefulWidget + FutureBuilder for UI state

## Setup

```bash
flutter pub get
flutter run
```

The app uses the public ASOS RapidAPI demo key in `lib/api/apiRequest.dart`.

## Notes

- Login/register only validate form fields and navigate; they do not authenticate against a server.
- Cart and favourites are stored on-device in `cart.db` and `fav.db`.
- If you previously ran an older build that used a shared `product.db`, that data is not migrated; new DBs are created automatically.
