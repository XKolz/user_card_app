import 'package:flutter/material.dart';

import '../screens/savings/savings_goals_screen.dart';
import '../screens/scheduled_payments/scheduled_payments_screen.dart';
import '../screens/transactions/transaction_history_screen.dart';
import '../state/app_controller.dart';
import '../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _DrawerHeader(controller: controller, onOpenSettings: () => _selectTab(context, 3)),
          _DrawerItem(
            icon: Icons.home,
            title: 'Home',
            selected: currentIndex == 0,
            onTap: () => _selectTab(context, 0),
          ),
          _DrawerItem(
            icon: Icons.account_balance_wallet,
            title: 'Wallet',
            selected: currentIndex == 1,
            onTap: () => _selectTab(context, 1),
          ),
          _DrawerItem(
            icon: Icons.bar_chart,
            title: 'Statistics',
            selected: currentIndex == 2,
            onTap: () => _selectTab(context, 2),
          ),
          _DrawerItem(
            icon: Icons.settings,
            title: 'Settings',
            selected: currentIndex == 3,
            onTap: () => _selectTab(context, 3),
          ),
          const Divider(),
          _DrawerItem(
            icon: Icons.history,
            title: 'Transaction History',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TransactionHistoryScreen(controller: controller),
                ),
              );
            },
          ),
          _DrawerItem(
            icon: Icons.payment,
            title: 'Scheduled Payments',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ScheduledPaymentsScreen(controller: controller),
                ),
              );
            },
          ),
          _DrawerItem(
            icon: Icons.savings,
            title: 'Savings Goals',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SavingsGoalsScreen(controller: controller),
                ),
              );
            },
          ),
          const Divider(),
          _DrawerItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Demo support flow ready. Add your backend/API next.')),
              );
            },
          ),
          _DrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout is a demo action in this build.')),
              );
            },
          ),
        ],
      ),
    );
  }

  void _selectTab(BuildContext context, int index) {
    Navigator.pop(context);
    onSelectTab(index);
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    required this.controller,
    required this.onOpenSettings,
  });

  final AppController controller;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor,
            AppTheme.primaryColor.withValues(alpha: 0.82),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 36),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.userName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      controller.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet, color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      formatCurrency(controller.balance),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: onOpenSettings,
                icon: const Icon(Icons.settings, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: selected ? AppTheme.primaryColor : Colors.grey.shade700,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? AppTheme.primaryColor : AppTheme.darkTextColor,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      tileColor: selected ? AppTheme.primaryColor.withValues(alpha: 0.1) : null,
      shape: selected ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)) : null,
      onTap: onTap,
    );
  }
}

