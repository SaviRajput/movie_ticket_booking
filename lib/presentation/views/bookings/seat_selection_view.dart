import 'package:book_my_movie/presentation/views/bookings/components/seat_grid.dart';
import 'package:book_my_movie/presentation/views/payments/confirm_payment_view.dart';
import 'package:book_my_movie/presentation/widgets/common_app_bar.dart';
import 'package:book_my_movie/presentation/widgets/rounded_border_button.dart';

import '../../../utils/common/exports.dart';

class SeatSelectionView extends StatelessWidget {
  const SeatSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.elevatedTitleAppBar('Select Seat'),
      body: Column(
        children: [
          SizedBox(
            height: 20.sp,
          ),
          const Expanded(flex: 4, child: SeatGrid()),
          RoundedBorderButton(
            text: 'Book',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConfirmPaymentView(),
                  ));
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
