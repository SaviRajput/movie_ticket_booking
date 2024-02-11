import 'package:book_my_movie/domain/data_models/upcoming_movies_response_model.dart';
import 'package:book_my_movie/presentation/views/detail/movie_detail_view.dart';
import 'package:book_my_movie/presentation/views/detail/provider/detail_provider.dart';
import 'package:book_my_movie/presentation/views/home/providers/home_provider.dart';
import 'package:book_my_movie/utils/common/constants.dart';
import 'package:book_my_movie/utils/common/exports.dart';
import 'package:book_my_movie/utils/helper_functions.dart';
import 'package:book_my_movie/utils/style/app_colors.dart';
import 'package:provider/provider.dart';

class NowShowingComponent extends StatelessWidget {
  const NowShowingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.sp),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child:
              AppText(text: "Now Showing", textStyle: AppStyles.headingStyle),
        ),
        SizedBox(height: 20.sp),
        SizedBox(
          height: .36.sh,
          child: Consumer<HomeProvider>(
            builder: (context, manager, child) {
              return manager.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AnimatedList(
                      padding: const EdgeInsets.only(right: 20),
                      initialItemCount:
                          manager.moviesResponseModel?.results?.length ?? 0,
                      itemBuilder: (context, index, animation) => movieItem(
                          index,
                          manager.moviesResponseModel?.results?[index],
                          animation,
                          context),
                      scrollDirection: Axis.horizontal);
            },
          ),
        ),
      ],
    );
  }

  Widget movieItem(int index, Result? item, Animation<double> animation,
      BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<DetailProvider>(context, listen: false).defaultValue();

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailView(
                  movieId: item?.id ?? 0, title: item?.title ?? ''),
            ));
      },
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        ).animate(animation),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            width: 145.sp,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: "${Constants.imageInitialPath}${item?.posterPath}",
                  imageBuilder: (context, imageProvider) => Container(
                    height: .24.sh,
                    width: 135.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: AppColors.primaryColor),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                SizedBox(height: 5.sp),
                AppText(
                  text: item?.title ?? '',
                  textStyle: AppStyles.regularStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10.sp),
                timeAndAdultChip(
                    HelperFunctions.formatDateTime(
                        item?.releaseDate ?? DateTime.now()),
                    item?.adult ?? false),
                SizedBox(height: 10.sp)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget timeAndAdultChip(String time, bool adult) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(text: time, textStyle: AppStyles.extraSmallTextStyle),
        SizedBox(width: 10.sp),
        Chip(
            label: AppText(
          text: 'Adult ${adult == false ? 'NA' : 'YES'}',
          textStyle: AppStyles.extraSmallTextStyle,
        ))
      ],
    );
  }
}
