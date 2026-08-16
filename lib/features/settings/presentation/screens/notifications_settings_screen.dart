import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_empty_state.dart';

class NotificationsSettingsScreen extends StatelessWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirimler'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: const AppEmptyState(
        title: 'Bildirim ayarları',
        message: 'Push tercihleri Phase 8–9’da eklenecek. Sahte switch yok.',
        icon: Icons.notifications_none_rounded,
      ),
    );
  }
}
