import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/font_details.dart';

ThemeData appTheme() {
  return ThemeData(
      primaryColor: AppColors.mainColor,
      hintColor: AppColors.hintColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: FontDetails.fontFamilyName,
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontWeight: FontDetails.boldFontWeight,
            color: AppColors.mainColor,
            fontSize: FontDetails.fontSizeXL),
        displayMedium: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: AppColors.mainColor,
            fontSize: FontDetails.fontSizeM),
        displaySmall: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: AppColors.mainColor,
            fontSize: FontDetails.fontSizeS),

        ///-----------------
        headlineLarge: TextStyle(
            fontWeight: FontDetails.boldFontWeight,
            color: AppColors.white,
            fontSize: FontDetails.fontSizeL),
        headlineMedium: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: AppColors.white,
            fontSize: FontDetails.fontSizeM),
        headlineSmall: TextStyle(
            fontWeight: FontDetails.regularFontWeight,
            color: AppColors.white,
            fontSize: FontDetails.fontSizeXS),

        ///-----------------
        titleSmall: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: AppColors.black,
            fontSize: FontDetails.fontSizeXS),
        titleMedium: TextStyle(
            fontWeight: FontDetails.semiBoldFontWeight,
            color: AppColors.black,
            fontSize: FontDetails.fontSizeM),
        titleLarge: TextStyle(
            fontWeight: FontDetails.semiBoldFontWeight,
            color: AppColors.black,
            fontSize: FontDetails.fontSizeL),

        ///-----------------
        // labelSmall: ,
        // labelMedium: ,
        // labelLarge: ,

        ///-----------------
        bodySmall: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: AppColors.mainTextColor,
            fontSize: FontDetails.fontSizeXS),
        bodyMedium: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: AppColors.mainTextColor,
            fontSize: FontDetails.fontSizeM),
        bodyLarge: TextStyle(
            fontWeight: FontDetails.mediumFontWeight,
            color: AppColors.mainTextColor,
            fontSize: FontDetails.fontSizeL),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.mainColor),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r))),
          textStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontWeight: FontDetails.mediumFontWeight,
              fontSize: FontDetails.fontSizeM,
              color: AppColors.white,
            ),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.mainColor),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.r))),
          textStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontWeight: FontDetails.mediumFontWeight,
              fontSize: FontDetails.fontSizeM,
              color: AppColors.white,
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.r))),
          textStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontWeight: FontDetails.mediumFontWeight,
              fontSize: FontDetails.fontSizeM,
              color: AppColors.mainColor,
            ),
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.r))),
      ));
}
