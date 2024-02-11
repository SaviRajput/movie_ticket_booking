import 'package:book_my_movie/presentation/views/payments/providers/credit_card_provider.dart';
import 'package:book_my_movie/presentation/widgets/common_app_bar.dart';
import 'package:book_my_movie/utils/common/exports.dart';
import 'package:provider/provider.dart';

import 'components/credit_card_form.dart';

class ConfirmPaymentView extends StatelessWidget {
  const ConfirmPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreditCardProvider(),
      child: Scaffold(
        appBar: CommonAppBar.elevatedTitleAppBar('Confirm Payment'),
        body: const CreditCardFormContainer(),
      ),
    );
  }
}
