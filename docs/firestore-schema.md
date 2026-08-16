# Firestore Schema — Autumn Chat

Draft schema. Evolve with security rules (Phase 10). Do not treat as frozen.

## Collections

### `users/{userId}`

Public profile (readable by authenticated users; write own doc only).

| Field | Type | Notes |
|-------|------|-------|
| `id` | string | Same as doc id |
| `username` | string | Normalized lowercase |
| `displayName` | string | |
| `avatarUrl` | string? | Storage URL |
| `bio` | string? | |
| `status` | string? | Presence message |
| `createdAt` | timestamp | |
| `lastSeenAt` | timestamp? | |
| `isOnline` | bool | MVP presence |
| `themePreference` | string? | system/light/dark |
| `notificationSettings` | map? | Or move to private |
| `privacySettings` | map? | Or move to private |

### `user_private/{userId}` (optional split)

| Field | Type | Notes |
|-------|------|-------|
| `email` | string | Not public |
| `notificationSettings` | map | |
| `privacySettings` | map | |

### `usernames/{username}`

Reservation document. Doc id = normalized username.

| Field | Type | Notes |
|-------|------|-------|
| `userId` | string | Owner |
| `createdAt` | timestamp | |

**Create via transaction** with user doc to prevent races.

### `conversations/{conversationId}`

| Field | Type | Notes |
|-------|------|-------|
| `id` | string | |
| `type` | string | MVP: `direct` |
| `participantIds` | string[] | Sorted for deterministic direct id optional |
| `createdAt` | timestamp | |
| `updatedAt` | timestamp | |
| `lastMessage` | string? | Preview text |
| `lastMessageAt` | timestamp? | |
| `lastMessageSenderId` | string? | |

### `conversations/{conversationId}/messages/{messageId}`

| Field | Type | Notes |
|-------|------|-------|
| `id` | string | |
| `conversationId` | string | |
| `senderId` | string | Must match auth uid |
| `type` | string | `text` \| `image` \| `system` |
| `text` | string? | |
| `mediaUrl` | string? | |
| `createdAt` | timestamp | |
| `editedAt` | timestamp? | |
| `deletedAt` | timestamp? | Soft delete |
| `status` | string? | sent/delivered/read (MVP optional) |

### `users/{userId}/blockedUsers/{blockedUserId}`

| Field | Type | Notes |
|-------|------|-------|
| `blockedAt` | timestamp | |
| `blockedUserId` | string | |

### `users/{userId}/devices/{deviceId}`

| Field | Type | Notes |
|-------|------|-------|
| `fcmToken` | string | |
| `platform` | string | ios/android |
| `updatedAt` | timestamp | |

## Indexes (expected)

- Messages: `createdAt` desc (per conversation subcollection often automatic)
- Users search: `username` prefix — consider username collection or `username` Ascending
- Conversations: `participantIds` array-contains + `lastMessageAt` desc

## Security (intent)

- Own private data only writable by owner
- Conversation/messages only if `request.auth.uid in participantIds`
- Cannot send message as another user
- Username docs: create only if unused; bind to caller uid

Rules authored in Phase 10 alongside query validation.
