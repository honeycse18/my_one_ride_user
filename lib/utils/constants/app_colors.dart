import 'package:flutter/material.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';

/// This file contains custom colors used throughout the app
class AppColors {
  static const Color primaryColor = Color(0xFF262626);
  static const Color textFieldInputColor = Color(0xFFEBEDF9);
  static const Color primaryBorderColor = Color(0xFFEBEDF8);
  static const Color secondaryColor = Color(0xFFF79C39);
  static const Color tertiaryColor = Color(0xFF4BCBF9);
  static const Color successColor = Color(0xFF48E98A);
  static const Color alertColor = Color(0xFFFE4651);
  static const Color alertLightColor = Color.fromARGB(255, 248, 126, 134);
  static const Color darkColor = Color(0xFF292B49);
  static const Color dividerColor = Color(0xFFCED7E2);
  static const Color bodyTextColor = Color(0xFF888AA0);
  static const Color lineShapeColor = Color(0xFFEBEDF9);
  static const Color shadeColor1 = Color(0xFFF4F5FA);
  static const Color shadeColor2 = Color(0xFFF7F7FB);
  static const Color mainBg = Color(0xFFF7F7FB);
  static const Color secondaryTextColor = Color(0xFF3D3E4C);
  static const Color lightGreyColor = Color(0xFFE5E4E3);

  static const Color successBackgroundColor = Color(0xFFEEF9E8);
  static const Color alertBackgroundColor = Color(0xFFFFEDED);
  static const Color shimmerBaseColor = Color(0xFFCED7E2);
  static const Color shimmerHighlightColor = AppColors.lineShapeColor;

  /// Custom MaterialColor from Helper function
  static final MaterialColor primaryMaterialColor =
      Helper.generateMaterialColor(AppColors.primaryColor);
}
