import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/dateTime_style.dart';
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
    return SizedBox(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          //   if (accountPageModelTopHeader.totalDue.toInt()>0)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Account Statement Of ${DatetimeStyle.getSemester()} ",
                  style: Fontstyle.defult(
                    18,
                    FontWeight.w600,
                    ColorStyle.light,
                  ),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.bottom,
                  child: Transform.rotate(
                    angle: -0.5,
                    child: const Icon(Icons.send, color: Colors.red, size: 26),
                  ),
                ),
              ],
            ),
          ),
          CircularPercentIndicator(
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
                  // 2. FIX: (Paid / Due) * 100
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
                    12,
                    FontWeight.w600,
                    ColorStyle.light,
                  ),
                ),
              ],
            ),
            progressColor: const Color(0xff1F51FF),
            backgroundWidth: 1.5,
            backgroundColor: const Color(0xffFF5F1F),
            circularStrokeCap: CircularStrokeCap.round,
          ),
          Expanded(
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _legendItem(
                  color: Color(0xffFF5F1F),
                  label: "Total Due",
                  amount: accountPageModelTopHeader.totalDue.toInt(),
                ),
                _legendItem(
                  // color: Colors.green,
                  color: Color(0xff1F51FF),
                  label: "Total Paid",
                  amount: accountPageModelTopHeader.totalPaid.toInt(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendItem({
    required Color color,

    required String label,
    required int amount,
  }) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: Fontstyle.defult(15, FontWeight.w600, ColorStyle.light),
        ),
        Spacer(),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: NumberFormat.decimalPattern().format(amount),
                style: Fontstyle.defult(14, FontWeight.bold, ColorStyle.light),
              ),
              TextSpan(
                text: "৳",
                style: Fontstyle.defult(16, FontWeight.bold, ColorStyle.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
