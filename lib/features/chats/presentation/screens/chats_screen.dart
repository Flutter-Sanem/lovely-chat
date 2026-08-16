import 'package:flutter/material.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/app_empty_state.dart';

/// Conversation list shell — realtime list in Phase 6.
class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Merhaba',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    AppConstants.appName,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SearchBar(
                    hintText: 'Kullanıcı adı ara…',
                    leading: const Icon(Icons.search_rounded),
                    onTap: () {
                      // Phase 4: user search
                    },
                  ),
                ],
              ),
            ),
            const Expanded(
              child: AppEmptyState(
                title: 'Henüz sohbet yok',
                message:
                    'Birini arayıp ilk mesajını gönderdiğinde burada görünecek.',
                icon: Icons.forum_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
