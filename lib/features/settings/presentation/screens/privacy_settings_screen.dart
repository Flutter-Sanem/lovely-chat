import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_empty_state.dart';

class PrivacySettingsScreen extends StatelessWidget {
  const PrivacySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gizlilik'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: const AppEmptyState(
        title: 'Gizlilik',
        message: 'Son görülme ve engelleme kuralları Phase 8’de gelecek.',
        icon: Icons.privacy_tip_outlined,
      ),
    );
  }
}
