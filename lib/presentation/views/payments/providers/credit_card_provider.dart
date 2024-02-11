import 'package:book_my_movie/utils/common/exports.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CreditCardProvider with ChangeNotifier {
  CreditCardModel? _creditCardModel;

  CreditCardModel? get creditCardModel => _creditCardModel;

  // Method to update credit card details
  void updateCreditCardInfo(CreditCardModel newCreditCardModel) {
    _creditCardModel = newCreditCardModel;
    // notifyListeners();
  }
}
