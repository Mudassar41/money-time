import 'package:atm_tracker/utils/theme/app_fonts.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(

      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      scaffoldBackgroundColor: kWhite,
      primarySwatch: GetMaterialColor.color(kWhite));

  static final ThemeData darkTheme = ThemeData();
}

class AppStyle {
  static TextStyle get normal => const TextStyle(
        fontFamily: AppFonts.montserratRegular,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get medium =>
      const TextStyle(fontFamily: 'Alata', fontWeight: FontWeight.w600);

  static TextStyle get large => const TextStyle(
      fontSize: 20, fontFamily: 'Alata', fontWeight: FontWeight.w600);

  static TextStyle get extraLarge => const TextStyle(
      fontSize: 24, fontFamily: 'Alata', fontWeight: FontWeight.w600);
}
