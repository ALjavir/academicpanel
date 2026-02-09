// ignore_for_file: deprecated_member_use

import 'package:academicpanel/controller/page/result_page_controller.dart';
import 'package:academicpanel/model/resultSuperModel/row_prev_result.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/template/animation/threed_containel.dart';
import 'package:academicpanel/theme/template/normal/dotLine_template.dart';
import 'package:academicpanel/theme/template/normal/dropdownbutton_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class ResultPrevsem extends StatefulWidget {
  final ResultPageController resultPageController;
  const ResultPrevsem({super.key, required this.resultPageController});

  @override
  State<ResultPrevsem> createState() => _ResultPrevsemState();
}

class _ResultPrevsemState extends State<ResultPrevsem> {
  @override
  Widget build(BuildContext context) {
    if (widget.resultPageController.PrevSemResultData.value == null) {
      return const SizedBox.shrink();
    } else
      return Obx(() {
        final prevSemResultData =
            widget.resultPageController.PrevSemResultData.value!;
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ThreeDContainel(
            padding: EdgeInsets.all(12),
            redious: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  return Row(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        prevSemResultData.prevSemester,
                        style: Fontstyle.defult(
                          22,
                          FontWeight.w600,
                          ColorStyle.Textblue,
                        ),
                      ),

                      DropdownbuttonTemplate(
                        onChanged: (value) async {
                          await widget.resultPageController
                              .fetchPrevSemResultData(value!);
                        },
                        items: widget
                            .resultPageController
                            .PrevSemResultData
                            .value!
                            .listPrevSem,

                        hint: 'Semester',
                      ),
                    ],
                  );
                }),
                Divider(color: ColorStyle.red),

                // 1. Wrap the WHOLE logic in Obx
                if (prevSemResultData.rowPrevResultList.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "No reminder yet!!!",
                        style: Fontstyle.defult(
                          18,
                          FontWeight.w600,
                          ColorStyle.red,
                        ),
                      ),
                    ),
                  )
                else
                  showData(prevSemResultData.rowPrevResultList),
              ],
            ),
          ),
        );
      });
  }

  Widget showData(List<RowPrevResult> rowPrevResultList) {
    if (rowPrevResultList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "No results found",
            style: Fontstyle.defult(18, FontWeight.w600, ColorStyle.red),
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      itemCount: rowPrevResultList.length,

      itemBuilder: (context, index) {
        final rowPrevResult = rowPrevResultList[index];

        final isLast = index == rowPrevResultList.length - 1;

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
                      "${rowPrevResult.rowCourseModel.name.capitalizeFirst}",

                      style: Fontstyle.defult(
                        15,

                        FontWeight.w600,

                        ColorStyle.Textblue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${rowPrevResult.rowCourseModel.code}",

                              style: Fontstyle.defult(
                                12,

                                FontWeight.w500,

                                ColorStyle.Textblue,
                              ),
                            ),

                            TextSpan(
                              text: " • ",

                              style: Fontstyle.defult(
                                12,

                                FontWeight.w600,

                                ColorStyle.red,
                              ),
                            ),

                            TextSpan(
                              text:
                                  "${rowPrevResult.rowCourseModel.credit} Cr.",

                              style: Fontstyle.defult(
                                12,

                                FontWeight.w500,

                                ColorStyle.Textblue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                  rowPrevResult.grade,
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
