import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final language = ref.watch(languageProvider);
    final notifications = ref.watch(notificationProvider);
    final biometric = ref.watch(biometricProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Theme Section
          _buildSectionHeader(context, 'Appearance'),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Theme'),
            subtitle: Text(_getThemeModeName(themeMode)),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              underline: const SizedBox(),
              items: ThemeMode.values.map((mode) {
                return DropdownMenuItem(
                  value: mode,
                  child: Text(_getThemeModeName(mode)),
                );
              }).toList(),
              onChanged: (mode) {
                if (mode != null) ref.read(themeModeProvider.notifier).setTheme(mode);
              },
            ),
          ),

          // Language Section
          _buildSectionHeader(context, 'Language'),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: Text(language.languageCode == 'ar' ? 'العربية' : 'English'),
            trailing: Switch(
              value: language.languageCode == 'ar',
              onChanged: (isArabic) {
                ref.read(languageProvider.notifier).setLanguage(isArabic ? 'ar' : 'en');
              },
            ),
          ),

          // Notifications Section
          _buildSectionHeader(context, 'Notifications'),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Enable Notifications'),
            subtitle: const Text('Receive tool completion alerts'),
            value: notifications,
            onChanged: (value) => ref.read(notificationProvider.notifier).setNotifications(value),
          ),

          // Security Section
          _buildSectionHeader(context, 'Security'),
          SwitchListTile(
            secondary: const Icon(Icons.fingerprint),
            title: const Text('Biometric Lock'),
            subtitle: const Text('Require fingerprint to open app'),
            value: biometric,
            onChanged: (value) => ref.read(biometricProvider.notifier).setBiometric(value),
          ),

          // About Section
          _buildSectionHeader(context, 'About'),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About OmniTools AI'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () => _showAboutDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Rate App'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share App'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('Backup Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Restore Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: AppColors.primaryLight,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getThemeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system: return 'System Default';
      case ThemeMode.light: return 'Light';
      case ThemeMode.dark: return 'Dark';
    }
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'OmniTools AI',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.build, color: Colors.white, size: 32),
      ),
      children: [
        const Text('The ultimate All-in-One Utilities application with 100+ tools.'),
      ],
    );
  }
}
