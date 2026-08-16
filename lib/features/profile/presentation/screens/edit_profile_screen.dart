import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacing.dart';

/// Edit profile stub — Storage avatar upload in Phase 7.
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profili düzenle'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Text(
            'Avatar, display name, bio ve status alanları Phase 7’de eklenecek.',
          ),
        ),
      ),
    );
  }
}
