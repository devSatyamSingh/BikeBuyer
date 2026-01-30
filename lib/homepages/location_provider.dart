import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  String _city = "Select City";

  String get city => _city;

  void setCity(String newCity) {
    _city = newCity;
    notifyListeners();
  }
}
