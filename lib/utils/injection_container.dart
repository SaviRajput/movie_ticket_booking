import 'package:book_my_movie/data/data_source/local/database_services.dart';
import 'package:book_my_movie/data/data_source/remote/network_services.dart';
import 'package:book_my_movie/domain/repositories/movie_booking_repository.dart';
import 'package:book_my_movie/domain/repositories/movies_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupInjection() {
  getIt.registerSingleton<DatabaseServices>(DatabaseServices());
  getIt.registerSingleton<NetworkServices>(NetworkServices());
  getIt.registerSingleton<MoviesRepository>(MoviesRepository());
  getIt.registerSingleton<MovieBookingRepository>(MovieBookingRepository());
}
