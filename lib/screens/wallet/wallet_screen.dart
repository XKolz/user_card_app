import 'package:flutter/material.dart';

import '../../state/app_controller.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_drawer.dart';
import '../transactions/transaction_history_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({
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
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final theme = Theme.of(context);

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          drawer: AppDrawer(
            controller: controller,
            currentIndex: currentIndex,
            onSelectTab: onSelectTab,
          ),
          appBar: AppBar(
            title: const Text('My Wallet'),
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
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () {
                  controller.addPaymentMethod();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Demo payment method added.')),
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Methods',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppTheme.darkTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    for (final method in controller.paymentMethods) ...[
                      _CreditCardCard(method: method),
                      const SizedBox(height: 16),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Linked Accounts',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: AppTheme.darkTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.linkDemoAccount();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('New linked account created.')),
                            );
                          },
                          child: Text(
                            'Link New',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    for (final account in controller.linkedAccounts) ...[
                      _LinkedAccountTile(account: account),
                      const SizedBox(height: 16),
                    ],
                    const SizedBox(height: 16),
                    Text(
                      'Saved Beneficiaries',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppTheme.darkTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (final beneficiary in controller.beneficiaries.take(3))
                          _BeneficiaryAvatar(
                            beneficiary: beneficiary,
                            onTap: () {
                              controller.sendMoney(
                                recipient: beneficiary.name,
                                amount: 35,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Sent demo transfer to ${beneficiary.name}.')),
                              );
                            },
                          ),
                        _BeneficiaryAvatar(
                          beneficiary: const Beneficiary(name: 'Add New', color: Colors.grey),
                          onTap: () {
                            controller.addBeneficiary();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('New beneficiary added to the wallet.')),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Activity',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: AppTheme.darkTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TransactionHistoryScreen(controller: controller),
                              ),
                            );
                          },
                          child: Text(
                            'View All',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    for (final item in controller.recentWalletActivity) ...[
                      _WalletActivityTile(transaction: item),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CreditCardCard extends StatelessWidget {
  const _CreditCardCard({
    required this.method,
  });

  final PaymentMethod method;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [method.color, method.color.withValues(alpha: 0.82)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: method.color.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                method.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              if (method.isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Default',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            method.maskedNumber,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  letterSpacing: 2,
                ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                method.expiry,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
              ),
              const Icon(Icons.credit_card, color: Colors.white, size: 32),
            ],
          ),
        ],
      ),
    );
  }
}

class _LinkedAccountTile extends StatelessWidget {
  const _LinkedAccountTile({
    required this.account,
  });

  final LinkedAccount account;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: account.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.account_balance, color: account.color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.bankName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkTextColor,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  account.accountInfo,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            formatCurrency(account.balance),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkTextColor,
                ),
          ),
        ],
      ),
    );
  }
}

class _BeneficiaryAvatar extends StatelessWidget {
  const _BeneficiaryAvatar({
    required this.beneficiary,
    required this.onTap,
  });

  final Beneficiary beneficiary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isAddNew = beneficiary.name == 'Add New';

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isAddNew ? Colors.grey.withValues(alpha: 0.1) : beneficiary.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: isAddNew ? Border.all(color: Colors.grey) : null,
            ),
            child: Icon(
              isAddNew ? Icons.add : Icons.person,
              color: isAddNew ? Colors.grey : beneficiary.color,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            beneficiary.name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isAddNew ? Colors.grey : AppTheme.darkTextColor,
                ),
          ),
        ],
      ),
    );
  }
}

class _WalletActivityTile extends StatelessWidget {
  const _WalletActivityTile({
    required this.transaction,
  });

  final TransactionRecord transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkTextColor,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  formatDateLabel(transaction.date),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
          Text(
            formatCurrency(transaction.amount),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: transaction.isIncome ? AppTheme.secondaryColor : AppTheme.redColor,
                ),
          ),
        ],
      ),
    );
  }
}
