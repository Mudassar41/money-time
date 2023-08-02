import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAppBar extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final Color? backIconColor;
  UserAppBar({this.onBackPressed, this.backIconColor = kWhite});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.1,
      margin: getMargin(top: 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
              onPressed: onBackPressed ??
                  () {
                    Get.back();
                  },
              icon: Icon(Icons.arrow_back),
              color: backIconColor,
              splashRadius: 0.1),
          SizedBox(width: Get.width * 0.26),
          CustomImage(
            pathOrUrl: customAssetImage('logo'),
            height: getSize(60),
            margin: getMargin(bottom: 30),
          ),
        ],
      ),
    );
  }
}
