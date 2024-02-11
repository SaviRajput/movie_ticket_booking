import '../../../../utils/common/exports.dart';

class DrawerProvider with ChangeNotifier {
  int _selectedItemIndex = 0;

  int get selectedItemIndex => _selectedItemIndex;

  // Method to update the selected item index
  void updateSelectedItem(int index) {
    _selectedItemIndex = index;
    notifyListeners();
  }
}
