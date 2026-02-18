class VehicleModel {
  final int vehicleId;
  final String brandName;
  final String? brandLogo;
  final String model;
  final int year;
  final int price;
  final int kmDriven;
  final String condition;
  final String description;
  final int? engineCC;
  final int? mileage;
  final int numberOfOwners;
  final String? registrationNumber;
  final int? subCategoryId;
  final String? subCategoryName;
  final String? categoryName;
  final List<String> images;

  final String shopName;
  final String city;
  final String state;
  final String dealerName;
  final String dealerEmail;
  final String dealerPhone;

  VehicleModel({
    required this.vehicleId,
    required this.brandName,
    this.brandLogo,
    required this.model,
    required this.year,
    required this.price,
    required this.kmDriven,
    required this.condition,
    required this.description,
    this.engineCC,
    this.mileage,
    required this.numberOfOwners,
    this.registrationNumber,
    this.subCategoryId,
    this.subCategoryName,
    this.categoryName,
    required this.images,
    required this.shopName,
    required this.city,
    required this.state,
    required this.dealerName,
    required this.dealerEmail,
    required this.dealerPhone,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      vehicleId: json['vehicleId'] ?? 0,
      brandName: json['brand']?['name'] ?? "",
      brandLogo: json['brand']?['logo'],
      model: json['model'] ?? "",
      year: json['year'] ?? 0,
      price: json['price'] ?? 0,
      kmDriven: json['kmDriven'] ?? 0,
      condition: json['condition'] ?? "",
      description: json['description'] ?? "",
      engineCC: json['engineCC'],
      mileage: json['mileage'],
      numberOfOwners: json['numberOfOwners'] ?? 0,
      registrationNumber: json['registrationNumber'],
      subCategoryId: json['subCategoryId'],
      subCategoryName: json['subCategory']?['name'],
      categoryName:
      json['subCategory']?['category']?['name'],
      images: (json['images'] as List?)
          ?.map((img) => img['imageUrl'] as String)
          .toList() ??
          [],
      shopName: json['agency']?['shopName'] ?? "",
      city: json['agency']?['city'] ?? "",
      state: json['agency']?['state'] ?? "",
      dealerName: json['agency']?['user']?['name'] ?? "",
      dealerEmail: json['agency']?['user']?['email'] ?? "",
      dealerPhone: json['agency']?['phone'] ?? "",
    );
  }
}
