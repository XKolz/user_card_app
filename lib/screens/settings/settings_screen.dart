import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.darkTextColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Profile Section
                Center(
                  child: Column(
                    children: [
                      Hero(
                        tag: 'profileAvatar',
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
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
                        'John Doe',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkTextColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'john.doe@example.com',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          print('Edit profile clicked');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          minimumSize: const Size(150, 0),
                        ),
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32.0),
                
                // Account Settings Section
                Text(
                  'Account Settings',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                const SizedBox(height: 16.0),
                
                _buildSettingsItem(
                  context,
                  'Security',
                  'Password, PIN, biometric authentication',
                  Icons.security,
                  AppTheme.primaryColor,
                ),
                
                _buildSettingsItem(
                  context,
                  'Notifications',
                  'Customize your notification preferences',
                  Icons.notifications_none,
                  AppTheme.redColor,
                ),
                
                _buildSettingsItem(
                  context,
                  'Payment Methods',
                  'Add or remove payment methods',
                  Icons.credit_card,
                  AppTheme.secondaryColor,
                ),
                
                _buildSettingsItem(
                  context,
                  'Connected Accounts',
                  'Manage linked accounts and services',
                  Icons.link,
                  AppTheme.orangeColor,
                ),
                
                const SizedBox(height: 32.0),
                
                // App Settings Section
                Text(
                  'App Settings',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                const SizedBox(height: 16.0),
                
                _buildToggleSetting(
                  context,
                  'Dark Mode',
                  'Switch between light and dark themes',
                  Icons.dark_mode,
                  AppTheme.primaryColor,
                  false,
                ),
                
                _buildToggleSetting(
                  context,
                  'Biometric Login',
                  'Use fingerprint or face recognition',
                  Icons.fingerprint,
                  AppTheme.secondaryColor,
                  true,
                ),
                
                _buildToggleSetting(
                  context,
                  'Transaction Alerts',
                  'Get notified for all transactions',
                  Icons.notifications_active,
                  AppTheme.redColor,
                  true,
                ),
                
                const SizedBox(height: 32.0),
                
                // Support Section
                Text(
                  'Support',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                const SizedBox(height: 16.0),
                
                _buildSettingsItem(
                  context,
                  'Help Center',
                  'FAQs and support documentation',
                  Icons.help_outline,
                  AppTheme.primaryColor,
                ),
                
                _buildSettingsItem(
                  context,
                  'Contact Support',
                  'Get in touch with our support team',
                  Icons.support_agent,
                  AppTheme.secondaryColor,
                ),
                
                _buildSettingsItem(
                  context,
                  'About App',
                  'Version info and legal documents',
                  Icons.info_outline,
                  AppTheme.orangeColor,
                ),
                
                const SizedBox(height: 32.0),
                
                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print('Logout clicked');
                    },
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
  }
  
  Widget _buildSettingsItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
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
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
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
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
          onTap: () {
            print('$title settings clicked');
          },
        ),
      ),
    );
  }
  
  Widget _buildToggleSetting(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
    bool initialValue,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
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
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
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
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
          ),
          value: initialValue,
          activeColor: AppTheme.primaryColor,
          onChanged: (value) {
            print('$title setting toggled to $value');
          },
        ),
      ),
    );
  }
}