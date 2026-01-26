import 'package:academicpanel/model/resultSuperModel/row_cgpa_model.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:flutter/material.dart';

class HomeCgpainfo extends StatelessWidget {
  final RowCgpaModel rowCgpaModel;

  const HomeCgpainfo({super.key, required this.rowCgpaModel});

  @override
  Widget build(BuildContext context) {
    final double diff = rowCgpaModel.current_cgpa - rowCgpaModel.pervious_cgpa;
    final bool isPositive = diff >= 0;

    //print("DEBUG: CGPA Diff: $diff, Is Positive: $isPositive");

    final double remaining =
        rowCgpaModel.target_credit - rowCgpaModel.credit_completed;

    return ThreeDContainel(
      hight: MediaQuery.of(context).size.height * 0.25,
      redious: 10,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 0, 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              //spacing: 6,
              children: [
                Image.asset(
                  ImageStyle.growthIcon(),
                  scale: 22,
                  color: ColorStyle.red,
                ),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: " ${rowCgpaModel.current_cgpa}",
                        style: Fontstyle.defult(
                          20,
                          FontWeight.w600,
                          ColorStyle.Textblue,
                        ),
                      ),
                      TextSpan(
                        text: " CGPA",
                        style: Fontstyle.defult(
                          10,
                          FontWeight.w600,
                          ColorStyle.lightBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          isPositive
                              ? Icons.arrow_upward_rounded
                              : Icons.arrow_downward_rounded,
                          color: ColorStyle.red,
                          size: 16,
                        ),
                      ),
                      TextSpan(
                        text:
                            " ${isPositive ? '+' : ''}${diff.toStringAsFixed(2)}",
                        style: Fontstyle.defult(
                          14,
                          isPositive ? FontWeight.bold : FontWeight.w400,
                          isPositive ? ColorStyle.Textblue : ColorStyle.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(color: ColorStyle.red),
          ),
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              final List<String> icon = [
                ImageStyle.enrolledIcon(),
                ImageStyle.remaingIcon(),
                ImageStyle.complitedBookIcon(),
              ];
              final List<String> label = ["Enrolled", "Remaining", "Completed"];
              final List<int> value = [
                rowCgpaModel.credit_enrolled.toInt(),
                remaining.toInt(),
                rowCgpaModel.credit_completed.toInt(),
              ];

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          icon[index],
                          scale: 24,
                          color: ColorStyle.red,
                        ),
                        if (index <= 1)
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              height: 18,
                              width: 2,
                              color: Colors.grey.shade300,
                            ),
                          ),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${label[index]}: ",
                            style: Fontstyle.defult(
                              14,
                              FontWeight.w600,
                              ColorStyle.Textblue,
                            ),
                          ),
                          TextSpan(
                            text: '${value[index]}',
                            style: Fontstyle.defult(
                              14,
                              FontWeight.w600,
                              ColorStyle.red,
                            ),
                          ),
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
    );
  }
}
