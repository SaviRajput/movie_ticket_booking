import 'package:book_my_movie/domain/data_models/seat_model.dart';
import 'package:flutter/material.dart';

class SeatProvider with ChangeNotifier {
  List<SeatModel> _seats = List.generate(30,
      (index) => SeatModel(seatNumber: 'Seat ${index + 1}', isSelected: false));

  List<SeatModel> get seats => _seats;

  void toggleSeatSelection(int index) {
    _seats[index].isSelected = !_seats[index].isSelected;
    notifyListeners();
  }

  void defaultSeats() {
    _seats = List.generate(
        30,
        (index) =>
            SeatModel(seatNumber: 'Seat ${index + 1}', isSelected: false));
  }
}
