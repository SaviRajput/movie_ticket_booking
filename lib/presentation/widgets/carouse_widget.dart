import 'package:book_my_movie/utils/common/exports.dart';
import 'package:book_my_movie/utils/style/app_colors.dart';
import 'package:provider/provider.dart';

class CarouselWidget extends StatelessWidget {
  final List<String> images;

  const CarouselWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CarouselNotifier>(
      create: (_) => CarouselNotifier(),
      child: Consumer<CarouselNotifier>(
        builder: (context, carouselNotifier, _) {
          return SizedBox(
            height: .3.sh,
            width: 1.sw,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: images.length < 5 ? images.length : 5,
                    onPageChanged: (index) {
                      carouselNotifier.setCurrentPage(index);
                    },
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: images[index],
                        fit: BoxFit.contain,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length < 5 ? images.length : 5,
                      (index) {
                    return Consumer<CarouselNotifier>(
                      builder: (context, carouselNotifier, _) {
                        return Container(
                          width: 10.sp,
                          height: 10.sp,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: carouselNotifier.currentPage == index
                                ? AppColors.primaryColor
                                : AppColors.greyTextColor,
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CarouselNotifier with ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void setCurrentPage(int index) {
    _currentPage = index;
    notifyListeners();
  }
}
