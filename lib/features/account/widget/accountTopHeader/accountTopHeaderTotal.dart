import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Accounttopheadertotal extends StatelessWidget {
  final AccountPageModelTopHeader accountPageModelTopHeader;
  const Accounttopheadertotal({
    super.key,
    required this.accountPageModelTopHeader,
  });

  @override
  Widget build(BuildContext context) {
    final remaining =
        accountPageModelTopHeader.totalPaid -
        accountPageModelTopHeader.totalDue;
    return Column(
      spacing: 8,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.task_alt_rounded, color: Colors.red, size: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Total Paid",
                            style: Fontstyle.defult(
                              14,
                              FontWeight.bold,
                              ColorStyle.light,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "${NumberFormat.decimalPattern().format(accountPageModelTopHeader.totalPaid.toInt())}",
                            style: Fontstyle.defult(
                              18,
                              FontWeight.w600,
                              ColorStyle.light,
                            ),
                          ),
                          TextSpan(
                            text:
                                " / ${NumberFormat.decimalPattern().format(accountPageModelTopHeader.totalDue)}",
                            style: Fontstyle.defult(
                              18,
                              FontWeight.w500,
                              Colors.white70,
                            ),
                          ),
                          TextSpan(
                            text: " ৳",
                            style: Fontstyle.defult(
                              20,
                              FontWeight.bold,
                              Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Icon(Icons.cancel_outlined, color: Colors.red, size: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: NumberFormat.decimalPattern().format(
                              remaining.toInt().abs(),
                            ),
                            style: Fontstyle.defult(
                              18,
                              FontWeight.w600,
                              ColorStyle.light,
                            ),
                          ),

                          TextSpan(
                            text: " ৳",
                            style: Fontstyle.defult(
                              18,
                              FontWeight.bold,
                              Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Remaining Due",
                      style: Fontstyle.defult(
                        14,
                        FontWeight.bold,
                        ColorStyle.light,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        LinearPercentIndicator(
          animationDuration: 1000,
          animation: true,
          curve: Curves.easeOut,
          percent:
              (accountPageModelTopHeader.totalPaid /
                      accountPageModelTopHeader.totalDue)
                  .clamp(0.0, 1.0),

          lineHeight: 15,
          barRadius: const Radius.circular(10),
          progressColor: Colors.red,

          backgroundColor: Colors.white10,

          center: Text(
            "${((accountPageModelTopHeader.totalPaid / accountPageModelTopHeader.totalDue) * 100).toInt()}%",
            style: Fontstyle.defult(11, FontWeight.w700, Colors.white),
          ),
        ),
      ],
    );
  }
}
