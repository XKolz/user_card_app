import 'package:flutter/material.dart';

import '../../state/app_controller.dart';
import '../../theme/app_theme.dart';

class ScheduledPaymentsScreen extends StatelessWidget {
  const ScheduledPaymentsScreen({
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
            title: const Text('Scheduled Payments'),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: AppTheme.darkTextColor,
            elevation: 0,
          ),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                'Run any scheduled payment to watch balance, history, and stats update together.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 20),
              for (final payment in controller.scheduledPayments) ...[
                _ScheduledPaymentCard(
                  payment: payment,
                  onRunNow: () {
                    controller.runScheduledPayment(payment);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${payment.title} payment posted.')),
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

class _ScheduledPaymentCard extends StatelessWidget {
  const _ScheduledPaymentCard({
    required this.payment,
    required this.onRunNow,
  });

  final ScheduledPayment payment;
  final VoidCallback onRunNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
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
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: payment.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(payment.icon, color: payment.color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.darkTextColor,
                      ),
                ),
                const SizedBox(height: 4),
                Text(payment.subtitle),
                const SizedBox(height: 4),
                Text(
                  'Next run: ${payment.nextRunLabel}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatCurrency(-payment.amount),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.redColor,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: onRunNow,
                child: const Text('Run now'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

