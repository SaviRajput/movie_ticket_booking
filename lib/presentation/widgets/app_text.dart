// Eliminating using Textstyle Multiple Times
import 'package:book_my_movie/utils/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final Color? color;
  final FontWeight? fontWeight;
  final double? size;
  final List<Shadow>? shadows;
  final TextStyle? textStyle;

  const AppText(
      {super.key,
      required this.text,
      this.textAlign,
      this.textStyle,
      this.textDirection,
      this.maxLines,
      this.softWrap,
      this.overflow,
      this.color,
      this.fontWeight,
      this.size,
      this.shadows});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ??
          TextStyle(
              color: color ?? AppColors.blackColor,
              fontWeight: fontWeight ?? FontWeight.w400,
              fontSize: size?.sp,
              shadows: shadows,
              overflow: overflow),
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
