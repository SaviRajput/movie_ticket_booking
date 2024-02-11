import 'dart:convert';

import 'package:book_my_movie/data/data_source/remote/network_services.dart';
import 'package:book_my_movie/domain/data_models/movie_detail_response_model.dart';
import 'package:book_my_movie/domain/data_models/movie_images_response_model.dart';
import 'package:book_my_movie/domain/data_models/movies_videos_response_model.dart';
import 'package:book_my_movie/domain/data_models/upcoming_movies_response_model.dart';
import 'package:book_my_movie/utils/common/constants.dart';
import 'package:book_my_movie/utils/injection_container.dart';

class MoviesRepository {
  var networkService = getIt<NetworkServices>();

  Map<String, String> _getHeader() {
    return {
      "Authorization": Constants.authHeader,
    };
  }

  Future<UpcomingMoviesResponseModel?> fetchUpComingMovies() async {
    var response = await networkService.commonGetMethod('/upcoming',
        headers: _getHeader());
    if (response != null) {
      return upcomingMoviesResponseModelFromJson(jsonEncode(response.data));
    }
    return null;
  }

  Future<MovieDetailResponseModel?> fetchMovieDetail(int movieId) async {
    var response = await networkService.commonGetMethod('/$movieId',
        headers: _getHeader());
    if (response != null) {
      return movieDetailResponseModelFromJson(jsonEncode(response.data));
    }
    return null;
  }

  Future<MovieImagesResponseModel?> fetchMovieImages(int movieId) async {
    var response = await networkService.commonGetMethod('/$movieId/images',
        headers: _getHeader());
    if (response != null) {
      return movieImagesResponseModelFromJson(jsonEncode(response.data));
    }
    return null;
  }

  Future<MovieVideosResponseModel?> fetchMovieVideos(int movieId) async {
    var response = await networkService.commonGetMethod('/$movieId/videos',
        headers: _getHeader());
    if (response != null) {
      return movieVideosResponseModelFromJson(jsonEncode(response.data));
    }
    return null;
  }
}
