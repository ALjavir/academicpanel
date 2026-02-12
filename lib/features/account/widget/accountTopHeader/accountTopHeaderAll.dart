import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Accounttopheaderall extends StatelessWidget {
  final AccountPageModelTopHeader accountPageModelTopHeader;

  const Accounttopheaderall({
    super.key,
    required this.accountPageModelTopHeader,
  });

  @override
  Widget build(BuildContext context) {
    List<SegmentItem> items = [
      SegmentItem(
        "Total Fee",
        accountPageModelTopHeader.due,
        Colors.grey.shade300,
      ), // Background Base
      SegmentItem(
        "Waiver",
        accountPageModelTopHeader.waiver,
        Colors.orangeAccent,
      ),
      SegmentItem("Paid", accountPageModelTopHeader.paid, Colors.green),
      SegmentItem(
        "Balance",
        accountPageModelTopHeader.balance,
        accountPageModelTopHeader.balance < 0 ? Colors.redAccent : Colors.teal,
      ),
    ];

    // 2. SORT: Largest Absolute Value first (Bottom layer) -> Smallest last (Top layer)
    items.sort((a, b) => b.amount.abs().compareTo(a.amount.abs()));

    // 3. Determine Max Value (The bottom layer defines the scale)
    double maxValue = items.first.amount.abs();
    if (maxValue == 0) maxValue = 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- THE STACKED BAR ---
        SizedBox(
          height: 30, // Adjust height as needed
          child: Stack(
            children: items.map((item) {
              double percent = (item.amount.abs() / maxValue).clamp(0.0, 1.0);

              return Center(
                child: LinearPercentIndicator(
                  animation: true,
                  animationDuration: 1000,
                  lineHeight: 20.0, // Height of the bar
                  percent: percent,
                  barRadius: const Radius.circular(10),
                  progressColor: item.color,
                  // IMPORTANT: Only the bottom layer needs a background color.
                  // Upper layers must be transparent to show the bar below them.
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.zero, // Remove default padding
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 10),

        // --- THE LEGEND (Color Key) ---
        // Since bars are stacked, we need a legend to tell them apart
        Wrap(
          spacing: 12,
          runSpacing: 4,
          children: items.map((item) {
            // Only show items that actually have a value > 0
            if (item.amount.abs() < 1) return const SizedBox();

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: item.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  "${item.label}: ${item.amount.toInt()}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

class SegmentItem {
  final String label;

  final double amount;

  final Color color;

  SegmentItem(this.label, this.amount, this.color);
}
