import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Accounttopheadertotal extends StatelessWidget {
  final AccountPageModelTopHeader accountPageModelTopHeader;
  const Accounttopheadertotal({
    super.key,
    required this.accountPageModelTopHeader,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.circular(90),
          ),

          child: CircularPercentIndicator(
            radius: 55.0,
            lineWidth: 8.0,
            animation: true,
            animationDuration: 1000,
            percent: accountPageModelTopHeader.totalDue == 0
                ? 0.0
                : (accountPageModelTopHeader.totalPaid /
                          accountPageModelTopHeader.totalDue)
                      .clamp(0.0, 1.0),

            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  accountPageModelTopHeader.totalDue == 0
                      ? "0%"
                      : "${((accountPageModelTopHeader.totalPaid / accountPageModelTopHeader.totalDue) * 100).toInt()}%",
                  style: Fontstyle.defult(
                    18,
                    FontWeight.w600,
                    ColorStyle.light,
                  ),
                ),
                Text(
                  "Paid",
                  style: Fontstyle.defult(
                    13,
                    FontWeight.bold,
                    ColorStyle.light,
                  ),
                ),
              ],
            ),
            progressColor: ColorStyle.pgCircleBarColor1,
            backgroundWidth: 1.5,
            backgroundColor: ColorStyle.pgCircleBarColor2,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ),

        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: Container(
                        width: 6,
                        height: 20,
                        decoration: BoxDecoration(
                          color: ColorStyle.pgCircleBarColor1,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: " Total Fee Paid",
                      style: Fontstyle.defult(
                        16,
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
                          "   ${NumberFormat.decimalPattern().format(accountPageModelTopHeader.totalPaid.toInt())}",
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
                      text: "৳",
                      style: Fontstyle.defult(20, FontWeight.bold, Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
