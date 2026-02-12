import 'package:academicpanel/features/account/widget/accountTopHeader/accountTopHeaderAll.dart';
import 'package:academicpanel/features/account/widget/accountTopHeader/accountTopHeaderTotal.dart';
import 'package:academicpanel/model/pages/account_page_model.dart';
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
      padding: EdgeInsets.fromLTRB(10, 120, 10, 90),
      imagePath: ImageStyle.accountTopBackground(),
      child: Column(
        children: [
          Accounttopheadertotal(
            accountPageModelTopHeader: accountPageModelTopHeader,
          ),
          Accounttopheaderall(
            accountPageModelTopHeader: accountPageModelTopHeader,
          ),
        ],
      ),

      // Stack(
    );
  }
}
