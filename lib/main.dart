import 'package:book_my_movie/presentation/views/bookings/providers/search_cinema_and_location_provider.dart';
import 'package:book_my_movie/presentation/views/bookings/providers/seat_provider.dart';
import 'package:book_my_movie/presentation/views/home/providers/drawer_provider.dart';
import 'package:book_my_movie/presentation/views/home/providers/home_provider.dart';
import 'package:book_my_movie/utils/injection_container.dart';
import 'package:provider/provider.dart';

import 'presentation/views/detail/provider/detail_provider.dart';
import 'presentation/views/home/home_view.dart';
import 'utils/common/exports.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeProvider()),
          ChangeNotifierProvider(create: (_) => DrawerProvider()),
          ChangeNotifierProvider(create: (_) => DetailProvider()),
          ChangeNotifierProvider(create: (_) => SeatProvider()),
          ChangeNotifierProvider(
              create: (_) => SearchCinemaAndLocationProvider())
        ],
        builder: (context, _) {
          return ScreenUtilInit(
              designSize: const Size(390, 812),
              minTextAdapt: true,
              builder: (context, child) {
                return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: const HomeView(),
                    theme: AppTheme.lightTheme(context));
              });
        });
  }
}
