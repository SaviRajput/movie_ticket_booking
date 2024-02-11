import '../../utils/common/exports.dart';

class CommonAppBar {
  static PreferredSizeWidget appBar(String title) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      actions: [const Icon(Icons.notifications), SizedBox(width: 10.sp)],
      title: AppText(text: title, textStyle: AppStyles.headingStyle),
    );
  }

  static PreferredSizeWidget elevatedTitleAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 5,
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: AppText(text: title, textStyle: AppStyles.headingStyle),
    );
  }
}
