import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('My Wallet'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.darkTextColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              print('Add payment method clicked');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
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
                
                const SizedBox(height: 16.0),
                
                // Credit Cards Section
                _buildCreditCard(
                  context,
                  'Visa',
                  '**** **** **** 4582',
                  'Expires 05/28',
                  AppTheme.primaryColor,
                  Icons.credit_card,
                  true,
                ),
                
                const SizedBox(height: 16.0),
                
                _buildCreditCard(
                  context,
                  'Mastercard',
                  '**** **** **** 2385',
                  'Expires 11/26',
                  AppTheme.orangeColor,
                  Icons.credit_card,
                  false,
                ),
                
                const SizedBox(height: 32.0),
                
                // Bank Accounts Section
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
                        print('Link new account clicked');
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
                
                const SizedBox(height: 16.0),
                
                _buildBankAccount(
                  context,
                  'Chase Bank',
                  'Checking ****1234',
                  '\$2,846.50',
                  AppTheme.secondaryColor,
                ),
                
                const SizedBox(height: 16.0),
                
                _buildBankAccount(
                  context,
                  'Wells Fargo',
                  'Savings ****5678',
                  '\$8,521.75',
                  AppTheme.primaryColor,
                ),
                
                const SizedBox(height: 32.0),
                
                // Saved Beneficiaries Section
                Text(
                  'Saved Beneficiaries',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.darkTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16.0),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBeneficiary(context, 'Sarah', Icons.person, AppTheme.primaryColor),
                    _buildBeneficiary(context, 'Mike', Icons.person, AppTheme.redColor),
                    _buildBeneficiary(context, 'Emma', Icons.person, AppTheme.secondaryColor),
                    _buildBeneficiary(context, 'Add New', Icons.add, Colors.grey),
                  ],
                ),
                
                const SizedBox(height: 32.0),
                
                // Recent Activity Section
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
                        print('View all activities clicked');
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
                
                const SizedBox(height: 16.0),
                
                _buildActivityItem(
                  context,
                  'Money Transfer',
                  'To Sarah Johnson',
                  '- \$157.50',
                  AppTheme.redColor,
                  'Today, 9:45 AM',
                ),
                
                const SizedBox(height: 16.0),
                
                _buildActivityItem(
                  context,
                  'Salary Deposit',
                  'From TechCorp Inc.',
                  '+ \$3,250.00',
                  AppTheme.secondaryColor,
                  'May 1, 2025',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCard(
    BuildContext context,
    String cardType,
    String cardNumber,
    String expiry,
    Color color,
    IconData icon,
    bool isDefault,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
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
                cardType,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
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
            cardNumber,
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
                expiry,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 32,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBankAccount(
    BuildContext context,
    String bankName,
    String accountInfo,
    String balance,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                Icons.account_balance,
                color: color,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bankName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  accountInfo,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            balance,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.darkTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBeneficiary(
    BuildContext context,
    String name,
    IconData icon,
    Color color,
  ) {
    final bool isAddNew = name == 'Add New';
    
    return GestureDetector(
      onTap: () {
        print('$name beneficiary clicked');
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isAddNew ? Colors.grey.withOpacity(0.1) : color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: isAddNew
                ? Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid)
                : null,
            ),
            child: Center(
              child: Icon(
                icon,
                color: isAddNew ? Colors.grey : color,
                size: 28,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: isAddNew ? Colors.grey : AppTheme.darkTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    String title,
    String subtitle,
    String amount,
    Color amountColor,
    String time,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkTextColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}