import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../modal/vehicalmodel.dart';

class WishlistService {

  static Future<String?> _getUserKey() async {
    final prefs = await SharedPreferences.getInstance();
    String? userPhone = prefs.getString("userPhone");

    if (userPhone == null) return null;

    return "wishlist_$userPhone"; // 🔥 user specific key
  }

  static Future<List<VehicleModel>> getWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getUserKey();

    if (key == null) return [];

    final String? data = prefs.getString(key);

    if (data == null) return [];

    List decoded = jsonDecode(data);

    return decoded.map((item) => VehicleModel.fromJson(item)).toList();
  }

  static Future<void> addToWishlist(VehicleModel bike) async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getUserKey();

    if (key == null) return;

    List<VehicleModel> current = await getWishlist();

    if (current.any((item) => item.vehicleId == bike.vehicleId)) return;

    current.add(bike);

    await prefs.setString(
      key,
      jsonEncode(current.map((e) => _toJson(e)).toList()),
    );
  }

  static Future<void> removeFromWishlist(int vehicleId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getUserKey();

    if (key == null) return;

    List<VehicleModel> current = await getWishlist();

    current.removeWhere((item) => item.vehicleId == vehicleId);

    await prefs.setString(
      key,
      jsonEncode(current.map((e) => _toJson(e)).toList()),
    );
  }

  static Future<void> clearWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getUserKey();

    if (key == null) return;

    await prefs.remove(key);
  }

  static Future<bool> isInWishlist(int vehicleId) async {
    List<VehicleModel> current = await getWishlist();
    return current.any((item) => item.vehicleId == vehicleId);
  }

  static Map<String, dynamic> _toJson(VehicleModel bike) {
    return {
      "vehicleId": bike.vehicleId,
      "brand": {"name": bike.brandName},
      "model": bike.model,
      "year": bike.year,
      "price": bike.price,
      "kmDriven": bike.kmDriven,
      "condition": bike.condition,
      "description": bike.description,
      "engineCC": bike.engineCC,
      "mileage": bike.mileage,
      "numberOfOwners": bike.numberOfOwners,
      "registrationNumber": bike.registrationNumber,
      "images": bike.images.map((e) => {"imageUrl": e}).toList(),
      "agency": {
        "shopName": bike.shopName,
        "city": bike.city,
        "state": bike.state,
        "phone": bike.dealerPhone,
        "user": {
          "name": bike.dealerName,
          "email": bike.dealerEmail
        }
      }
    };
  }
}
