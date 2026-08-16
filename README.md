# Autumn Chat

Code name: **autumn_chat** · Flutter package: `lovely_chat_app`

Warm, modern messaging app inspired by the [Pomelo Lovable prototype](https://chat-bloom-vibe.lovable.app/), rebuilt for production with Flutter, Material 3, Riverpod, GoRouter, and Firebase.

## Overview

- Email/password auth, unique usernames, direct chats, realtime text messaging
- Autumn design system (burnt orange / dusty rose / warm cream)
- Feature-first architecture — see `docs/`

## Architecture

Lightweight feature-first + clean architecture:

```text
lib/
├── app/          # App root, GoRouter, theme
├── core/         # Shared constants, errors, services, widgets
├── features/     # auth, chats, messages, users, profile, settings…
├── firebase_options.dart
└── main.dart
```

Details: [`docs/architecture.md`](docs/architecture.md) · Plan: [`docs/development-plan.md`](docs/development-plan.md) · Schema: [`docs/firestore-schema.md`](docs/firestore-schema.md)

## Requirements

- Flutter 3.44+ / Dart 3.12+
- Xcode / Android Studio as needed
- Firebase project (for Phase 2+)

## Setup

```bash
cd flutter/lovely_chat_app
flutter pub get
```

### Firebase

Connected project: **autumn-chat-app-89fdf** (Autumn Chat App).

| Platform | Package / Bundle ID |
|----------|---------------------|
| Android | `com.example.lovely_chat_app` |
| iOS | `com.example.lovelyChatApp` |

Config files:

- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `firebase.json`

Re-run if apps change:

```bash
# Needs Ruby gem: gem install CFPropertyList -v 3.0.9 xcodeproj --user-install
export GEM_HOME="$HOME/.gem/ruby/2.6.0" GEM_PATH="$GEM_HOME" PATH="$GEM_HOME/bin:$PATH"
flutterfire configure --project=autumn-chat-app-89fdf --platforms=android,ios --yes
```

### Run

```bash
flutter run
```

Theme: **Ayarlar → Görünüm** (System / Light / Dark). Persisted via `shared_preferences`.

## Emulator setup (Phase 2+)

```bash
firebase emulators:start --only auth,firestore,storage
```

Point the app at emulators in a future `FirebaseBootstrap` / env flag — not wired in Phase 1.

## Environments

| Env | Purpose |
|-----|---------|
| development | Emulators / dev Firebase project |
| production | Live Firebase |

Do not hardcode secrets in Dart sources. Prefer FlutterFire + ignore platform secret files in git when appropriate.

## Testing

```bash
flutter analyze
flutter test
```

## Current phase

**Phase 1 — Foundation** complete when:

- App compiles and launches
- Material 3 Autumn theme works (light/dark/system)
- GoRouter + shell NavigationBar ready
- Riverpod root + theme persistence
- Firebase bootstrap path in place (skips until configured)

Auth, messaging, and Firestore arrive in later phases — see development plan.
