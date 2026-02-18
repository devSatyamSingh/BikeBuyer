import 'package:flutter/material.dart';
import '../modal/vehicalmodel.dart';
import '../homepages/vehicalservice.dart';

class VehicleProvider extends ChangeNotifier {

  bool isLoading = false;
  List<VehicleModel> vehicles = [];

  Future<void> fetchVehicles({
    String? category,
    String? search,
  }) async {

    isLoading = true;
    notifyListeners();

    try {
      vehicles = await VehicleService.fetchVehicles(
        category: category,
        search: search,
      );
    } catch (e) {
      vehicles = [];
    }

    isLoading = false;
    notifyListeners();
  }
}