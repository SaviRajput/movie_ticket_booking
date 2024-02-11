import 'package:book_my_movie/domain/data_models/movie_booking_model.dart';
import 'package:book_my_movie/domain/repositories/movie_booking_repository.dart';
import 'package:book_my_movie/presentation/widgets/common_app_bar.dart';
import 'package:book_my_movie/utils/common/exports.dart';
import 'package:book_my_movie/utils/injection_container.dart';
import 'package:book_my_movie/utils/style/app_colors.dart';

class MyBookingView extends StatelessWidget {
  const MyBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.elevatedTitleAppBar('My Bookings'),
      body: FutureBuilder<List<MovieBookingModel>?>(
        future: getIt<MovieBookingRepository>().getAllMovieBookings(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Container()
              : snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return bookingItem(snapshot.data![index], context);
                      },
                    );
        },
      ),
    );
  }

  Widget bookingItem(MovieBookingModel item, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.greyTextColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 140.sp,
                width: 110.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(item.movieImage ?? ''),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(width: 30.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                      text: item.name ?? '',
                      textStyle: AppStyles.boldStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                  Row(
                    children: [
                      const AppText(text: "Ticket Number"),
                      SizedBox(width: 20.sp),
                      AppText(
                          text: "${item.ticketNumber}",
                          textStyle: AppStyles.boldStyle
                              .copyWith(color: AppColors.secondaryColor)),
                    ],
                  ),
                  AppText(text: "${item.seatNumbers?.join(', ')}"),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
