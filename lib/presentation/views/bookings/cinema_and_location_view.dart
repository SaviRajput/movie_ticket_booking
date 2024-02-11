import 'package:book_my_movie/data/data_source/local/mock_data/cinema_mock_data.dart';
import 'package:book_my_movie/domain/data_models/cinema_model.dart';
import 'package:book_my_movie/domain/data_models/movie_detail_response_model.dart';
import 'package:book_my_movie/presentation/views/bookings/providers/search_cinema_and_location_provider.dart';
import 'package:book_my_movie/presentation/views/bookings/providers/seat_provider.dart';
import 'package:book_my_movie/presentation/views/bookings/seat_selection_view.dart';
import 'package:book_my_movie/presentation/widgets/common_app_bar.dart';
import 'package:book_my_movie/utils/common/exports.dart';
import 'package:book_my_movie/utils/style/app_colors.dart';
import 'package:free_place_search/place_search.dart';
import 'package:provider/provider.dart';

class CinemaAndLocationView extends StatelessWidget {
  final MovieDetailResponseModel selectedMovie;

  const CinemaAndLocationView({super.key, required this.selectedMovie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.elevatedTitleAppBar(selectedMovie.title ?? ''),
      body: Consumer<SearchCinemaAndLocationProvider>(
          builder: (context, manager, child) =>
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
                  child: Row(
                    children: [
                      const Icon(Icons.location_city,
                          color: AppColors.primaryColor),
                      SizedBox(width: 20.sp),
                      GestureDetector(
                        onTap: () {
                          PlaceAutocomplete.show(
                              context: context,
                              onDone: (p0) {
                                manager.selectedLocation = p0.address?.name;
                                Navigator.pop(context);
                              });
                        },
                        child: AppText(
                            text:
                                "${manager.selectedLocation == null ? 'Select Location ' : "Selected Location "}${manager.selectedLocation ?? ''}",
                            textStyle: AppStyles.boldStyle),
                      ),
                    ],
                  ),
                ),
                if (manager.selectedLocation != null) listOfCinemas()
              ])),
    );
  }

  Widget listOfCinemas() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: CinemaMockData.listOfCinemas.length,
        itemBuilder: (context, index) {
          return cinemaItem(CinemaMockData.listOfCinemas[index], context);
        },
      ),
    );
  }

  Widget cinemaItem(CinemaModel item, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
      child: GestureDetector(
        onTap: () {
          Provider.of<SearchCinemaAndLocationProvider>(context, listen: false)
              .selectedCinema = item.id;

          Provider.of<SeatProvider>(context, listen: false).defaultSeats();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SeatSelectionView(),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 80.sp,
                width: 110.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(item.imageUrl), fit: BoxFit.cover)),
              ),
            ),
            SizedBox(width: 30.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                      text: item.name,
                      textStyle: AppStyles.boldStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                  Row(
                    children: [
                      AppText(text: "Ratings ${item.ratings}"),
                      const Icon(
                        Icons.star,
                        color: Colors.amberAccent,
                      )
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
