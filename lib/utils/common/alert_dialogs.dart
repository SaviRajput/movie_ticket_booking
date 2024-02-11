import 'package:book_my_movie/presentation/views/home/home_view.dart';
import 'package:book_my_movie/presentation/widgets/rounded_border_button.dart';

import 'exports.dart';

class AlertDialogs {
  static successAlertDialog(
    BuildContext context,
    String? message,
    String? subMessage, {
    void Function()? onPressed,
    bool? tapOutsideBox,
    double verticalPadding = 0,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: tapOutsideBox ?? false,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Icon(Icons.check_circle, size: 50.sp),
            SizedBox(height: 20.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 38.sp),
              child: Text(
                message!,
                textAlign: TextAlign.center,
                style: AppStyles.headingStyle,
              ),
            ),
            SizedBox(height: 20.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.sp),
              child: Text(
                subMessage!,
                textAlign: TextAlign.center,
                style: AppStyles.subHeadingStyle,
              ),
            ),
            SizedBox(height: 20.sp),
          ]),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: verticalPadding.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RoundedBorderButton(
                    text: 'ok',
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                          (route) => false);
                    },
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
