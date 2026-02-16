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
                  final amount =
                      item.totalDue / item.installmentList.amountPercentage;
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
                            spacing: 4,
                            children: [
                              // Title (Message)
                              Text(
                                item.installmentList.code.endsWith('1')
                                    ? "1st Installment"
                                    : item.installmentList.code.endsWith('2')
                                    ? "2nd Installment"
                                    : "3rd Installment",
                                style: Fontstyle.defult(
                                  18,
                                  FontWeight.w600,
                                  ColorStyle.Textblue,
                                ),
                              ),

                              Row(
                                spacing: 4,
                                children: [
                                  const Icon(
                                    Icons.calendar_month_outlined,
                                    color: ColorStyle.red,
                                    size: 16,
                                  ),
                                  Text(
                                    DateFormat(
                                      'd MMM',
                                    ).format(item.installmentList.deadline),
                                    style: Fontstyle.defult(
                                      16,
                                      FontWeight.w500,
                                      ColorStyle.Textblue,
                                    ),
                                  ),

                                  if (item.isActivate) ...[
                                    Icon(
                                      Icons.brightness_1,
                                      size: 6,
                                      color: ColorStyle.red,
                                    ),
                                    Text(
                                      "${DatetimeStyle.getHybridDate(item.installmentList.deadline)}",
                                      style: Fontstyle.defult(
                                        16,
                                        FontWeight.w500,
                                        ColorStyle.Textblue,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              Row(
                                spacing: 4,
                                children: [
                                  //Text(data),
                                  Text(
                                    amount.toString(),
                                    style: Fontstyle.defult(
                                      16,
                                      FontWeight.w500,
                                      ColorStyle.Textblue,
                                    ),
                                  ),

                                  Icon(
                                    Icons.brightness_1,
                                    size: 6,
                                    color: ColorStyle.red,
                                  ),
                                  Text(
                                    "${DatetimeStyle.getHybridDate(item.installmentList.deadline)}",
                                    style: Fontstyle.defult(
                                      16,
                                      FontWeight.w500,
                                      ColorStyle.Textblue,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),
                            ],
                          ),
                        ),

                        if (item.isActivate)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: ColorStyle.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Active",
                              style: Fontstyle.defult(
                                10,
                                FontWeight.w600,
                                ColorStyle.light,
                              ),
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
}
