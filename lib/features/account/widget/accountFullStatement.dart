import 'package:academicpanel/model/AccountSuperModel/row_ac_statement_model.dart';
import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/template/normal/dotLine_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:intl/intl.dart';

class Accountfullstatement extends StatelessWidget {
  final AccountPageModelFullStatement accountPageModelFullStatement;
  const Accountfullstatement({
    super.key,
    required this.accountPageModelFullStatement,
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
            showListDue(accountPageModelFullStatement.accountStatementList),
          ],
        ),
      ),
    );
  }

  Widget showListDue(List<RowAcStatementModel> accountStatement) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: accountStatement.length,
      itemBuilder: (context, index) {
        final item = accountStatement[index];
        final isLast = index == accountStatement.length - 1;

        return IntrinsicHeight(
          child: Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DotlineTemplate(isLast: isLast, index: index),
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
                    Text(
                      DateFormat('d MMM').format(item.createdAt),
                      style: Fontstyle.defult(
                        15,
                        FontWeight.w500,
                        ColorStyle.lightBlue,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 24),
                    //   child: RichText(
                    //     text: TextSpan(
                    //       children: [
                    //         TextSpan(
                    //           text: "${item.rowCourseModel.code}",
                    //           style: Fontstyle.defult(
                    //             12,
                    //             FontWeight.w500,
                    //             ColorStyle.Textblue,
                    //           ),
                    //         ),
                    //         if(item.rowCourseModel.credit != 0)...[
                    //         TextSpan(
                    //           text: " • ",
                    //           style: Fontstyle.defult(
                    //             12,
                    //             FontWeight.w600,
                    //             ColorStyle.red,
                    //           ),
                    //         ),
                    //         TextSpan(
                    //           text: "${item.rowCourseModel.credit} Cr.",
                    //           style: Fontstyle.defult(
                    //             12,
                    //             FontWeight.w500,
                    //             ColorStyle.Textblue,
                    //           ),
                    //         ),]
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(10),
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
                  item.amount.toString(),
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
