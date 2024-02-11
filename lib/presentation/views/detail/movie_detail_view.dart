import 'package:book_my_movie/domain/data_models/movie_detail_response_model.dart';
import 'package:book_my_movie/presentation/views/bookings/cinema_and_location_view.dart';
import 'package:book_my_movie/presentation/views/bookings/providers/search_cinema_and_location_provider.dart';
import 'package:book_my_movie/presentation/views/detail/components/popularity_star_ratings.dart';
import 'package:book_my_movie/presentation/views/detail/provider/detail_provider.dart';
import 'package:book_my_movie/presentation/widgets/carouse_widget.dart';
import 'package:book_my_movie/presentation/widgets/rounded_border_button.dart';
import 'package:book_my_movie/utils/common/constants.dart';
import 'package:book_my_movie/utils/common/exports.dart';
import 'package:book_my_movie/utils/helper_functions.dart';
import 'package:book_my_movie/utils/style/app_colors.dart';
import 'package:provider/provider.dart';

class MovieDetailView extends StatefulWidget {
  final int movieId;
  final String title;

  const MovieDetailView(
      {super.key, required this.movieId, required this.title});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DetailProvider>(context, listen: false).init(widget.movieId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: AppText(
            text: widget.title,
            textStyle: AppStyles.headingStyle,
          )),
      body: Consumer<DetailProvider>(
          builder: (context, manager, child) =>
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CarouselWidget(
                    images: manager.movieImagesResponseModel?.backdrops
                            ?.map((e) =>
                                '${Constants.imageInitialPath}${e.filePath}')
                            .toList() ??
                        []),
                SizedBox(height: 20.sp),
                infoContainer(manager.movieDetailResponseModel, manager)
              ])),
    );
  }

  Widget infoContainer(MovieDetailResponseModel? item, DetailProvider manager) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(text: item?.title ?? '', textStyle: AppStyles.headingStyle),
          SizedBox(height: 10.sp),
          Row(
            children: [
              AppText(
                  text:
                      "In Cinemas From ${HelperFunctions.formatDateTime(item?.releaseDate ?? DateTime.now())}",
                  textStyle: AppStyles.smallTextStyle),
              SizedBox(width: 20.sp),
              Chip(
                label: AppText(
                    text: 'Adult ${item?.adult == false ? 'NA' : "Yes"}'),
                backgroundColor: Colors.amberAccent.shade100,
              ),
            ],
          ),
          SizedBox(height: 10.sp),
          Wrap(
            direction: Axis.horizontal,
            children: [
              if (item?.genres != null)
                for (int i = 0; i < item!.genres!.length; i++)
                  Padding(
                    padding: EdgeInsets.only(left: 6.sp),
                    child: Chip(
                      label: AppText(text: '${item.genres?[i].name}'),
                      backgroundColor: Colors.amberAccent.shade100,
                    ),
                  )
            ],
          ),
          SizedBox(height: 10.sp),
          PopularityStarRating(popularity: item?.popularity ?? 0),
          SizedBox(height: 10.sp),
          AppText(text: "Description", textStyle: AppStyles.headingStyle),
          SizedBox(height: 10.sp),
          AppText(
              text: item?.overview ?? '',
              textStyle: AppStyles.smallTextStyle
                  .copyWith(color: AppColors.greyTextColor),
              maxLines: 5,
              overflow: TextOverflow.ellipsis),
          SizedBox(height: 10.sp),
          Center(
            child: RoundedBorderButton(
                text: 'Watch Trailer',
                isLoading: manager.isTrailerLoading,
                onPressed: () {
                  manager.handleOnTapWatchTrailer(context, widget.movieId);
                },
                backgroundColor: AppColors.redColor),
          ),
          Center(
            child: RoundedBorderButton(
                text: 'Book Now',
                onPressed: () {
                  var cinemaProvider =
                      Provider.of<SearchCinemaAndLocationProvider>(context,
                          listen: false);
                  cinemaProvider.selectedCinema = null;
                  cinemaProvider.selectedLocation = null;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CinemaAndLocationView(selectedMovie: item!),
                      ));
                },
                backgroundColor: AppColors.primaryColor),
          )
        ],
      ),
    );
  }
}
