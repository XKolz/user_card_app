import 'package:flutter/material.dart';
import '../models/expense_category.dart';
import 'dart:math' as math;

class PieChartPainter extends CustomPainter {
  final List<ExpenseCategory> categories;
  
  PieChartPainter(this.categories);
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width < size.height ? size.width / 2 : size.height / 2;
    
    double startAngle = 0;
    
    for (var category in categories) {
      final sweepAngle = category.percentage / 100 * 2 * math.pi; // Convert to radians
      
      final paint = Paint()
        ..color = category.color
        ..style = PaintingStyle.fill;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      
      startAngle += sweepAngle;
    }
    
    // Draw a smaller white circle in the center to create a donut chart
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, radius * 0.6, centerPaint);
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}