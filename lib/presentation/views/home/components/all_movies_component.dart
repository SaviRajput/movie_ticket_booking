import 'package:book_my_movie/domain/data_models/upcoming_movies_response_model.dart';
import 'package:book_my_movie/presentation/views/detail/movie_detail_view.dart';
import 'package:book_my_movie/presentation/views/detail/provider/detail_provider.dart';
import 'package:book_my_movie/presentation/views/home/providers/home_provider.dart';
import 'package:book_my_movie/presentation/widgets/rounded_border_button.dart';
import 'package:book_my_movie/utils/common/constants.dart';
import 'package:book_my_movie/utils/common/exports.dart';
import 'package:book_my_movie/utils/helper_functions.dart';
import 'package:book_my_movie/utils/style/app_colors.dart';
import 'package:provider/provider.dart';

class AllMovieComponent extends StatelessWidget {
  const AllMovieComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: AppText(text: "All Movies", textStyle: AppStyles.headingStyle),
        ),
        SizedBox(height: 20.sp),
        Consumer<HomeProvider>(
            builder: (context, manager, child) => manager.isLoading
                ? const Center(child: CircularProgressIndicator())
                : AnimatedList(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.only(right: 20),
                    initialItemCount:
                        manager.moviesResponseModel?.results?.length ?? 0,
                    itemBuilder: (context, index, animation) => movieItem(
                        context,
                        index,
                        animation,
                        manager.moviesResponseModel?.results?[index]),
                    scrollDirection: Axis.vertical)),
      ],
    );
  }

  Widget movieItem(BuildContext context, int index, Animation<double> animation,
      Result? item) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: "${Constants.imageInitialPath}${item?.posterPath}",
              imageBuilder: (context, imageProvider) => Container(
                height: 140.sp,
                width: 95.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: AppColors.primaryColor),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(width: 10.sp),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: item?.title ?? '',
                  textStyle: AppStyles.boldStyle,
                ),
                SizedBox(height: 10.sp),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                        text:
                            "In Cinemas From ${HelperFunctions.formatDateTime(item?.releaseDate ?? DateTime.now())}",
                        textStyle: AppStyles.extraSmallTextStyle
                            .copyWith(fontSize: 10.sp)),
                    SizedBox(width: 20.sp),
                    Chip(
                        label: AppText(
                      text: 'Adult ${item?.adult == false ? 'NA' : 'YES'}',
                      textStyle: AppStyles.extraSmallTextStyle,
                    ))
                  ],
                ),
                SizedBox(height: 10.sp),
                RoundedBorderButton(
                  backgroundColor: Colors.white,
                  borderColor: AppColors.primaryColor,
                  textStyle: AppStyles.regularStyle,
                  borderWidth: 1,
                  text: 'Book Now',
                  onPressed: () {
                    Provider.of<DetailProvider>(context, listen: false)
                        .defaultValue();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MovieDetailView(
                                  title: item?.title ?? '',
                                  movieId: item?.id ?? 0,
                                )));
                  },
                )
              ],
            ),
            SizedBox(height: 30.sp),
          ],
        ),
      ),
    );
  }
}
