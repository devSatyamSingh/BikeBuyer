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

    if (filter.ccRanges.isNotEmpty &&
        !filter.ccRanges.any((cc) => bike["ccValue"] <= cc)) {
      return false;
    }

    if (filter.years.isNotEmpty &&
        !filter.years.contains(bike["year"])) {
      return false;
    }

    return true;
  }).toList();
}
