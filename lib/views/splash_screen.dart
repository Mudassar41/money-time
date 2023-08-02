import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/custom_image.dart';

class SplashScreen extends StatelessWidget {
  static String get route => '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
      Center(
        child: CustomImage(
          width: Get.width * 0.65,
          pathOrUrl: customAssetImage('logo'),
        ),
      ),
      Positioned(
        top: Get.height * 0.56,
        left: Get.width * 0.65,
        child: LargeText(
          text: "JAMAICA",
          size: getFontSize(18),
        ),
      ),
        ],
      ),
    );
  }
}
