import 'package:book_my_movie/presentation/views/bookings/my_bookings_view.dart';
import 'package:book_my_movie/presentation/views/home/providers/drawer_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/common/exports.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerProvider>(
      builder: (context, drawerProvider, child) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SafeArea(
              child: ListTile(
                title: AppText(
                    text: 'Home',
                    textStyle:
                        AppStyles.boldStyle.copyWith(color: Colors.black)),
                selected: drawerProvider.selectedItemIndex == 0,
                onTap: () {
                  drawerProvider.updateSelectedItem(0);
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: AppText(
                  text: 'My Bookings',
                  textStyle: AppStyles.boldStyle.copyWith(color: Colors.black)),
              selected: drawerProvider.selectedItemIndex == 1,
              onTap: () {
                drawerProvider.updateSelectedItem(1);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyBookingView(),
                    ));
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
