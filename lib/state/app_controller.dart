import 'package:flutter/material.dart';

import '../screens/stats/models/expense_category.dart';
import '../screens/stats/models/monthly_spending.dart';
import '../theme/app_theme.dart';

class AppController extends ChangeNotifier {
  AppController() {
    final now = DateTime.now();

    _transactions = [
      TransactionRecord(
        title: 'Amazon',
        subtitle: 'Shopping',
        amount: -24.99,
        date: now.subtract(const Duration(hours: 2)),
        icon: Icons.shopping_bag_outlined,
        color: AppTheme.redColor,
        category: 'Shopping',
      ),
      TransactionRecord(
        title: 'Sarah Johnson',
        subtitle: 'Transfer',
        amount: 157.50,
        date: now.subtract(const Duration(hours: 6)),
        icon: Icons.arrow_downward_rounded,
        color: AppTheme.secondaryColor,
        category: 'Transfer',
      ),
      TransactionRecord(
        title: 'Starbucks',
        subtitle: 'Food & Drink',
        amount: -5.75,
        date: now.subtract(const Duration(days: 1)),
        icon: Icons.coffee_outlined,
        color: AppTheme.redColor,
        category: 'Food & Drinks',
      ),
      TransactionRecord(
        title: 'Netflix',
        subtitle: 'Subscription',
        amount: -15.99,
        date: now.subtract(const Duration(days: 2)),
        icon: Icons.movie_outlined,
        color: AppTheme.orangeColor,
        category: 'Bills & Utilities',
      ),
      TransactionRecord(
        title: 'City Power',
        subtitle: 'Utility bill',
        amount: -420,
        date: now.subtract(const Duration(days: 4)),
        icon: Icons.bolt_outlined,
        color: AppTheme.orangeColor,
        category: 'Bills & Utilities',
      ),
      TransactionRecord(
        title: 'Uber',
        subtitle: 'Transportation',
        amount: -12.75,
        date: now.subtract(const Duration(days: 6)),
        icon: Icons.directions_car_outlined,
        color: AppTheme.secondaryColor,
        category: 'Transportation',
      ),
      TransactionRecord(
        title: 'Grocery Store',
        subtitle: 'Shopping',
        amount: -86.34,
        date: now.subtract(const Duration(days: 8)),
        icon: Icons.shopping_cart_outlined,
        color: AppTheme.primaryColor,
        category: 'Shopping',
      ),
      TransactionRecord(
        title: 'Salary',
        subtitle: 'Income',
        amount: 3200,
        date: DateTime(now.year, now.month, 1),
        icon: Icons.work_outline,
        color: AppTheme.secondaryColor,
        category: 'Income',
      ),
      TransactionRecord(
        title: 'Apartment Rent',
        subtitle: 'Housing',
        amount: -950,
        date: DateTime(now.year, now.month - 1, 28),
        icon: Icons.home_outlined,
        color: AppTheme.orangeColor,
        category: 'Bills & Utilities',
      ),
      TransactionRecord(
        title: 'Freelance Client',
        subtitle: 'Side income',
        amount: 640,
        date: DateTime(now.year, now.month - 1, 14),
        icon: Icons.laptop_mac_outlined,
        color: AppTheme.secondaryColor,
        category: 'Income',
      ),
      TransactionRecord(
        title: 'Restaurant',
        subtitle: 'Food & Drink',
        amount: -74,
        date: DateTime(now.year, now.month - 2, 21),
        icon: Icons.restaurant_outlined,
        color: AppTheme.redColor,
        category: 'Food & Drinks',
      ),
    ];
  }

  String userName = 'John Doe';
  String email = 'john.doe@example.com';
  bool biometricLogin = true;
  bool transactionAlerts = true;
  bool darkMode = false;

  final List<PaymentMethod> paymentMethods = [
    const PaymentMethod(
      name: 'Visa',
      maskedNumber: '**** **** **** 4582',
      expiry: 'Expires 05/28',
      color: AppTheme.primaryColor,
      isDefault: true,
    ),
    const PaymentMethod(
      name: 'Mastercard',
      maskedNumber: '**** **** **** 2385',
      expiry: 'Expires 11/26',
      color: AppTheme.orangeColor,
    ),
  ];

  final List<LinkedAccount> linkedAccounts = [
    const LinkedAccount(
      bankName: 'Chase Bank',
      accountInfo: 'Checking ****1234',
      balance: 2846.50,
      color: AppTheme.secondaryColor,
    ),
    const LinkedAccount(
      bankName: 'Wells Fargo',
      accountInfo: 'Savings ****5678',
      balance: 8521.75,
      color: AppTheme.primaryColor,
    ),
  ];

  final List<Beneficiary> beneficiaries = [
    const Beneficiary(name: 'Sarah', color: AppTheme.primaryColor),
    const Beneficiary(name: 'Mike', color: AppTheme.redColor),
    const Beneficiary(name: 'Emma', color: AppTheme.secondaryColor),
  ];

  final List<ScheduledPayment> scheduledPayments = [
    const ScheduledPayment(
      title: 'Netflix',
      subtitle: 'Entertainment plan',
      amount: 15.99,
      nextRunLabel: 'Tomorrow',
      category: 'Bills & Utilities',
      icon: Icons.movie_outlined,
      color: AppTheme.orangeColor,
    ),
    const ScheduledPayment(
      title: 'Internet Fiber',
      subtitle: 'Home broadband',
      amount: 42.50,
      nextRunLabel: 'In 3 days',
      category: 'Bills & Utilities',
      icon: Icons.wifi_outlined,
      color: AppTheme.primaryColor,
    ),
  ];

  final List<SavingsGoal> savingsGoals = [
    const SavingsGoal(
      title: 'Vacation',
      target: 1500,
      current: 620,
      color: AppTheme.primaryColor,
    ),
    const SavingsGoal(
      title: 'Emergency Fund',
      target: 4000,
      current: 2100,
      color: AppTheme.secondaryColor,
    ),
  ];

  final Map<String, double> budgetLimits = const {
    'Shopping': 600,
    'Food & Drinks': 400,
    'Transportation': 200,
    'Bills & Utilities': 400,
  };

  late final List<TransactionRecord> _transactions;

  List<TransactionRecord> get transactions => List.unmodifiable(_transactions);

  double get balance => _transactions.fold<double>(0, (sum, item) => sum + item.amount);

  List<TransactionRecord> get recentTransactions => _transactions.take(4).toList();

  List<TransactionRecord> get recentWalletActivity => _transactions.take(3).toList();

  double get monthlySpendTotal => _transactions
      .where((item) => !item.isIncome && _isCurrentMonth(item.date))
      .fold<double>(0, (sum, item) => sum + item.amount.abs());

  double get monthlyIncomeTotal => _transactions
      .where((item) => item.isIncome && _isCurrentMonth(item.date))
      .fold<double>(0, (sum, item) => sum + item.amount);

  List<ExpenseCategory> get expenseCategories {
    final totals = <String, double>{};
    for (final item in _transactions.where((entry) => !entry.isIncome && _isCurrentMonth(entry.date))) {
      totals.update(item.category, (value) => value + item.amount.abs(), ifAbsent: () => item.amount.abs());
    }

    final totalSpend = totals.values.fold<double>(0, (sum, value) => sum + value);
    if (totalSpend == 0) {
      return [ExpenseCategory('No spend', 100, Colors.grey)];
    }

    return totals.entries.map((entry) {
      final percentage = ((entry.value / totalSpend) * 100).round().clamp(1, 100);
      return ExpenseCategory(entry.key, percentage, colorForCategory(entry.key));
    }).toList()
      ..sort((a, b) => b.percentage.compareTo(a.percentage));
  }

  List<MonthlySpending> get monthlySpending {
    final now = DateTime.now();
    final result = <MonthlySpending>[];

    for (var index = 4; index >= 0; index--) {
      final monthDate = DateTime(now.year, now.month - index, 1);
      final amount = _transactions
          .where((item) =>
              !item.isIncome &&
              item.date.year == monthDate.year &&
              item.date.month == monthDate.month)
          .fold<double>(0, (sum, item) => sum + item.amount.abs());

      result.add(MonthlySpending(_monthLabel(monthDate.month), amount == 0 ? 1 : amount));
    }

    return result;
  }

  List<BudgetProgress> get budgets => budgetLimits.entries.map((entry) {
        final spent = _transactions
            .where((item) =>
                !item.isIncome &&
                item.category == entry.key &&
                _isCurrentMonth(item.date))
            .fold<double>(0, (sum, item) => sum + item.amount.abs());

        return BudgetProgress(
          category: entry.key,
          spent: spent,
          limit: entry.value,
          color: colorForCategory(entry.key),
        );
      }).toList();

  void updateProfile({
    required String nextName,
    required String nextEmail,
  }) {
    userName = nextName;
    email = nextEmail;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    darkMode = value;
    notifyListeners();
  }

  void toggleBiometricLogin(bool value) {
    biometricLogin = value;
    notifyListeners();
  }

  void toggleTransactionAlerts(bool value) {
    transactionAlerts = value;
    notifyListeners();
  }

  void sendMoney({
    required String recipient,
    required double amount,
  }) {
    _prependTransaction(
      TransactionRecord(
        title: recipient,
        subtitle: 'Transfer sent',
        amount: -amount,
        date: DateTime.now(),
        icon: Icons.arrow_upward_rounded,
        color: AppTheme.redColor,
        category: 'Transfer',
      ),
    );
  }

  void receiveMoney({
    required String sender,
    required double amount,
  }) {
    _prependTransaction(
      TransactionRecord(
        title: sender,
        subtitle: 'Money received',
        amount: amount,
        date: DateTime.now(),
        icon: Icons.arrow_downward_rounded,
        color: AppTheme.secondaryColor,
        category: 'Income',
      ),
    );
  }

  void scanToPay() {
    _prependTransaction(
      TransactionRecord(
        title: 'Corner Shop',
        subtitle: 'QR payment',
        amount: -18.40,
        date: DateTime.now(),
        icon: Icons.qr_code_scanner_rounded,
        color: AppTheme.orangeColor,
        category: 'Shopping',
      ),
    );
  }

  void addPaymentMethod() {
    final count = paymentMethods.length + 1;
    paymentMethods.add(
      PaymentMethod(
        name: 'Virtual Card $count',
        maskedNumber: '**** **** **** ${4000 + count}',
        expiry: 'Expires 12/29',
        color: count.isEven ? AppTheme.primaryColor : AppTheme.secondaryColor,
      ),
    );
    notifyListeners();
  }

  void linkDemoAccount() {
    final count = linkedAccounts.length + 1;
    linkedAccounts.add(
      LinkedAccount(
        bankName: 'Monarch Bank',
        accountInfo: 'Checking ****98$count',
        balance: 1200 + (count * 325),
        color: AppTheme.orangeColor,
      ),
    );
    notifyListeners();
  }

  void addBeneficiary() {
    beneficiaries.add(
      Beneficiary(
        name: 'Alex ${beneficiaries.length + 1}',
        color: Colors.grey,
      ),
    );
    notifyListeners();
  }

  void runScheduledPayment(ScheduledPayment payment) {
    _prependTransaction(
      TransactionRecord(
        title: payment.title,
        subtitle: payment.subtitle,
        amount: -payment.amount,
        date: DateTime.now(),
        icon: payment.icon,
        color: payment.color,
        category: payment.category,
      ),
    );
  }

  void contributeToGoal(SavingsGoal goal, double amount) {
    final index = savingsGoals.indexOf(goal);
    if (index == -1) {
      return;
    }

    savingsGoals[index] = goal.copyWith(current: goal.current + amount);
    _prependTransaction(
      TransactionRecord(
        title: goal.title,
        subtitle: 'Savings contribution',
        amount: -amount,
        date: DateTime.now(),
        icon: Icons.savings_outlined,
        color: goal.color,
        category: 'Savings',
      ),
      notify: false,
    );
    notifyListeners();
  }

  Color colorForCategory(String category) {
    switch (category) {
      case 'Shopping':
        return AppTheme.primaryColor;
      case 'Food & Drinks':
        return AppTheme.redColor;
      case 'Transportation':
        return AppTheme.secondaryColor;
      case 'Bills & Utilities':
        return AppTheme.orangeColor;
      default:
        return Colors.grey;
    }
  }

  bool _isCurrentMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  void _prependTransaction(TransactionRecord transaction, {bool notify = true}) {
    _transactions.insert(0, transaction);
    if (notify) {
      notifyListeners();
    }
  }
}

class PaymentMethod {
  const PaymentMethod({
    required this.name,
    required this.maskedNumber,
    required this.expiry,
    required this.color,
    this.isDefault = false,
  });

  final String name;
  final String maskedNumber;
  final String expiry;
  final Color color;
  final bool isDefault;
}

class LinkedAccount {
  const LinkedAccount({
    required this.bankName,
    required this.accountInfo,
    required this.balance,
    required this.color,
  });

  final String bankName;
  final String accountInfo;
  final double balance;
  final Color color;
}

class Beneficiary {
  const Beneficiary({
    required this.name,
    required this.color,
  });

  final String name;
  final Color color;
}

class TransactionRecord {
  const TransactionRecord({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.icon,
    required this.color,
    required this.category,
  });

  final String title;
  final String subtitle;
  final double amount;
  final DateTime date;
  final IconData icon;
  final Color color;
  final String category;

  bool get isIncome => amount >= 0;
}

class BudgetProgress {
  const BudgetProgress({
    required this.category,
    required this.spent,
    required this.limit,
    required this.color,
  });

  final String category;
  final double spent;
  final double limit;
  final Color color;

  bool get isOverBudget => spent > limit;
}

class ScheduledPayment {
  const ScheduledPayment({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.nextRunLabel,
    required this.category,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final double amount;
  final String nextRunLabel;
  final String category;
  final IconData icon;
  final Color color;
}

class SavingsGoal {
  const SavingsGoal({
    required this.title,
    required this.target,
    required this.current,
    required this.color,
  });

  final String title;
  final double target;
  final double current;
  final Color color;

  double get progress => (current / target).clamp(0.0, 1.0);

  SavingsGoal copyWith({
    double? current,
  }) {
    return SavingsGoal(
      title: title,
      target: target,
      current: current ?? this.current,
      color: color,
    );
  }
}

String formatCurrency(double value) {
  final absolute = value.abs();
  final parts = absolute.toStringAsFixed(2).split('.');
  final whole = parts[0];
  final buffer = StringBuffer();

  for (var index = 0; index < whole.length; index++) {
    final position = whole.length - index;
    buffer.write(whole[index]);
    if (position > 1 && position % 3 == 1) {
      buffer.write(',');
    }
  }

  final prefix = value < 0 ? '- ' : '';
  return '$prefix\$${buffer.toString()}.${parts[1]}';
}

String formatDateLabel(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final target = DateTime(date.year, date.month, date.day);
  final difference = today.difference(target).inDays;

  if (difference == 0) {
    final hour = date.hour == 0 ? 12 : (date.hour > 12 ? date.hour - 12 : date.hour);
    final minute = date.minute.toString().padLeft(2, '0');
    final suffix = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $suffix';
  }

  if (difference == 1) {
    return 'Yesterday';
  }

  return '${date.day.toString().padLeft(2, '0')} ${_monthLabel(date.month)} ${date.year}';
}

String _monthLabel(int month) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return months[month - 1];
}
