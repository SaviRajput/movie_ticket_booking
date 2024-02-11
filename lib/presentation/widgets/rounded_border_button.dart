import 'package:book_my_movie/utils/common/exports.dart';
import 'package:book_my_movie/utils/style/app_colors.dart';

class RoundedBorderButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;
  final TextStyle? textStyle;
  final bool isLoading;

  const RoundedBorderButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor,
      this.borderColor,
      this.isLoading = false,
      this.borderRadius,
      this.borderWidth,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.sp),
          side: BorderSide(
              color: borderColor ?? backgroundColor ?? AppColors.primaryColor,
              width: borderWidth ?? 2),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0.sp, horizontal: 10.0.sp),
        child: isLoading
            ? const SizedBox(
                height: 15,
                width: 15,
                child: Center(child: CircularProgressIndicator()))
            : AppText(
                text: text,
                textStyle: textStyle ??
                    AppStyles.mediumStyle.copyWith(color: Colors.white),
              ),
      ),
    );
  }
}
