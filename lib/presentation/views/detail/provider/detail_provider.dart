import 'dart:developer';

import 'package:book_my_movie/domain/data_models/movie_detail_response_model.dart';
import 'package:book_my_movie/domain/data_models/movie_images_response_model.dart';
import 'package:book_my_movie/domain/data_models/movies_videos_response_model.dart';
import 'package:book_my_movie/domain/repositories/movies_repository.dart';
import 'package:book_my_movie/utils/common/exports.dart';
import 'package:book_my_movie/utils/injection_container.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailProvider extends ChangeNotifier {
  final _homeRepository = getIt<MoviesRepository>();
  MovieDetailResponseModel? _movieDetailResponseModel;

  MovieDetailResponseModel? get movieDetailResponseModel =>
      _movieDetailResponseModel;
  MovieImagesResponseModel? _movieImagesResponseModel;

  MovieImagesResponseModel? get movieImagesResponseModel =>
      _movieImagesResponseModel;

  MovieVideosResponseModel? _movieVideosResponseModel;

  MovieVideosResponseModel? get movieVideosResponseModel =>
      _movieVideosResponseModel;
  bool isLoading = false;
  bool isMovieImagesLoading = false;
  bool isTrailerLoading = false;

  Future<void> getMovieDetail(int movieId) async {
    try {
      isLoading = true;
      notifyListeners();
      _movieDetailResponseModel =
          await _homeRepository.fetchMovieDetail(movieId);
    } catch (e) {
      log("ERROR in MOVIE details : ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getMovieImages(int movieId) async {
    try {
      isMovieImagesLoading = true;
      notifyListeners();
      _movieImagesResponseModel =
          await _homeRepository.fetchMovieImages(movieId);
    } catch (e) {
      log("ERROR in MOVIE Images : ${e.toString()}");
    } finally {
      isMovieImagesLoading = false;
      notifyListeners();
    }
  }

  void init(int movieId) {
    getMovieDetail(movieId);
    getMovieImages(movieId);
  }

  void handleOnTapWatchTrailer(BuildContext context, int movieId) async {
    try {
      isTrailerLoading = true;
      notifyListeners();
      _movieVideosResponseModel ??=
          await _homeRepository.fetchMovieVideos(movieId);
      if (context.mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => YoutubePlayer(
                  onEnded: (metaData) {
                    Navigator.pop(context);
                  },
                  topActions: [
                    SafeArea(
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    )
                  ],
                  controller: YoutubePlayerController(
                      initialVideoId:
                          _movieVideosResponseModel?.results?.first.key ?? '')),
            ));
      }
    } catch (e) {
      log("ERROR in MOVIE videos : ${e.toString()}");
    } finally {
      isTrailerLoading = false;
      notifyListeners();
    }
  }

  void defaultValue() {
    _movieVideosResponseModel = null;
    _movieImagesResponseModel = null;
    _movieDetailResponseModel = null;
  }
}
