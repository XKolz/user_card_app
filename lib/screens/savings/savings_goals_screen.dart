import 'package:flutter/material.dart';

import '../../state/app_controller.dart';
import '../../theme/app_theme.dart';

class SavingsGoalsScreen extends StatelessWidget {
  const SavingsGoalsScreen({
    super.key,
    required this.controller,
  });

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: AppBar(
            title: const Text('Savings Goals'),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: AppTheme.darkTextColor,
            elevation: 0,
          ),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                'Contribute a demo amount to see the wallet balance and history respond end to end.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 20),
              for (final goal in controller.savingsGoals) ...[
                _SavingsGoalCard(
                  goal: goal,
                  onContribute: () {
                    controller.contributeToGoal(goal, 75);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added ${formatCurrency(75)} to ${goal.title}.')),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _SavingsGoalCard extends StatelessWidget {
  const _SavingsGoalCard({
    required this.goal,
    required this.onContribute,
  });

  final SavingsGoal goal;
  final VoidCallback onContribute;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  goal.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.darkTextColor,
                      ),
                ),
              ),
              Text(
                '${(goal.progress * 100).round()}%',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: goal.color,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: goal.progress,
              minHeight: 10,
              color: goal.color,
              backgroundColor: goal.color.withValues(alpha: 0.12),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${formatCurrency(goal.current)} of ${formatCurrency(goal.target)}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade700),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: onContribute,
            child: const Text('Add \$75'),
          ),
        ],
      ),
    );
  }
}
