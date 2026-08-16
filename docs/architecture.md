# Architecture — Autumn Chat

Lightweight **feature-first + clean architecture**. Avoid enterprise boilerplate.

## Layers

```text
Presentation (widgets, screens, Riverpod UI providers)
        ↓
Domain (models, validators, pure logic) — only when needed
        ↓
Data (repositories, Firebase datasources)
```

## Rules

1. No Firebase queries inside widgets.
2. Prefer typed models over raw `Map<String, dynamic>` in UI.
3. Scope Riverpod providers to avoid unnecessary rebuilds.
4. Create `data/` / `domain/` / `presentation/` only when a feature needs them.
5. Shared UI lives in `core/widgets/`; design tokens in `app/theme/`.

## App entry

- `main.dart` — binding, Firebase bootstrap, `ProviderScope`, `AutumnChatApp`
- `app/app.dart` — `MaterialApp.router` + theme mode
- `app/router/` — GoRouter
- `app/theme/` — Material 3 Autumn design system

## Features (planned)

| Feature | Responsibility |
|---------|----------------|
| `auth` | Login, register, session |
| `chats` | Conversation list, shell |
| `messages` | Chat thread, send, pagination |
| `users` | Profiles, username search |
| `profile` | Current user profile / edit |
| `settings` | Theme, privacy, notifications prefs |
| `notifications` | FCM token + handling |

See `development-plan.md` for phase order.
