class BikeFilter {
  int minPrice;
  int maxPrice;
  List<String> brands;
  List<int> ccRanges;
  List<int> years;

  BikeFilter({
    required this.minPrice,
    required this.maxPrice,
    required this.brands,
    required this.ccRanges,
    required this.years,
  });
}

