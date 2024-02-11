import 'package:flutter/material.dart';

class SearchCinemaAndLocationProvider extends ChangeNotifier {
  String? _selectedLocation;
  int? _selectedCinema;

  // Getter for selectedLocation
  String? get selectedLocation => _selectedLocation;

  // Setter for selectedLocation
  set selectedLocation(String? location) {
    _selectedLocation = location;
    notifyListeners();
  }

  // Getter for selectedCinema
  int? get selectedCinema => _selectedCinema;

  // Setter for selectedCinema
  set selectedCinema(int? cinema) {
    _selectedCinema = cinema;
    notifyListeners();
  }
}
