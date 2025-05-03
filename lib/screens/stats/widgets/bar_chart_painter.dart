import 'package:flutter/material.dart';
import '../models/monthly_spending.dart';

class BarChartPainter extends CustomPainter {
  final List<MonthlySpending> data;
  final Color barColor;
  
  BarChartPainter(this.data, this.barColor);
  
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final barWidth = width / (data.length * 2); // Leaves space between bars
    
    // Find the maximum value for scaling
    final maxValue = data.map((e) => e.amount).reduce((a, b) => a > b ? a : b);
    
    // Draw axes
    final axesPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;
    
    // X axis
    canvas.drawLine(
      Offset(0, height - 30),
      Offset(width, height - 30),
      axesPaint,
    );
    
    // Draw bars and labels
    for (int i = 0; i < data.length; i++) {
      final item = data[i];
      final barHeight = (item.amount / maxValue) * (height - 60);
      final x = i * (width / data.length) + (width / data.length - barWidth) / 2;
      final y = height - 30 - barHeight;
      
      // Draw bar
      final barPaint = Paint()
        ..color = barColor
        ..style = PaintingStyle.fill;
      
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, barWidth, barHeight),
          const Radius.circular(4),
        ),
        barPaint,
      );
      
      // Draw month label
      final textStyle = TextStyle(
        color: Colors.grey,
        fontSize: 12,
      );
      final textSpan = TextSpan(
        text: item.month,
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x + (barWidth - textPainter.width) / 2, height - 20),
      );
      
      // Draw amount label
      final amountStyle = TextStyle(
        color: const Color(0xFF2D3142),
        fontSize: 10,
        fontWeight: FontWeight.bold,
      );
      final amountSpan = TextSpan(
        text: '\$${item.amount.toInt()}',
        style: amountStyle,
      );
      final amountPainter = TextPainter(
        text: amountSpan,
        textDirection: TextDirection.ltr,
      );
      amountPainter.layout();
      
      // Only show amount if there's enough space
      if (barHeight > amountPainter.height + 10) {
        amountPainter.paint(
          canvas,
          Offset(x + (barWidth - amountPainter.width) / 2, y + 5),
        );
      }
    }
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}