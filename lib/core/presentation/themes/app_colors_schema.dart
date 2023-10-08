import 'package:flutter/material.dart';

part 'material_colors.dart';

abstract class AppColorScheme {
  Brightness get brightness;

  Color get primaryColor;

  Color get secondaryColor => const Color(0xffFF8E42);

  Color get whiteColor => Colors.white;

  Color get blackColor => Colors.black;

  Color get darkGreyColor => const Color(0xff202225);

  MaterialColor get greyColor;

  MaterialTextColor get textColor;

  Color get backgroundColor;

  Color get topAndNav;

  Color get placeholderColor;

  Color get cardBackgroundColor;

  Color get iconTintColor;

  Color get infoTextColor;

  Color get errorColor;

  Color get drawerColor;

  Color get shimmerBaseColor;

  Color get shimmerHighlightColor;

  Color get green;
}

class AppLightColors extends AppColorScheme {
  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get primaryColor => const Color(0xff0000CE);

  @override
  MaterialColor get greyColor => const MaterialColor(
        0xFFABADB1,
        <int, Color>{
          5: Color(0xffFBFBFB),
          10: Color(0xffEEEFEE),
          20: Color(0xffE3E5E3),
        },
      );

  @override
  MaterialTextColor get textColor => const MaterialTextColor(
        0xff000000,
        <TextColor, Color>{
          TextColor.adaptiveGrey: Color(0xff7A7A7A),
          TextColor.grey: Color(0xffB9BBBA),
          TextColor.white: Color(0xffFFFFFF),
        },
      );

  @override
  Color get backgroundColor => const Color(0xffF5F5F9);

  @override
  Color get topAndNav => backgroundColor;

  @override
  Color get cardBackgroundColor => const Color(0xffffffff);

  @override
  Color get iconTintColor => const Color(0xff000000);

  @override
  Color get placeholderColor => const Color(0xffabadb1);

  @override
  Color get infoTextColor => const Color(0xff979797);

  @override
  Color get errorColor => const Color(0xfff44336);

  @override
  Color get drawerColor => primaryColor;

  @override
  Color get shimmerBaseColor => const Color(0xFFEEEEEE);

  @override
  Color get shimmerHighlightColor => const Color(0xFFCCCCCC);

  @override
  Color get green => const Color(0xFF14A10F);
}

class AppDarkColors extends AppColorScheme {
  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get primaryColor => const Color(0xff0000CE);

  @override
  MaterialColor get greyColor => const MaterialColor(
        0xFFABADB1,
        <int, Color>{
          50: Color(0xff65676A),
          30: Color(0xff494C4F),
          20: Color(0xff3C3E41),
        },
      );

  @override
  MaterialTextColor get textColor => const MaterialTextColor(
        0xFFFFFFFF,
        <TextColor, Color>{
          TextColor.adaptiveGrey: Color(0xffdedfe0),
          TextColor.grey: Color(0xffABADB1),
          TextColor.white: Color(0xffFFFFFF),
        },
      );

  @override
  Color get backgroundColor => const Color(0xff101315);

  @override
  Color get topAndNav => backgroundColor;

  @override
  Color get cardBackgroundColor => const Color(0xff202225);

  @override
  Color get iconTintColor => const Color(0xffececec);

  @override
  Color get placeholderColor => const Color(0xffa3a3a4);

  @override
  Color get infoTextColor => const Color(0xff979797);

  @override
  Color get errorColor => const Color(0xffc00606);

  @override
  Color get drawerColor => iconTintColor;

  @override
  Color get shimmerBaseColor => const Color(0xFF323232);

  @override
  Color get shimmerHighlightColor => const Color(0xFF1E1E1E);

  @override
  Color get green => const Color(0xFF0B5E08);
}
