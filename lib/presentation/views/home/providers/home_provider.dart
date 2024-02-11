import 'dart:developer';

import 'package:book_my_movie/domain/data_models/upcoming_movies_response_model.dart';
import 'package:book_my_movie/domain/repositories/movies_repository.dart';
import 'package:book_my_movie/utils/common/exports.dart';
import 'package:book_my_movie/utils/injection_container.dart';

class HomeProvider extends ChangeNotifier {
  final _homeRepository = getIt<MoviesRepository>();
  UpcomingMoviesResponseModel? _moviesResponseModel;

  UpcomingMoviesResponseModel? get moviesResponseModel => _moviesResponseModel;
  bool isLoading = false;

  Future<void> getMoviesResponse() async {
    try {
      isLoading = true;
      notifyListeners();
      _moviesResponseModel = await _homeRepository.fetchUpComingMovies();
    } catch (e) {
      log("ERROR FOR DEBUG ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
