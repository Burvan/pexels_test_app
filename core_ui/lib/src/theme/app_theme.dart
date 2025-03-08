import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      focusColor: AppColors.turquoise,
      secondaryHeaderColor: AppColors.turquoiseWithOpacity,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.turquoise,
        titleTextStyle: AppTextTheme.font21Bold,
        iconTheme: IconThemeData(color: AppColors.white),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.turquoise,
        circularTrackColor: AppColors.white,
      ),
      cardTheme: CardTheme(
        elevation: AppSize.size4,
        shadowColor: AppColors.turquoise,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.turquoise,
            width: AppSize.size2,
          ),
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.only(left: AppPadding.padding20),
        labelStyle: AppTextTheme.font16.copyWith(
          color: AppColors.darkGrey,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.lightGrey,
            width: AppSize.size2,
          ),
          borderRadius: BorderRadius.circular(
            AppBorderRadius.borderRadius30,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.turquoise,
            width: AppSize.size2,
          ),
          borderRadius: BorderRadius.circular(
            AppBorderRadius.borderRadius30,
          ),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.turquoise,
        selectionColor: AppColors.turquoise,
        selectionHandleColor: AppColors.turquoise,
      ),
      switchTheme: const SwitchThemeData(
        trackColor: WidgetStatePropertyAll(AppColors.white),
        thumbColor: WidgetStatePropertyAll(AppColors.turquoise),
        trackOutlineColor: WidgetStatePropertyAll(AppColors.turquoise),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      focusColor: AppColors.darkGrey,
      secondaryHeaderColor: AppColors.darkGrey,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.black,
        titleTextStyle: AppTextTheme.font21Bold.copyWith(
          color: AppColors.white,
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.turquoise,
        circularTrackColor: AppColors.white,
      ),
      cardTheme: CardTheme(
        elevation: AppSize.size4,
        shadowColor: AppColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.white,
            width: AppSize.size2,
          ),
          borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.only(left: AppPadding.padding20),
        labelStyle: AppTextTheme.font16.copyWith(
          color: AppColors.lightGrey,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.lightGrey,
            width: AppSize.size2,
          ),
          borderRadius: BorderRadius.circular(
            AppBorderRadius.borderRadius30,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.white,
            width: AppSize.size2,
          ),
          borderRadius: BorderRadius.circular(
            AppBorderRadius.borderRadius30,
          ),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.lightGrey,
        selectionColor: AppColors.lightGrey,
        selectionHandleColor: AppColors.lightGrey,
      ),
      switchTheme: const SwitchThemeData(
        trackColor: WidgetStatePropertyAll(AppColors.turquoise),
        thumbColor: WidgetStatePropertyAll(AppColors.white),
      ),
    );
  }
}
