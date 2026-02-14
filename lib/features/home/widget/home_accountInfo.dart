// ignore_for_file: deprecated_member_use

import 'package:academicpanel/model/AccountSuperModel/row_installment_model.dart';
import 'package:academicpanel/model/pages/home_page_model.dart';
import 'package:academicpanel/theme/style/dateTime_style.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeAccountinfo extends StatelessWidget {
  final HomeAccountModel homeAccountInfoModel;

  const HomeAccountinfo({super.key, required this.homeAccountInfoModel});

  @override
  Widget build(BuildContext context) {
    return ThreeDContainel(
      hight: MediaQuery.of(context).size.height * 0.25,
      redious: 15,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    // -------------------------------------------
    // PRIORITY 1: Urgent Installment (Red Card)
    // -------------------------------------------
    if (homeAccountInfoModel.upcomingInstallment != null) {
      return _buildInstallmentCard(homeAccountInfoModel.upcomingInstallment!);
    }

    // If we have active semester data (paid or due exists)
    if (homeAccountInfoModel.totalPaid > 0 ||
        homeAccountInfoModel.totalDue > 0) {
      return _buildSummaryCard();
    }

    return _buildBalanceCard();
  }

  // --- 1. THE INSTALLMENT CARD (Urgent) ---
  Widget _buildInstallmentCard(RowInstallmentModel inst) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Installment",
              style: Fontstyle.defult(20, FontWeight.w600, ColorStyle.Textblue),
            ),

            Icon(Icons.whatshot, color: ColorStyle.red, size: 28),
          ],
        ),
        Divider(color: ColorStyle.red),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  inst.code.endsWith('1')
                      ? "1st Inst."
                      : inst.code.endsWith('2')
                      ? "2nd Inst."
                      : "3rd Inst.",
                  style: Fontstyle.defult(
                    16,
                    FontWeight.w600,
                    ColorStyle.Textblue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.brightness_1,
                    size: 5,
                    color: ColorStyle.red,
                  ),
                ),
                Text(
                  "${inst.amountPercentage.toInt()}\%",
                  style: Fontstyle.defult(
                    16,
                    FontWeight.w600,
                    ColorStyle.Textblue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.watch_later_outlined,
                            size: 16,
                            color: ColorStyle.red,
                          ),
                        ),
                        WidgetSpan(child: SizedBox(width: 2)),
                        TextSpan(
                          text:
                              " ${DatetimeStyle.getHybridDate(inst.deadline)}",
                          style: Fontstyle.defult(
                            16,
                            FontWeight.w600,
                            ColorStyle.Textblue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "৳",
                              style: Fontstyle.defult(
                                16,
                                FontWeight.w600,
                                ColorStyle.red,
                              ),
                            ),
                            WidgetSpan(child: SizedBox(width: 6)),
                            TextSpan(
                              text: NumberFormat.decimalPattern().format(
                                inst.amount.toInt(),
                              ),
                              style: Fontstyle.defult(
                                16,
                                FontWeight.w600,
                                ColorStyle.Textblue,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (inst.fine > 0)
                        Text(
                          "+৳${inst.fine} fine applies",
                          style: Fontstyle.defult(
                            12,
                            FontWeight.w500,
                            ColorStyle.red,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- 2. THE SUMMARY CARD (Chart) ---
  Widget _buildSummaryCard() {
    return Column(
      spacing: 10,
      children: [
        CircularPercentIndicator(
          animation: true,
          animationDuration: 1000,
          radius: 55.0,
          lineWidth: 8.0,
          percent: homeAccountInfoModel.paidPercentage,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${(homeAccountInfoModel.paidPercentage * 100).toInt()}%",
                style: Fontstyle.defult(
                  18,
                  FontWeight.w600,
                  ColorStyle.Textblue,
                ),
              ),
              Text(
                "Paid",
                style: Fontstyle.defult(
                  12,
                  FontWeight.w600,
                  ColorStyle.Textblue,
                ),
              ),
            ],
          ),

          progressColor: Color(0xff1F51FF),
          backgroundWidth: 1.5,

          backgroundColor: Color(0xffFF5F1F),
          circularStrokeCap: CircularStrokeCap.round,
        ),

        Expanded(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendItem(
                color: ColorStyle.pgCircleBarColor2,
                label: "Total Due",
                amount: homeAccountInfoModel.totalDue.toInt(),
              ),
              _legendItem(
                // color: Colors.green,
                color: ColorStyle.pgCircleBarColor1,
                label: "Total Paid",
                amount: homeAccountInfoModel.totalPaid.toInt(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- 3. THE BALANCE CARD (Fallback) ---
  Widget _buildBalanceCard() {
    final double currentBalance = 0;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Current Balance", style: TextStyle(color: Colors.grey)),
          SizedBox(height: 5),
          Text(
            "৳${currentBalance.toInt()}",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "No Active Dues",
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Summary Card
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
          style: Fontstyle.defult(15, FontWeight.w600, ColorStyle.Textblue),
        ),
        Spacer(),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: NumberFormat.decimalPattern().format(amount),
                style: Fontstyle.defult(
                  14,
                  FontWeight.bold,
                  ColorStyle.Textblue,
                ),
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
