import 'package:flutter/material.dart';

import '../../state/app_controller.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_drawer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.controller,
    required this.currentIndex,
    required this.onSelectTab,
  });

  final AppController controller;
  final int currentIndex;
  final ValueChanged<int> onSelectTab;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          drawer: AppDrawer(
            controller: controller,
            currentIndex: currentIndex,
            onSelectTab: onSelectTab,
          ),
          appBar: AppBar(
            title: const Text('Settings'),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: AppTheme.darkTextColor,
            elevation: 0,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
              },
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Hero(
                            tag: 'profileAvatar',
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.person,
                                color: theme.colorScheme.primary,
                                size: 60,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            controller.userName,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.darkTextColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.email,
                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => _showEditProfileDialog(context),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              minimumSize: const Size(150, 0),
                            ),
                            child: const Text('Edit Profile'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Account Settings',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SettingsTile(
                      title: 'Security',
                      subtitle: 'Password, PIN, biometric authentication',
                      icon: Icons.security,
                      iconColor: AppTheme.primaryColor,
                      onTap: () => _showInfo(context, 'Security', 'Biometric login is ${controller.biometricLogin ? 'enabled' : 'disabled'} in this demo.'),
                    ),
                    _SettingsTile(
                      title: 'Notifications',
                      subtitle: 'Customize your notification preferences',
                      icon: Icons.notifications_none,
                      iconColor: AppTheme.redColor,
                      onTap: () => _showInfo(context, 'Notifications', 'Transaction alerts are ${controller.transactionAlerts ? 'enabled' : 'disabled'}.'),
                    ),
                    _SettingsTile(
                      title: 'Payment Methods',
                      subtitle: 'Add or remove payment methods',
                      icon: Icons.credit_card,
                      iconColor: AppTheme.secondaryColor,
                      onTap: () => onSelectTab(1),
                    ),
                    _SettingsTile(
                      title: 'Connected Accounts',
                      subtitle: 'Manage linked accounts and services',
                      icon: Icons.link,
                      iconColor: AppTheme.orangeColor,
                      onTap: () => onSelectTab(1),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'App Settings',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ToggleTile(
                      title: 'Dark Mode',
                      subtitle: 'Switch between light and dark themes',
                      icon: Icons.dark_mode,
                      iconColor: AppTheme.primaryColor,
                      value: controller.darkMode,
                      onChanged: controller.toggleDarkMode,
                    ),
                    _ToggleTile(
                      title: 'Biometric Login',
                      subtitle: 'Use fingerprint or face recognition',
                      icon: Icons.fingerprint,
                      iconColor: AppTheme.secondaryColor,
                      value: controller.biometricLogin,
                      onChanged: controller.toggleBiometricLogin,
                    ),
                    _ToggleTile(
                      title: 'Transaction Alerts',
                      subtitle: 'Get notified for all transactions',
                      icon: Icons.notifications_active,
                      iconColor: AppTheme.redColor,
                      value: controller.transactionAlerts,
                      onChanged: controller.toggleTransactionAlerts,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Support',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SettingsTile(
                      title: 'Help Center',
                      subtitle: 'FAQs and support documentation',
                      icon: Icons.help_outline,
                      iconColor: AppTheme.primaryColor,
                      onTap: () => _showInfo(context, 'Help Center', 'This app now has a working dummy flow across every visible section.'),
                    ),
                    _SettingsTile(
                      title: 'Contact Support',
                      subtitle: 'Get in touch with our support team',
                      icon: Icons.support_agent,
                      iconColor: AppTheme.secondaryColor,
                      onTap: () => _showInfo(context, 'Contact Support', 'Wire this action to chat, email, or a ticketing backend later.'),
                    ),
                    _SettingsTile(
                      title: 'About App',
                      subtitle: 'Version info and legal documents',
                      icon: Icons.info_outline,
                      iconColor: AppTheme.orangeColor,
                      onTap: () => _showInfo(context, 'About App', 'User Balance App demo build with shared state-driven flows.'),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _showInfo(context, 'Logout', 'Logout remains a placeholder because no auth backend is connected yet.'),
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade50,
                          foregroundColor: Colors.red,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showEditProfileDialog(BuildContext context) async {
    final nameController = TextEditingController(text: controller.userName);
    final emailController = TextEditingController(text: controller.email);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.updateProfile(
                  nextName: nameController.text.trim().isEmpty ? controller.userName : nameController.text.trim(),
                  nextEmail: emailController.text.trim().isEmpty ? controller.email : emailController.text.trim(),
                );
                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showInfo(BuildContext context, String title, String message) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkTextColor,
                ),
          ),
          subtitle: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: SwitchListTile(
          contentPadding: const EdgeInsets.all(16),
          secondary: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkTextColor,
                ),
          ),
          subtitle: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          value: value,
          activeThumbColor: AppTheme.primaryColor,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
