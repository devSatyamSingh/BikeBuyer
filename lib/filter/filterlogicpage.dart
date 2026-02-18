import 'filtermodel.dart';
List<Map<String, dynamic>> applyBikeFilters({
  required List<Map<String, dynamic>> bikes,
  required BikeFilter filter,
}) {
  return bikes.where((bike) {
    if (bike["priceValue"] < filter.minPrice ||
        bike["priceValue"] > filter.maxPrice) {
      return false;
    }

    if (filter.brands.isNotEmpty &&
        !filter.brands.contains(bike["brand"])) {
      return false;
    }


    return true;
  }).toList();
}
