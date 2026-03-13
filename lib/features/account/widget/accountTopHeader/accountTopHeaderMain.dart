import 'package:academicpanel/features/account/widget/accountTopHeader/accountTopHeaderAll.dart';
import 'package:academicpanel/features/account/widget/accountTopHeader/accountTopHeaderTotal.dart';
import 'package:academicpanel/model/pages/account_page_model.dart';
import 'package:academicpanel/theme/style/color_style.dart';
import 'package:academicpanel/theme/style/dateTime_style.dart';
import 'package:academicpanel/theme/style/font_style.dart';
import 'package:academicpanel/theme/style/image_style.dart';
import 'package:academicpanel/theme/template/animation/threeD_containerHead.dart';
import 'package:flutter/material.dart';

class Accounttopheadermain extends StatelessWidget {
  final AccountPageModelTopHeader accountPageModelTopHeader;
  const Accounttopheadermain({
    super.key,
    required this.accountPageModelTopHeader,
  });

  @override
  Widget build(BuildContext context) {
    return ThreedContainerhead(
      padding: EdgeInsets.fromLTRB(10, 40, 10, 30),
      imagePath: ImageStyle.accountTopBackground(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15,
        children: [
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
          const SizedBox(height: 2),
          Accounttopheadertotal(
            accountPageModelTopHeader: accountPageModelTopHeader,
          ),
          const Divider(color: Colors.grey, height: 1),

          Accounttopheaderall(
            accountPageModelTopHeader: accountPageModelTopHeader,
          ),
        ],
      ),

      // Stack(
    );
  }
}
