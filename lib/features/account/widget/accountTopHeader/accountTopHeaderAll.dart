import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';

import 'package:flutter/material.dart';

import 'dart:math';
import 'dart:ui' as ui;

import 'package:intl/intl.dart';

class Accounttopheaderall extends StatelessWidget {
  final AccountPageModelTopHeader accountPageModelTopHeader;

  const Accounttopheaderall({
    super.key,
    required this.accountPageModelTopHeader,
  });

  @override
  Widget build(BuildContext context) {
    List<_ChartItem> items = [
      _ChartItem("Paid", accountPageModelTopHeader.paid, Colors.green),
      _ChartItem("Waiver", accountPageModelTopHeader.waiver, Colors.amber),
      _ChartItem("Balance", accountPageModelTopHeader.balance, Colors.indigo),
      _ChartItem("Fine", accountPageModelTopHeader.fine, Colors.white),
      _ChartItem("Due", accountPageModelTopHeader.due, Colors.red),
    ];

    double chartTotal = items.fold(0, (sum, item) => sum + item.amount.abs());
    if (chartTotal == 0) chartTotal = 1;

    return Row(
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: CustomPaint(
            painter: _DonutPainter(items: items, total: chartTotal),
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: item.color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),

                        Text(
                          item.label,
                          style: Fontstyle.defult(
                            14,
                            FontWeight.w600,
                            ColorStyle.light,
                          ),
                        ),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          if (item.label == 'Due' || item.label == 'Fine')
                            TextSpan(
                              text: "-",
                              style: Fontstyle.defult(
                                14,
                                FontWeight.w600,
                                ColorStyle.light,
                              ),
                            ),

                          TextSpan(
                            text: NumberFormat.decimalPattern().format(
                              item.amount.toInt().abs(),
                            ),

                            style: Fontstyle.defult(
                              14,
                              FontWeight.w600,
                              ColorStyle.light,
                            ),
                          ),
                          TextSpan(
                            text: " ৳",
                            style: Fontstyle.defult(
                              14,
                              FontWeight.bold,
                              Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// --- THE PAINTER (Draws the Arcs & Percentages) ---
class _DonutPainter extends CustomPainter {
  final List<_ChartItem> items;
  final double total;

  _DonutPainter({required this.items, required this.total});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final strokeWidth = radius * 0.45; // Thickness of the ring

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    double startAngle = -pi / 2; // Start at 12 o'clock

    for (var item in items) {
      if (item.amount.abs() <= 0) continue;

      // Calculate Slice Size
      final sweepAngle = (item.amount.abs() / total) * 2 * pi;

      // Draw Arc
      paint.color = item.color;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - (strokeWidth / 2)),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      final double percentVal = (item.amount.abs() / total);

      if (percentVal > 0.05) {
        _drawText(canvas, center, radius, startAngle, sweepAngle, percentVal);
      }

      startAngle += sweepAngle;
    }
  }

  void _drawText(
    Canvas canvas,
    Offset center,
    double radius,
    double startAngle,
    double sweepAngle,
    double percentVal,
  ) {
    final midAngle = startAngle + (sweepAngle / 2);

    // Position text in the middle of the ring
    final textOffset = Offset(
      center.dx + (radius * 0.78) * cos(midAngle) - 10, // 0.78 adjusts depth
      center.dy + (radius * 0.78) * sin(midAngle) - 6,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: "${(percentVal * 100).toInt()}%",
        style: Fontstyle.defult(10, FontWeight.bold, Colors.white),
      ),
      textDirection: ui.TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _ChartItem {
  final String label;
  final double amount;
  final Color color;
  _ChartItem(this.label, this.amount, this.color);
}
