class BrandModel {
  final int brandId;
  final String name;
  final String? logo;

  BrandModel({
    required this.brandId,
    required this.name,
    this.logo,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      brandId: json["brandId"],
      name: json["name"],
      logo: json["logo"],
    );
  }
}
