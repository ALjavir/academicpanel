// ignore_for_file: deprecated_member_use

import 'package:academicpanel/model/Account/home_account_model.dart';
import 'package:academicpanel/theme/animation/threed_containel.dart';
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

    // -------------------------------------------
    // PRIORITY 2: Semester Summary (Green Chart)
    // -------------------------------------------
    // If we have active semester data (paid or due exists)
    if (homeAccountInfoModel.totalPaid > 0 ||
        homeAccountInfoModel.totalDue > 0) {
      return _buildSummaryCard();
    }

    // -------------------------------------------
    // PRIORITY 3: Just Balance (Default State)
    // -------------------------------------------
    // Fallback if semester hasn't started or no data
    return _buildBalanceCard();
  }

  // --- 1. THE INSTALLMENT CARD (Urgent) ---
  Widget _buildInstallmentCard(InstallmentModel inst) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Installment ",
              style: Fontstyle.defult(20, FontWeight.w600, ColorStyle.Textblue),
            ),

            Icon(Icons.whatshot, color: ColorStyle.red, size: 28),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(color: ColorStyle.red),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            Text(
              inst.title == "1"
                  ? "1st"
                  : inst.title == "2"
                  ? "2nd"
                  : "3rd",
              style: Fontstyle.defult(18, FontWeight.w600, ColorStyle.Textblue),
            ),
            SizedBox(height: 5),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.watch_later_outlined,
                      size: 20,
                      color: ColorStyle.red,
                    ),
                  ),
                  TextSpan(
                    text: "  ${inst.dueDate}",
                    style: Fontstyle.defult(
                      17,
                      FontWeight.w600,
                      ColorStyle.Textblue,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "৳   ",
                        style: Fontstyle.defult(
                          20,
                          FontWeight.w600,
                          ColorStyle.red,
                        ),
                      ),
                      TextSpan(
                        text: NumberFormat.decimalPattern().format(
                          inst.amount.toInt(),
                        ),
                        style: Fontstyle.defult(
                          17,
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
      ],
    );
  }

  // --- 2. THE SUMMARY CARD (Chart) ---
  Widget _buildSummaryCard() {
    return Column(
      spacing: 10,
      children: [
        // Left: Circular Graph
        CircularPercentIndicator(
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
          progressColor: Colors.green,
          backgroundColor: Colors.orange,

          circularStrokeCap: CircularStrokeCap.round,
        ),

        // Right: Stats Legend
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendItem(
                color: Colors.green,
                label: "Total Paid",
                amount: homeAccountInfoModel.totalPaid.toInt(),
              ),
              Divider(height: 10),
              _legendItem(
                color: Colors.orange,
                label: "Remaining",
                amount: homeAccountInfoModel.totalDue.toInt(),
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
          style: Fontstyle.defult(14, FontWeight.w500, Colors.black45),
        ),
        Spacer(),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: NumberFormat.decimalPattern().format(amount),
                style: Fontstyle.defult(
                  14,
                  FontWeight.w600,
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
