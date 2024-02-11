import 'package:book_my_movie/utils/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static TextAlign centerTextAlignment = TextAlign.center;
  static TextStyle largerHeadingStyle = TextStyle(
    fontSize: 26.0.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textColor,
  );
  static TextStyle headingStyle = TextStyle(
    fontSize: 20.0.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textColor,
  );
  static TextStyle subHeadingStyle = TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGreyColor,
  );
  static TextStyle boldStyle = TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textColor,
  );
  static TextStyle regularStyle = TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );
  static TextStyle mediumStyle = TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );
  static TextStyle smallTextStyle = TextStyle(
    fontSize: 12.0.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  );
  static TextStyle extraSmallTextStyle = TextStyle(
    fontSize: 8.0.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  );
}
