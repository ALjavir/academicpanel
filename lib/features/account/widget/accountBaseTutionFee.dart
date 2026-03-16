import 'package:academicpanel/model/AccountSuperModel/row_ac_statement_model.dart';
import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/template/normal/dotLine_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';

class AccountBaseTutionFee extends StatelessWidget {
  final AccountPageModelBaseTutionFee accountPageModelBaseTutionFee;
  const AccountBaseTutionFee({
    super.key,
    required this.accountPageModelBaseTutionFee,
  });

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
                  ImageStyle.fullStatementIcon(),
                  scale: 16,
                  color: ColorStyle.red,
                ),
                Text(
                  "Full Statement",
                  style: Fontstyle.defult(
                    22,
                    FontWeight.w600,
                    ColorStyle.Textblue,
                  ),
                ),
              ],
            ),
            Divider(color: ColorStyle.red),
            showListDue(accountPageModelBaseTutionFee.accountStatementList),
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
                      accountPageModelBaseTutionFee.totalAccountStatementList,
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

  Widget showListDue(List<RowAcStatementModel> accountStatement) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 6),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: accountStatement.length,
      itemBuilder: (context, index) {
        final item = accountStatement[index];

        final showLastDot = index == accountStatement.length - 1;

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
                  spacing: 4,
                  children: [
                    Text(
                      "${item.rowCourseModel.name.capitalizeFirst}",
                      style: Fontstyle.defult(
                        15,
                        FontWeight.w600,
                        ColorStyle.Textblue,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${item.rowCourseModel.code}",
                            style: Fontstyle.defult(
                              12,
                              FontWeight.w500,
                              ColorStyle.lightBlue,
                            ),
                          ),

                          TextSpan(
                            text: " • ",
                            style: Fontstyle.defult(
                              12,
                              FontWeight.w600,
                              ColorStyle.lightRed,
                            ),
                          ),
                          TextSpan(
                            text: item.rowCourseModel.credit == 0.0
                                ? "N/A"
                                : "${item.rowCourseModel.credit} Cr.",
                            style: Fontstyle.defult(
                              12,
                              FontWeight.w500,
                              ColorStyle.lightBlue,
                            ),
                          ),
                        ],
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
