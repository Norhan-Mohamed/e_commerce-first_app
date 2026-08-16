# E-Commerce Flutter App

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

1. Get an API key from [RapidAPI – ASOS](https://rapidapi.com/apidojo/api/asos2).
2. Install dependencies:

```bash
flutter pub get
```

3. Run the app with your key (do not commit the key):

```bash
flutter run --dart-define=RAPIDAPI_KEY=your_key_here
```

## Notes

- Login/register only validate form fields and navigate; they do not authenticate against a server.
- Cart and favourites are stored on-device in `cart.db` and `fav.db`.
- If you previously ran an older build that used a shared `product.db`, that data is not migrated; new DBs are created automatically.
