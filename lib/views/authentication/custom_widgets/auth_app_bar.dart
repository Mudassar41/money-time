import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthAppBar extends StatelessWidget {
  final bool isFirstPage;
  AuthAppBar({this.isFirstPage = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height:isFirstPage ? Get.height * 0.08 : Get.height * 0.06),
          Visibility(
            visible: !isFirstPage,
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  splashRadius: 0.1,
                  splashColor: kTransparent,
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: kBlack,
                  )),
            ),
          ),
          CustomImage(
            pathOrUrl: customAssetImage('logo'),
            height: Get.height * 0.1,
          ),
        ],
      ),
    );
  }
}
