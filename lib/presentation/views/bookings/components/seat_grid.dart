import 'package:book_my_movie/domain/data_models/seat_model.dart';
import 'package:book_my_movie/utils/common/exports.dart';
import 'package:book_my_movie/utils/style/app_colors.dart';
import 'package:provider/provider.dart';

import '../providers/seat_provider.dart';

class SeatGrid extends StatelessWidget {
  const SeatGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<SeatModel> seats = Provider.of<SeatProvider>(context).seats;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: GridView.builder(
        itemCount: seats.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Provider.of<SeatProvider>(context, listen: false)
                  .toggleSeatSelection(index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: seats[index].isSelected
                    ? AppColors.primaryColor
                    : AppColors.greyTextColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: AppText(
                text: seats[index].seatNumber,
                textStyle: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
