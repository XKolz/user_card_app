import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Transaction History'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.darkTextColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All Transactions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.darkTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView(
                  children: [
                    _buildTransactionItem(
                      context,
                      'Amazon',
                      'Shopping',
                      '- \$24.99',
                      AppTheme.redColor,
                      Icons.shopping_bag_outlined,
                      '2:30 PM',
                    ),
                    const SizedBox(height: 16.0),
                    _buildTransactionItem(
                      context,
                      'Sarah Johnson',
                      'Transfer',
                      '+ \$157.50',
                      AppTheme.secondaryColor,
                      Icons.arrow_downward_rounded,
                      '10:24 AM',
                    ),
                    const SizedBox(height: 16.0),
                    _buildTransactionItem(
                      context,
                      'Starbucks',
                      'Food & Drink',
                      '- \$5.75',
                      AppTheme.redColor,
                      Icons.coffee_outlined,
                      'Yesterday',
                    ),
                    const SizedBox(height: 16.0),
                    _buildTransactionItem(
                      context,
                      'Netflix',
                      'Subscription',
                      '- \$15.99',
                      AppTheme.redColor,
                      Icons.movie_outlined,
                      'Yesterday',
                    ),
                    const SizedBox(height: 16.0),
                    _buildTransactionItem(
                      context,
                      'Salary',
                      'Income',
                      '+ \$3,200.00',
                      AppTheme.secondaryColor,
                      Icons.work_outline,
                      '25 Apr 2025',
                    ),
                    const SizedBox(height: 16.0),
                    _buildTransactionItem(
                      context,
                      'Uber',
                      'Transportation',
                      '- \$12.75',
                      AppTheme.redColor,
                      Icons.directions_car_outlined,
                      '24 Apr 2025',
                    ),
                    const SizedBox(height: 16.0),
                    _buildTransactionItem(
                      context,
                      'Grocery Store',
                      'Shopping',
                      '- \$86.34',
                      AppTheme.redColor,
                      Icons.shopping_cart_outlined,
                      '22 Apr 2025',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    String title,
    String subtitle,
    String amount,
    Color iconColor,
    IconData icon,
    String time,
  ) {
    final bool isNegative = amount.contains('-');
    
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
          const SizedBox(width: 16),
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
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isNegative ? AppTheme.redColor : AppTheme.secondaryColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}