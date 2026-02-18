import 'dart:convert';
import 'package:bikebuyer/modal/vehicalmodel.dart';
import 'package:http/http.dart' as http;

class VehicleService {
  static const String baseUrl =
      "https://api.bikesbuyer.com/api/buyer/vehicles";

  static Future<List<VehicleModel>> fetchVehicles({
    String? category,
    String? subCategoryName,
    String? search,
  }) async {
    Uri uri = Uri.parse(baseUrl).replace(
      queryParameters: {
        if (category != null && category.isNotEmpty)
          "category": category,
        if (subCategoryName != null &&
            subCategoryName.isNotEmpty)
          "subCategoryName": subCategoryName,
        if (search != null && search.isNotEmpty)
          "search": search,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List vehiclesJson = data['vehicles'];

      return vehiclesJson
          .map((json) => VehicleModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load vehicles");
    }
  }
}
