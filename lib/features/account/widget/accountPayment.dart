import 'package:academicpanel/model/AccountSuperModel/row_payment_model.dart';
import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/template/normal/dotLine_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';

class AccountPayment extends StatelessWidget {
  final AccountPageModelPayment accountPageModelPayment;
  const AccountPayment({super.key, required this.accountPageModelPayment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ThreeDContainel(
        redious: 10,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              spacing: 4,
              children: [
                Image.asset(
                  ImageStyle.paymentIcon(),
                  scale: 16,
                  color: ColorStyle.red,
                ),
                Text(
                  "Payment",
                  style: Fontstyle.defult(
                    22,
                    FontWeight.w600,
                    ColorStyle.Textblue,
                  ),
                ),
              ],
            ),
            Divider(color: ColorStyle.red),
            showListPayment(accountPageModelPayment.paymentList),
            Divider(color: ColorStyle.red),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: Fontstyle.defult(
                      18,
                      FontWeight.w600,
                      ColorStyle.Textblue,
                    ),
                  ),
                  Text(
                    NumberFormat.decimalPattern().format(
                      accountPageModelPayment.totalPayment,
                    ),
                    style: Fontstyle.defult(
                      18,
                      FontWeight.w600,
                      ColorStyle.Textblue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showListPayment(List<RowPaymentModel> paymentList) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 6),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: paymentList.length,
      itemBuilder: (context, index) {
        final item = paymentList[index];

        final showLastDot = index == paymentList.length - 1;

        return IntrinsicHeight(
          child: Row(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Center(
                    child: Text(
                      DateFormat('d MMM').format(item.createdAt),
                      style: Fontstyle.defult(
                        15,
                        FontWeight.w500,
                        ColorStyle.Textblue,
                      ),
                    ),
                  ),
                ),
              ),
              DotlineTemplate(isLast: false, index: index),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 1,
                  children: [
                    Text(
                      "${item.method.capitalizeFirst}",
                      style: Fontstyle.defult(
                        15,
                        FontWeight.w600,
                        ColorStyle.Textblue,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${item.from}",
                      style: Fontstyle.defult(
                        14,
                        FontWeight.w500,
                        ColorStyle.lightBlue,
                      ),
                    ),
                    Text(
                      item.txid,
                      style: Fontstyle.defult(
                        13,
                        FontWeight.w500,
                        ColorStyle.lightBlue,
                      ),
                    ),

                    if (!showLastDot) const SizedBox(height: 20),
                  ],
                ),
              ),

              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  //color: ColorStyle.light,
                  border: Border.all(color: Colors.black12, width: 1),

                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurStyle: BlurStyle.outer,
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Text(
                  NumberFormat.decimalPattern().format(item.amount),
                  style: Fontstyle.defult(
                    15,
                    FontWeight.w600,
                    ColorStyle.Textblue,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
