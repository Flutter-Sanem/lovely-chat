import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/chats/presentation/screens/chats_screen.dart';
import '../../features/messages/presentation/screens/chat_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/appearance_settings_screen.dart';
import '../../features/settings/presentation/screens/blocked_users_screen.dart';
import '../../features/settings/presentation/screens/notifications_settings_screen.dart';
import '../../features/settings/presentation/screens/privacy_settings_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/users/presentation/screens/user_profile_screen.dart';
import 'main_shell_screen.dart';

/// Auth session stub — replaced by Firebase Auth stream in Phase 2.
final authSessionProvider = Provider<bool>((ref) {
  // Foundation: treat app as signed-out by default for redirect demos.
  // Shell routes remain reachable during Phase 1 for theme/nav work.
  return true;
});

final goRouterProvider = Provider<GoRouter>((ref) {
  final bool isAuthenticated = ref.watch(authSessionProvider);

  return GoRouter(
    initialLocation: '/chats',
    debugLogDiagnostics: false,
    redirect: (BuildContext context, GoRouterState state) {
      final String location = state.matchedLocation;
      final bool onAuthRoute =
          location == '/login' || location == '/register';

      // Phase 1: allow shell browsing without hard lock.
      // Phase 2 will enforce: anon → /login, auth → leave auth routes.
      if (!isAuthenticated && !onAuthRoute && _requiresAuth(location)) {
        // Keep foundation usable: do not force login yet.
        return null;
      }
      if (isAuthenticated && onAuthRoute) {
        return '/chats';
      }
      if (location == '/') {
        return isAuthenticated ? '/chats' : '/login';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/chats',
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chats',
                name: 'chats',
                builder: (context, state) => const ChatsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    name: 'profile-edit',
                    builder: (context, state) => const EditProfileScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
                routes: [
                  GoRoute(
                    path: 'appearance',
                    name: 'settings-appearance',
                    builder: (context, state) =>
                        const AppearanceSettingsScreen(),
                  ),
                  GoRoute(
                    path: 'notifications',
                    name: 'settings-notifications',
                    builder: (context, state) =>
                        const NotificationsSettingsScreen(),
                  ),
                  GoRoute(
                    path: 'privacy',
                    name: 'settings-privacy',
                    builder: (context, state) => const PrivacySettingsScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/chat/:conversationId',
        name: 'chat',
        builder: (context, state) {
          final String conversationId =
              state.pathParameters['conversationId'] ?? '';
          return ChatScreen(conversationId: conversationId);
        },
      ),
      GoRoute(
        path: '/user/:username',
        name: 'user',
        builder: (context, state) {
          final String username = state.pathParameters['username'] ?? '';
          return UserProfileScreen(username: username);
        },
      ),
      GoRoute(
        path: '/blocked-users',
        name: 'blocked-users',
        builder: (context, state) => const BlockedUsersScreen(),
      ),
    ],
  );
});

bool _requiresAuth(String location) {
  if (location == '/login' || location == '/register') {
    return false;
  }
  return true;
}
