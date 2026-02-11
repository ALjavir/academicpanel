import 'dart:math';

import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threeD_containerHead.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Accounttopheader extends StatelessWidget {
  final AccountPageModelTopHeader accountPageModelTopHeader;
  const Accounttopheader({super.key, required this.accountPageModelTopHeader});

  @override
  Widget build(BuildContext context) {
    final double balanceAmount = accountPageModelTopHeader.balance < 0
        ? accountPageModelTopHeader.balance.abs()
        : 0;

    // Create list of items
    List<_LayerItem> items = [
      _LayerItem(
        "Total Fee",
        accountPageModelTopHeader.due,
        Colors.grey.shade300,
        isDark: true,
      ), // The full tuition
      _LayerItem(
        "Waiver",
        accountPageModelTopHeader.waiver,
        Colors.orangeAccent,
      ),
      _LayerItem("Paid", accountPageModelTopHeader.paid, Colors.green),
      _LayerItem(
        "Balance",
        accountPageModelTopHeader.balance.abs(),
        accountPageModelTopHeader.balance < 0 ? ColorStyle.red : Colors.teal,
      ), // Red if Due, Teal if Surplus
    ];

    // 2. CRITICAL: Sort by Size (Largest -> Smallest)
    // This ensures the biggest bar is at the bottom (Stack index 0)
    // and the smallest is at the top, so nothing gets hidden.
    items.sort((a, b) => b.amount.compareTo(a.amount));

    // 3. Determine the Scale (The largest bar is 100%)
    double maxValue = items.first.amount;
    if (maxValue == 0) maxValue = 1;
    // 3. Determine Max Value (The bottom layer defines the scale)

    return ThreedContainerhead(
      padding: EdgeInsets.fromLTRB(10, 120, 10, 90),
      imagePath: ImageStyle.accountTopBackground(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30, // Fixed height for the single compact bar
            child: Stack(
              children: items.map((item) {
                // Calculate width percentage (0.0 to 1.0)
                final double percent = (item.amount.abs() / maxValue).clamp(
                  0.0,
                  1.0,
                );

                // If amount is 0, don't show it
                if (percent == 0) return const SizedBox();

                return FractionallySizedBox(
                  widthFactor: percent, // Takes up X% of the width
                  child: Container(
                    decoration: BoxDecoration(
                      color: item.color,
                      borderRadius: BorderRadius.circular(8), // Rounded edges
                      boxShadow: [
                        // Optional: Tiny shadow to separate layers visually
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    alignment: Alignment
                        .centerRight, // Align text to the end of the bar
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      // Format: "Label: 500"
                      "${item.label}: ${item.amount.toInt()}",
                      maxLines: 1,
                      overflow: TextOverflow
                          .visible, // Allow text to stick out if needed
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        // Smart Color: Dark text for light bars (Total), White for dark bars
                        color: Colors.black54,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _LayerItem {
  final String label;
  final double amount;
  final Color color;
  final bool isDark; // Helps us choose text color (White vs Black)

  _LayerItem(this.label, this.amount, this.color, {this.isDark = false});
}
