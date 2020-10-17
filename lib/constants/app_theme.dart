import 'package:hackaton_bbva_abi/constants/colors.dart';
import 'package:hackaton_bbva_abi/constants/font_family.dart';

import 'package:flutter/material.dart';

final ThemeData themeData = new ThemeData(
    fontFamily: FontFamily.roboto,
    brightness: Brightness.light,
    primarySwatch: MaterialColor(AppColors.bbvablue[500].value, AppColors.bbvablue),
    primaryColor: AppColors.bbvablue[500],
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.bbvablue[500],
    accentColorBrightness: Brightness.light,
    backgroundColor: Colors.white,
);