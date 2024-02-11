import 'dart:io';

import 'package:book_my_movie/utils/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: AppColors.whiteColor,
      platform: TargetPlatform.iOS,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.blackColor),
          systemOverlayStyle: Platform.isAndroid
              ? const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness:
                      Brightness.dark, // For Android (dark icons)
                )
              : null,
          backgroundColor: AppColors.whiteColor),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.textColor,
      ),
      primarySwatch: Colors.blue,
    );
  }
}
