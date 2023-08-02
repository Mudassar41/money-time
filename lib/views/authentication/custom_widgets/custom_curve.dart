import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_image.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCurve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
            size: Size(Get.width, (Get.width * 0.7079439252336449).toDouble()),
            painter: RPSCustomPainter()),
        Positioned(
            child: CustomImage(
                pathOrUrl: customAssetImage('logo'), width: Get.width / 3),
            top: getVerticalSize(100),
            left: getHorizontalSize(140)),
        Positioned(
          child: SmallText(
            text: "ATM LOCATOR",
            color: kBlack,
            size: getFontSize(16),
            fontFamily: AppFonts.montserratRegular,
          ),
          top: getVerticalSize(180),
          left: getHorizontalSize(170),
        ),
        Positioned(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LargeText(
                text: "Welcome",
                size: getFontSize(30),
                color: kWhite,
                fontFamily: AppFonts.montserratBold,
              ),
              LargeText(
                text: "Team member",
                size: getFontSize(28),
                color: kWhite,
                fontFamily: AppFonts.montserratBold,
              ),
            ],
          ),
          top: getVerticalSize(220),
          left: getHorizontalSize(20),
        )
      ],
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Color(0xff4CD964).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.3329439, size.height * -0.1402640),
        size.width * 0.8072430, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
