import 'package:book_my_movie/domain/data_models/movie_booking_model.dart';
import 'package:book_my_movie/domain/repositories/movie_booking_repository.dart';
import 'package:book_my_movie/presentation/views/bookings/providers/search_cinema_and_location_provider.dart';
import 'package:book_my_movie/presentation/views/bookings/providers/seat_provider.dart';
import 'package:book_my_movie/presentation/views/detail/provider/detail_provider.dart';
import 'package:book_my_movie/presentation/widgets/rounded_border_button.dart';
import 'package:book_my_movie/utils/common/alert_dialogs.dart';
import 'package:book_my_movie/utils/common/constants.dart';
import 'package:book_my_movie/utils/common/exports.dart';
import 'package:book_my_movie/utils/helper_functions.dart';
import 'package:book_my_movie/utils/injection_container.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';

import '../providers/credit_card_provider.dart';

class CreditCardFormContainer extends StatelessWidget {
  const CreditCardFormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var creditCardModel =
        Provider.of<CreditCardProvider>(context).creditCardModel;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CreditCardWidget(
            cardNumber: creditCardModel?.cardNumber ?? '',
            expiryDate: creditCardModel?.expiryDate ?? '',
            cardHolderName: creditCardModel?.cardNumber ?? '',
            cvvCode: creditCardModel?.cvvCode ?? '',
            showBackView: false,
            onCreditCardWidgetChange: (p0) {},
          ),
          CreditCardForm(
            formKey: GlobalKey<FormState>(),
            // Required for form validation
            obscureCvv: true,
            obscureNumber: true,
            cardNumber: creditCardModel?.cardNumber ?? '',
            cvvCode: creditCardModel?.cvvCode ?? '',
            isHolderNameVisible: true,
            isCardNumberVisible: true,
            isExpiryDateVisible: true,
            cardHolderName: creditCardModel?.cardHolderName ?? '',
            expiryDate: creditCardModel?.expiryDate ?? '',
            inputConfiguration: const InputConfiguration(
              cardNumberDecoration: InputDecoration(
                labelText: 'Number',
                hintText: 'XXXX XXXX XXXX XXXX',
              ),
              expiryDateDecoration: InputDecoration(
                labelText: 'Expired Date',
                hintText: 'XX/XX',
              ),
              cvvCodeDecoration: InputDecoration(
                labelText: 'CVV',
                hintText: 'XXX',
              ),
              cardHolderDecoration: InputDecoration(
                labelText: 'Card Holder',
              ),
            ),
            onCreditCardModelChange: (CreditCardModel creditCardModel) {
              Provider.of<CreditCardProvider>(context, listen: false)
                  .updateCreditCardInfo(creditCardModel);
            },
          ),
          SizedBox(height: 30.sp),
          RoundedBorderButton(
            text: 'Confirm',
            onPressed: () async {
              var selectedMovie =
                  context.read<DetailProvider>().movieDetailResponseModel;
              var selectedSeat = context.read<SeatProvider>().seats;
              var selectedCinema = context
                  .read<SearchCinemaAndLocationProvider>()
                  .selectedCinema;

              await getIt<MovieBookingRepository>().insertMovieBooking(
                  MovieBookingModel(
                      name: selectedMovie?.title,
                      updatedAt: DateTime.now().toString(),
                      createdAt: DateTime.now().toString(),
                      time: DateTime.now().toString(),
                      ticketNumber: HelperFunctions.generateRandomNumber(),
                      movieId: selectedMovie?.id ?? 0,
                      movieImage:
                          "${Constants.imageInitialPath}${selectedMovie?.posterPath}",
                      seatNumbers: selectedSeat
                          .where((element) => element.isSelected == true)
                          .map((e) => e.seatNumber)
                          .toList(),
                      cinemaId: selectedCinema ?? 0));
              if (context.mounted) {
                AlertDialogs.successAlertDialog(
                    context, "Success", "Booking done!");
              }
            },
          )
        ],
      ),
    );
  }
}
