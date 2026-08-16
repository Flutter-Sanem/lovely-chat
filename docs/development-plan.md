# Autumn Chat — Development Plan

**Code name:** `autumn_chat`  
**Package name (Flutter):** `lovely_chat_app` (mevcut scaffold korunuyor; rename Phase 1 dışı)  
**Referans UI:** [chat-bloom-vibe.lovable.app](https://chat-bloom-vibe.lovable.app/) (Lovable “Pomelo” prototipi)  
**Stack:** Flutter · Material 3 · Riverpod · GoRouter · Firebase  
**Tarih:** 2026-08-15

---

## 1. Mevcut durum (Phase 0 analizi)

### Repository

| Alan | Durum |
|------|--------|
| Proje tipi | Varsayılan `flutter create` counter demo |
| `lib/` | Tek dosya: `main.dart` (MyApp + counter) |
| Feature / clean architecture | Yok |
| State management | Yok (yalnızca `setState`) |
| Routing | Yok (`MaterialApp` + `home`) |
| Theme / design system | Yok (deepPurple seed) |
| Firebase | Yok (config, options, plugins yok) |
| Emulator / env ayrımı | Yok |
| Testler | Counter smoke test |
| Docs | Yok (bu dosya ile başlıyor) |
| Platform | Android + iOS scaffold mevcut |
| Application ID | `com.example.lovely_chat_app` |

### Lovable referansı (IA & his)

Prototip adı **Pomelo**; hedef ürün kimliği **Autumn Chat**. Birebir HTML çevirisi yapılmayacak; information architecture ve sıcaklık hissi alınacak.

| Ekran | Gözlem |
|-------|--------|
| Chats (`/`) | Selamlama + marka + arama + conversation list + bottom nav |
| Chat detail | Kullanıcı bazlı route (`/chat/:slug`) — bizde `conversationId` |
| Profile | Avatar, display name, username, bio, stats, durum, edit, logout |
| Settings | Bildirimler, görünüm, gizlilik section’ları |
| Nav | Sohbetler · Profil · Ayarlar |

**Tasarım sapması (bilinçli):** Pomelo turuncu-pembe / şeftali → Autumn burnt orange / dusty rose / warm cream. Stats (sohbet/medya/favori) gerçek data yoksa MVP’de hardcode edilmeyecek.

### Firebase durumu

- Proje bağlı: **autumn-chat-app-89fdf** (Autumn Chat App)
- Android / iOS app kayıtlı; `firebase_options.dart` + platform config dosyaları mevcut
- Google Services Gradle plugin uygulandı; iOS `GoogleService-Info.plist` Xcode resources’ta
- Emulator hedefi: Phase 2+ development’ta Auth + Firestore

### Eksik paketler (planlanan)

| Paket | Neden | Phase |
|-------|-------|-------|
| `flutter_riverpod` | State management | 1 |
| `go_router` | Declarative routing + auth redirect | 1 |
| `firebase_core` | Firebase bootstrap | 1 |
| `google_fonts` | Merkezi tipografi (Plus Jakarta Sans) | 1 |
| `firebase_auth` | Email/password | 2 |
| `cloud_firestore` | Users, chats, messages | 2+ |
| `firebase_storage` | Avatar upload | 7 |
| `firebase_messaging` | Push | 9 |
| `shared_preferences` | ThemeMode local persist | 1 (hafif) / 8 |
| `intl` | Tarih formatları (Bugün/Dün) | 5–6 |
| `cached_network_image` | Avatar performansı | 5–7 (gerekirse) |
| `flutter_local_notifications` | Foreground FCM UX | 9 (gerekirse) |
| `uuid` / `collection` | Yalnızca ihtiyaç çıkarsa | — |

**Kural:** SDK veya mevcut bağımlılık yeterse yeni paket eklenmez. Freezed/json_serializable başlangıçta yok.

---

## 2. Önerilen mimari

Hafif **feature-first + clean architecture**:

```text
lib/
├── app/           # App widget, router, theme
├── core/          # constants, errors, services, utils, shared widgets
├── features/      # auth, chats, messages, users, profile, settings, notifications
├── firebase_options.dart
└── main.dart
```

Her feature: `data/` · `domain/` · `presentation/` — yalnızca gerektiğinde.

### Katman kuralları

- UI → Riverpod providers → repository/service → Firebase
- Widget içinde doğrudan Firestore/Auth sorgusu yok
- Typed modeller; mümkün olduğunda `withConverter`
- Aşırı abstract class / enterprise boilerplate yok

### State & routing

- `ProviderScope` root
- `GoRouter` + auth-aware `redirect` (Phase 2’de gerçek auth stream)
- Phase 1: placeholder shell route’lar; redirect stub’ı hazır

---

## 3. Design system

`app/theme/`:

| Dosya | İçerik |
|-------|--------|
| `app_colors.dart` | Autumn token’lar |
| `app_typography.dart` | TextTheme + Google Fonts |
| `app_spacing.dart` | 4/8/12/16/24/32… |
| `app_radius.dart` | 8 / 12 / 18 / 24 (+ chat bubble) |
| `app_shadows.dart` | Soft, düşük opacity |
| `app_theme.dart` | Light/Dark `ThemeData`, `useMaterial3: true` |

**Başlangıç token’ları:** Primary `#D97745`, Secondary `#C97878`, Tertiary `#D6A34A`, BG `#FFF8F1`, Surface `#FFFDF9`, Dark BG `#1E1916`, Dark Surface `#29221E`, Text `#392E29`, Muted `#85736B`.

Font: **Plus Jakarta Sans** (sıcak, modern sans).

---

## 4. Firebase veri modeli (özet)

Detay: `docs/firestore-schema.md` (Phase 1’de iskelet; Phase 2–5’te netleşir).

```text
users/{userId}                          # public profil
user_private/{userId}                   # email, sensitive prefs (opsiyonel ayrım)
usernames/{username}                    # reservation (transaction)
conversations/{conversationId}
conversations/{conversationId}/messages/{messageId}
users/{userId}/blockedUsers/{blockedUserId}
users/{userId}/devices/{deviceId}
```

**Username:** lowercase, URL-safe, unique; `usernames/{username}` + transaction.

**Conversation (MVP):** `type: direct`, `participantIds`, last message alanları.

**Message (MVP):** `type: text` zorunlu; `image` / `system` modelde hazır, implement opsiyonel.

---

## 5. Ekranlar & navigation graph

```text
/                         → redirect → /chats | /login
/login
/register
/chats                    ← shell (NavigationBar)
/chat/:conversationId
/profile                  ← shell
/profile/edit
/user/:username
/settings                 ← shell
/settings/privacy
/settings/notifications
/settings/appearance
/blocked-users
```

**Bottom nav:** Chats · Profile · Settings (`NavigationBar`).

**Auth guard (Phase 2):**

- Anon → authenticated route → `/login`
- Auth → `/login` | `/register` → `/chats`

---

## 6. Phase planı

| Phase | Kapsam | Exit criteria |
|-------|--------|-----------------|
| **0 Analysis** | Repo + Lovable + Firebase + plan | Bu doküman |
| **1 Foundation** | Deps, klasörler, theme, router, Riverpod, Firebase init, primitives | App açılır, analyze clean |
| **2 Auth** | Register/login/logout, username reservation, user docs, guards | İki hesap açılabilir |
| **3 Main nav** | Chats / Profile / Settings shell | NavigationBar çalışır |
| **4 Users & search** | User repo, prefix search, debounce, DM create | Arama → chat |
| **5 Messaging** | Models, repos, chat screen, send, realtime, pagination | Text DM çalışır |
| **6 Chat list** | Stream, last message, unread, empty states | Liste canlı |
| **7 Profile** | View/edit, avatar Storage | Profil güncellenir |
| **8 Settings** | Theme, notif prefs, privacy basics, block list | Gerçek setting’ler only |
| **9 Notifications** | FCM, devices, Functions, deep link | Push → chat |
| **10 Security** | Firestore/Storage rules, indexes | Unauthorized blok |
| **11 Polish** | Loading/error/empty, anim, a11y, keyboard | MVP polish |

**Şimdi:** Phase 0 ✅ → Phase 1 uygulanır. Sonraki phase’lere otomatik geçilmez.

---

## 7. Teknik riskler

| Risk | Etki | Mitigasyon |
|------|------|------------|
| Username race | Duplicate username | Transaction + `usernames` collection |
| Firestore presence | Online/offline gecikmeli/maliyetli | MVP: `isOnline` + `lastSeenAt`; RTDB değerlendir |
| Message pagination | Yanlış cursor = duplicate/gap | Baştan page size + startAfter |
| Unread counts | Client-only fragile | Participant-scoped unread veya Cloud Function |
| FCM + sensitive preview | Privacy leak | Pref kapalıysa body gizle |
| Security rules geç | Data leak | Schema ile birlikte rules taslağı |
| Emulator vs prod | Kirli data / spam notif | Dev’de emulator; env ayrımı |
| Lovable stats hardcode | Yanıltıcı UI | Gerçek data yoksa gösterme |
| Package rename | Break import path | Şimdilik `lovely_chat_app` kalsın |

---

## 8. Yapılacak işler (yakın vadeli)

### Phase 1 (bu sprint)

- [x] Analiz + `docs/development-plan.md`
- [x] `pubspec` bağımlılıkları
- [x] Feature-first klasör iskeleti
- [x] Autumn Material 3 theme
- [x] GoRouter + placeholder ekranlar
- [x] Riverpod root
- [x] Firebase bootstrap (+ options placeholder)
- [x] Reusable UI primitives (AppEmptyState, AppLoadingView, AppErrorView)
- [x] `flutter analyze` + test güncellemesi
- [x] README + `docs/architecture.md` + `docs/firestore-schema.md` iskeleti

### Phase 2+

Auth → nav → search → messaging → list → profile → settings → FCM → rules → polish.

---

## 9. MVP sınırı

**İçinde:** register/login, username search, direct chat, realtime text, conversation list, profile, theme/settings, push.

**Dışında (şimdilik):** stories, calls, complex groups, feed, E2EE, disappearing messages, media editor.

---

## 10. Kalite kapıları (her phase sonu)

```bash
flutter analyze
flutter test
```

Analyzer error ile sonraki phase’e geçilmez.
