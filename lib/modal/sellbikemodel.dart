import 'dart:io';

class SellBikeModel {
  final String id;
  final String brand;
  final String model;
  final String price;
  final String status; // Pending / Approved / Rejected
  final DateTime date;
  final List<File> images;

  SellBikeModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.price,
    required this.status,
    required this.date,
    required this.images,
  });
}
