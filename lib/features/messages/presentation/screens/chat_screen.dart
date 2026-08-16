import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/app_empty_state.dart';

/// Direct chat shell — messaging + pagination in Phase 5.
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/chats'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sohbet', style: Theme.of(context).textTheme.titleMedium),
            Text(
              conversationId,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
      body: const AppEmptyState(
        title: 'Mesajlaşma yakında',
        message: 'Realtime text messaging Phase 5’te gelecek.',
        icon: Icons.chat_outlined,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.xs,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'Mesaj yaz…',
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              IconButton.filled(
                onPressed: null,
                icon: const Icon(Icons.send_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
