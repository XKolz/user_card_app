import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'models/expense_category.dart';
import 'models/monthly_spending.dart';
import 'widgets/pie_chart_painter.dart';
import 'widgets/bar_chart_painter.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Sample data for charts
    final List<ExpenseCategory> expenseCategories = [
      ExpenseCategory('Shopping', 35, AppTheme.primaryColor),
      ExpenseCategory('Food', 25, AppTheme.redColor),
      ExpenseCategory('Transport', 15, AppTheme.secondaryColor),
      ExpenseCategory('Bills', 15, AppTheme.orangeColor),
      ExpenseCategory('Others', 10, Colors.grey),
    ];
    
    // Sample monthly spending data
    final List<MonthlySpending> monthlyData = [
      MonthlySpending('Jan', 850),
      MonthlySpending('Feb', 750),
      MonthlySpending('Mar', 950),
      MonthlySpending('Apr', 1200),
      MonthlySpending('May', 980),
    ];
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Statistics'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.darkTextColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: () {
              print('Calendar filter clicked');
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
                // Summary cards
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        context,
                        'Monthly Spend',
                        '\$1,250.75',
                        '+12.5%',
                        AppTheme.primaryColor,
                        Icons.show_chart,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSummaryCard(
                        context,
                        'Monthly Income',
                        '\$3,842.50',
                        '+4.2%',
                        AppTheme.secondaryColor,
                        Icons.account_balance_wallet,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32.0),
                
                // Spending Overview
                Text(
                  'Spending Overview',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.darkTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16.0),
                
                // Expense Categories Widget - Pie Chart
                Container(
                  height: 250,
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
                      // This would be a pie chart in a real app
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: CustomPaint(
                            painter: PieChartPainter(expenseCategories),
                            child: Container(), // Empty container to hold the CustomPaint
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Legend
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: expenseCategories.map((category) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: category.color,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${category.name} (${category.percentage}%)',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32.0),
                
                // Monthly Spending Chart
                Text(
                  'Monthly Spending',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.darkTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 16.0),
                
                // Bar Chart for Monthly Spending
                Container(
                  height: 250,
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
                  child: CustomPaint(
                    painter: BarChartPainter(monthlyData, AppTheme.primaryColor),
                    child: Container(), // Empty container to hold the CustomPaint
                  ),
                ),
                
                const SizedBox(height: 32.0),
                
                // Budget Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Budget Status',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppTheme.darkTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        print('Set budget clicked');
                      },
                      child: Text(
                        'Set Budget',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16.0),
                
                // Budget Progress Bars
                _buildBudgetProgressBar(
                  context,
                  'Shopping',
                  450,
                  600,
                  AppTheme.primaryColor,
                ),
                
                const SizedBox(height: 16.0),
                
                _buildBudgetProgressBar(
                  context,
                  'Food & Drinks',
                  350,
                  400,
                  AppTheme.redColor,
                ),
                
                const SizedBox(height: 16.0),
                
                _buildBudgetProgressBar(
                  context,
                  'Transportation',
                  180,
                  200,
                  AppTheme.secondaryColor,
                ),
                
                const SizedBox(height: 16.0),
                
                _buildBudgetProgressBar(
                  context,
                  'Bills & Utilities',
                  450,
                  400,
                  AppTheme.orangeColor,
                  isOverBudget: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String amount,
    String percentage,
    Color color,
    IconData icon,
  ) {
    final bool isPositive = percentage.contains('+');
    
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            amount,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.darkTextColor,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPositive ? AppTheme.secondaryColor.withOpacity(0.1) : AppTheme.redColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  percentage,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isPositive ? AppTheme.secondaryColor : AppTheme.redColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'from last month',
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
  
  Widget _buildBudgetProgressBar(
    BuildContext context,
    String category,
    double current,
    double total,
    Color color, {
    bool isOverBudget = false,
  }) {
    final double percentage = (current / total).clamp(0.0, 1.0);
    final formattedPercentage = (percentage * 100).toStringAsFixed(1);
    
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkTextColor,
                ),
              ),
              Text(
                isOverBudget ? 'Over budget by \$${(current - total).toStringAsFixed(0)}' : '$formattedPercentage% of budget',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isOverBudget ? AppTheme.redColor : Colors.grey,
                  fontWeight: isOverBudget ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: percentage,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isOverBudget ? AppTheme.redColor : color,
                    ),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '\$${current.toInt()} / \$${total.toInt()}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}