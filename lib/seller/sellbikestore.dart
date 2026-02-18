import 'package:bikebuyer/modal/sellbikemodel.dart';


class SellBikeStore {
  static final List<SellBikeModel> mySellBikes = [];

  static void addBike(SellBikeModel bike) {
    mySellBikes.insert(0, bike);
  }

  static void deleteBike(String id) {
    mySellBikes.removeWhere((b) => b.id == id);
  }
}
