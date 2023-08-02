import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_container.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AtmNameContainer extends StatelessWidget {
  final String atmName;

  AtmNameContainer({required this.atmName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomContainer(
          child: SmallText(
            text: atmName,
            color: Colors.black87,
            fontFamily: AppFonts.montserratRegular,
            fontWeight: FontWeight.w700,
            size: 11,
          ),
          alignment: Alignment.center,
          color: kGrey,
          // margin: getMargin(left: 5, right: 5),
          padding: getPadding(left: 6, right: 6),

          isBorderRadius: true,
          isShadow: false,
        ),
        SizedBox(width: 5),
      ],
    );
  }
}
