import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/theme_mode_controller.dart';

/// Settings hub — only real controls for now (theme). Fake toggles omitted.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ayarlar')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        children: [
          const _SectionHeader('Görünüm'),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Tema'),
            subtitle: Text(_themeLabel(themeMode)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/appearance'),
          ),
          const Divider(height: AppSpacing.lg),
          const _SectionHeader('Bildirimler'),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Bildirim tercihleri'),
            subtitle: const Text('Phase 8–9'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/notifications'),
          ),
          const Divider(height: AppSpacing.lg),
          const _SectionHeader('Gizlilik'),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Gizlilik'),
            subtitle: const Text('Phase 8'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/privacy'),
          ),
          ListTile(
            leading: const Icon(Icons.block_outlined),
            title: const Text('Engellenenler'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/blocked-users'),
          ),
          const SizedBox(height: AppSpacing.xl),
          Center(
            child: Text(
              '${AppConstants.appName} · Foundation',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }

  static String _themeLabel(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => 'Sistem',
      ThemeMode.light => 'Açık',
      ThemeMode.dark => 'Koyu',
    };
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.xs,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
