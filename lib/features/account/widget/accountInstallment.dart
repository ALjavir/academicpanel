import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/dateTime_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/template/normal/dotLine_template.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Accountinstallment extends StatelessWidget {
  final List<AccountPageModelInstallment> accountPageModelInstallment;
  const Accountinstallment({
    super.key,
    required this.accountPageModelInstallment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ThreeDContainel(
        padding: const EdgeInsets.all(12),
        redious: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 4,
              children: [
                Image.asset(
                  ImageStyle.installmentIcon(),
                  scale: 16,
                  color: ColorStyle.red,
                ),
                Text(
                  "Installment",
                  style: Fontstyle.defult(
                    22,
                    FontWeight.w600,
                    ColorStyle.Textblue,
                  ),
                ),
              ],
            ),
            Divider(color: ColorStyle.red),
            if (accountPageModelInstallment.isEmpty)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRect(
                    child: SizedBox(
                      height: 120,
                      width: double.maxFinite,
                      child: Transform.scale(
                        scale: 2,
                        child: LottieBuilder.asset(
                          ImageStyle.upCommingClassaAimatedIcon(),
                          frameRate: FrameRate.max,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    // "No exam for now, relax!",
                    "No Data Found!!!",
                    style: Fontstyle.defult(
                      18,
                      FontWeight.bold,
                      ColorStyle.Textblue,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              )
            else
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: accountPageModelInstallment.length,
                itemBuilder: (context, index) {
                  final item = accountPageModelInstallment[index];
                  final isLast =
                      index == accountPageModelInstallment.length - 1;
                  // final amount =
                  //     item.totalDue * (item.installment.amountPercentage / 100);
                  final name;
                  if (item.installment.code.endsWith('1')) {
                    name = "1st Installment";
                  } else if (item.installment.code.endsWith('2')) {
                    name = "2nd Installment";
                  } else {
                    name = "3rd Installment";
                  }

                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        DotlineTemplate(isLast: isLast, index: index),

                        // --- MIDDLE SECTION: Content ---
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              if (item.state == 'past')
                                pastInst(item, name)
                              else if (item.state == 'present')
                                presentInst(item, name)
                              else
                                futureInst(item, name),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget pastInst(AccountPageModelInstallment item, String name) {
    final double targetAmount =
        item.totalDue * (item.installment.amountPercentage / 100);

    final double remainingDue = targetAmount - item.totalPaid;

    final double fineAmount = item.installment.fine;
    final bool hasFine = fineAmount > 0;
    final double fixFine = item.fineModel?.amount ?? 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: name,
                style: Fontstyle.defult(
                  18,
                  FontWeight.w600,
                  ColorStyle.Textblue,
                ),
              ),
              TextSpan(
                text: " (${item.installment.amountPercentage.toInt()}%)",
                style: Fontstyle.defult(
                  16,
                  FontWeight.w600,
                  ColorStyle.lightBlue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Row(
          spacing: 4,
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: ColorStyle.red,
              size: 18,
            ),
            Text(
              DateFormat('d MMM').format(item.installment.deadline),
              style: Fontstyle.defult(16, FontWeight.bold, ColorStyle.Textblue),
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (fixFine > 0) ...[
          Row(
            children: [
              Icon(Icons.cancel_outlined, size: 18, color: ColorStyle.red),
              const SizedBox(width: 2),
              Text(
                "OVERDUE: ",
                style: Fontstyle.defult(
                  15,
                  FontWeight.bold,
                  ColorStyle.Textblue,
                ),
              ),
              Text(
                "${item.fineModel!.amount.toStringAsFixed(0)}৳",
                style: Fontstyle.defult(16, FontWeight.bold, ColorStyle.red),
              ),
            ],
          ),
        ] else if (remainingDue > 0) ...[
          Row(
            children: [
              Icon(Icons.cancel_outlined, size: 18, color: ColorStyle.red),
              const SizedBox(width: 2),
              Text(
                "OVERDUE: ",
                style: Fontstyle.defult(
                  15,
                  FontWeight.bold,
                  ColorStyle.Textblue,
                ),
              ),
              Text(
                "${remainingDue.toStringAsFixed(0)}৳",
                style: Fontstyle.defult(16, FontWeight.bold, ColorStyle.red),
              ),
            ],
          ),

          if (hasFine)
            Padding(
              padding: const EdgeInsets.only(top: 2.0, left: 20.0),
              child: Text(
                "*Fine ${fineAmount.toStringAsFixed(0)}TK will be add soon",
                style: Fontstyle.defult(12, FontWeight.w500, ColorStyle.red),
              ),
            ),
        ] else ...[
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                size: 20,
                color: Colors.green,
              ), // Changed icon to checkmark
              const SizedBox(width: 2),
              Text(
                "PAID",
                style: Fontstyle.defult(
                  16,
                  FontWeight.bold,
                  ColorStyle.Textblue,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget presentInst(AccountPageModelInstallment item, String name) {
    final double targetAmount =
        item.totalDue * (item.installment.amountPercentage / 100);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: name,
                    style: Fontstyle.defult(
                      18,
                      FontWeight.w600,
                      ColorStyle.Textblue,
                    ),
                  ),
                  TextSpan(
                    text: " (${item.installment.amountPercentage.toInt()}%)",
                    style: Fontstyle.defult(
                      16,
                      FontWeight.w600,
                      ColorStyle.lightBlue,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: ColorStyle.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "${(DatetimeStyle.getHybridDate(dayLeft: 14, item.installment.deadline))}",
                style: Fontstyle.defult(10, FontWeight.w600, ColorStyle.light),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          spacing: 4,
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: ColorStyle.red,
              size: 18,
            ),
            Text(
              DateFormat('d MMM').format(item.installment.deadline),
              style: Fontstyle.defult(16, FontWeight.bold, ColorStyle.Textblue),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          spacing: 4,
          children: [
            const Icon(
              Icons.monetization_on_outlined,
              color: ColorStyle.red,
              size: 18,
            ),

            Text(
              "${item.totalPaid.toString()}",
              style: Fontstyle.defult(16, FontWeight.bold, ColorStyle.red),
            ),
            Text(
              " / ${targetAmount.toString()}৳",
              style: Fontstyle.defult(
                16,
                FontWeight.bold,
                ColorStyle.lightBlue,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0, left: 20.0),
          child: Text(
            "*Fine ${item.installment.fine.toString()}TK wiil be add if overdue",
            style: Fontstyle.defult(12, FontWeight.w500, ColorStyle.red),
          ),
        ),
      ],
    );
  }

  Widget futureInst(AccountPageModelInstallment item, String name) {
    final double targetAmount =
        item.totalDue * (item.installment.amountPercentage / 100);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: name,
                style: Fontstyle.defult(
                  18,
                  FontWeight.w600,
                  ColorStyle.Textblue,
                ),
              ),
              TextSpan(
                text: " (${item.installment.amountPercentage.toInt()}%)",
                style: Fontstyle.defult(
                  16,
                  FontWeight.w600,
                  ColorStyle.lightBlue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Row(
          spacing: 4,
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: ColorStyle.red,
              size: 18,
            ),
            Text(
              DateFormat('d MMM').format(item.installment.deadline),
              style: Fontstyle.defult(16, FontWeight.bold, ColorStyle.Textblue),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          spacing: 4,
          children: [
            const Icon(
              Icons.monetization_on_outlined,
              color: ColorStyle.red,
              size: 18,
            ),

            Text(
              "${targetAmount.toString()}৳",
              style: Fontstyle.defult(16, FontWeight.bold, ColorStyle.red),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0, left: 20.0),
          child: Text(
            "*Fine ${item.installment.fine.toString()}TK wiil be add if overdue",
            style: Fontstyle.defult(12, FontWeight.w500, ColorStyle.red),
          ),
        ),
      ],
    );
  }
}
