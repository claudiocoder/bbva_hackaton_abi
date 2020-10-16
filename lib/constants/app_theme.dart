import 'package:hackaton_bbva_abi/constants/colors.dart';
import 'package:hackaton_bbva_abi/constants/font_family.dart';

import 'package:flutter/material.dart';

final ThemeData themeData = new ThemeData(
    fontFamily: FontFamily.roboto,
    brightness: Brightness.light,
    primarySwatch: MaterialColor(AppColors.orange[500].value, AppColors.orange),
    primaryColor: AppColors.orange[500],
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.orange[500],
    accentColorBrightness: Brightness.light
);

final ThemeData themeDataDark = ThemeData(
  fontFamily: FontFamily.roboto,
  brightness: Brightness.dark,
  primaryColor: AppColors.orange[500],
  primaryColorBrightness: Brightness.dark,
  accentColor: AppColors.orange[500],
  accentColorBrightness: Brightness.dark,
);