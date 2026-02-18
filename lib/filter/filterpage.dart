import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:provider/provider.dart';
import '../homepages/location_provider.dart';
import '../modal/vehicalmodel.dart';
import '../widget/locationbottomsheet.dart';
import 'filterbikespage.dart';
import 'filterlogicpage.dart';
import 'filtermodel.dart';
import '../main.dart';

enum FilterSection { budget, brand, city}

class FilterPage extends StatefulWidget {
  final List<VehicleModel> allBikes;

  const FilterPage({super.key, required this.allBikes});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> with RouteAware {
  int minPrice = 10000;
  int maxPrice = 900000;
  List<String> selectedBrands = [];
  String sortBy = "";
  FilterSection selectedSection = FilterSection.budget;
  TextEditingController brandSearchController = TextEditingController();
  String brandSearchQuery = "";
  String? selectedCity;
  List<String> availableCities = [];
  TextEditingController citySearchController = TextEditingController();




  String formatPrice(int value) {
    if (value >= 100000) {
      return "₹ ${(value / 100000).toStringAsFixed(1)} Lakh";
    } else {
      return "₹ ${(value / 1000).toStringAsFixed(0)} K";
    }
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    setState(() {});
  }

  @override
  @override
  void initState() {
    super.initState();
    print("TOTAL BIKES RECEIVED: ${widget.allBikes.length}"); // 👈 yeh sahi hai

    availableCities = widget.allBikes
        .map((e) => e.city ?? "")
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
  }


  @override
  Widget build(BuildContext context) {
    final brands = widget.allBikes
        .map((e) => e.brandName ?? "")
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Filters"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Row(
        children: [
          Container(
            width: 110,
            color: Colors.grey.shade100,
            child: Column(
              children: [
                _menuItem("Budget", FilterSection.budget),
                _menuItem("Brand", FilterSection.brand),
                _menuItem("City", FilterSection.city),

              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: _buildRightContent(brands),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    minPrice = 10000;
                    maxPrice = 900000;
                    selectedBrands.clear();
                    sortBy = "";
                  });
                },
                child: Text("Clear All"),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: _applyFilters,
                child: Text("Apply", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> detectCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled =
    await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission =
    await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission =
      await Geolocator.requestPermission();
      if (permission == LocationPermission.denied)
        return;
    }

    if (permission ==
        LocationPermission.deniedForever) return;

    Position position =
    await Geolocator.getCurrentPosition(
        desiredAccuracy:
        LocationAccuracy.high);

    List<Placemark> placemarks =
    await placemarkFromCoordinates(
        position.latitude,
        position.longitude);

    Placemark place = placemarks.first;

    setState(() {
      selectedCity = place.locality;
      citySearchController.text =
          selectedCity ?? "";
    });
  }




  Widget _menuItem(String title, FilterSection section) {
    final bool isSelected = selectedSection == section;
    return InkWell(
      onTap: () => setState(() => selectedSection = section),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey.shade100,
          border: Border(
            left: BorderSide(
              color: isSelected ? Colors.purple : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.purple : Colors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildRightContent(List brands) {
    switch (selectedSection) {
      case FilterSection.budget:
        return _budgetUI();
      case FilterSection.brand:
        return _brandUI(brands);
      case FilterSection.city:
        return _cityUI();
    }
  }
  double valueToY(double value, double height, double min, double max) {
    final percent = (value - min) / (max - min);
    return height * (1 - percent);
  }

  Widget _budgetUI() {
    final List<Map<String, dynamic>> frequentBudgets = [
      {"label": "Under 1 Lakh", "min": 10000, "max": 100000},
      {"label": "1 - 3 Lakh", "min": 100000, "max": 300000},
      {"label": "3 - 5 Lakh", "min": 300000, "max": 500000},
      {"label": "5 - 9 Lakh", "min": 500000, "max": 900000},
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 267),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Select Your Budget",
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _priceBox(formatPrice(minPrice)),
                  SizedBox(width: 10),
                  Text("–", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(width: 10),
                  _priceBox(formatPrice(maxPrice)),
                ],
              ),
            ),
            SizedBox(height: 30),
            RangeSlider(
              min: 10000,
              max: 900000,
              divisions: 180,
              values: RangeValues(minPrice.toDouble(), maxPrice.toDouble()),
              activeColor: Colors.purple,
              inactiveColor: Colors.grey.shade300,
              labels: RangeLabels(
                formatPrice(minPrice),
                formatPrice(maxPrice),
              ),
              onChanged: (v) {
                setState(() {
                  minPrice = v.start.round();
                  maxPrice = v.end.round();
                });
              },
            ),

            SizedBox(height: 40),

            Text(
              "Frequently Used Budget",
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),

            Column(
              children: frequentBudgets.map((b) {
                final bool selected =
                    minPrice == b["min"] && maxPrice == b["max"];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      minPrice = b["min"];
                      maxPrice = b["max"];
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 13),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.purple.withOpacity(0.08)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selected ? Colors.purple : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          b["label"],
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            color: selected ? Colors.purple : Colors.black,
                          ),
                        ),
                        if (selected)
                          const Icon(Icons.check, color: Colors.purple, size: 20),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Text(
        text.replaceAll("₹", "").trim(),
        style: TextStyle(
          fontSize: 13,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Widget _valueChip(String text) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
  //     decoration: BoxDecoration(
  //       color: Colors.purple,
  //       borderRadius: BorderRadius.circular(18),
  //     ),
  //     child: Text(
  //       text.replaceAll("₹", "").trim(),
  //       style: TextStyle(
  //         color: Colors.white,
  //         fontSize: 12,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //   );
  // }

  // Widget _priceBubble(String text) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(color: Colors.purple),
  //       boxShadow: const [
  //         BoxShadow(
  //           color: Colors.black12,
  //           blurRadius: 6,
  //           offset: Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: Text(
  //       text,
  //       style: const TextStyle(
  //         color: Colors.purple,
  //         fontWeight: FontWeight.w600,
  //         fontSize: 13,
  //       ),
  //     ),
  //   );
  // }


  Widget _brandUI(List brands) {

    List<String> uniqueBrands = brands.map((e) => e.toString()).toSet().toList()
      ..sort();

    List<String> searchedBrands = uniqueBrands.where((b) {
      return b.toLowerCase().contains(brandSearchQuery.toLowerCase());
    }).toList();

    List<String> selected = searchedBrands
        .where((b) => selectedBrands.contains(b))
        .toList();

    List<String> unSelected = searchedBrands
        .where((b) => !selectedBrands.contains(b))
        .toList();

    List<String> finalBrands = [...selected, ...unSelected];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: brandSearchController,
                  onChanged: (v) {
                    setState(() {
                      brandSearchQuery = v;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Search Brand",
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (brandSearchQuery.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      brandSearchController.clear();
                      brandSearchQuery = "";
                    });
                  },
                  child: Icon(Icons.close, color: Colors.grey),
                )
              else
                Icon(Icons.search, color: Colors.grey),
            ],
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: finalBrands.isEmpty
              ? Center(
                  child: Text(
                    "No brand found",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: finalBrands.length,
                  itemBuilder: (context, index) {
                    return _brandTile(finalBrands[index], brandSearchQuery);
                  },
                ),
        ),
      ],
    );
  }

  Widget _cityUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Select City",
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 15),

        // 🔍 GOOGLE PLACE SEARCH
        GooglePlaceAutoCompleteTextField(
          textEditingController: citySearchController,
          googleAPIKey: "AIzaSyDJ7qpCw3pf-zN-fY1DqWZ4HDK0Dmi62C4",
          debounceTime: 600,
          countries: ["in"],
          isLatLngRequired: false,
          inputDecoration: InputDecoration(
            hintText: "Search city",
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          itemClick: (prediction) {
            setState(() {
              selectedCity = prediction.description!
                  .split(",")[0];
              citySearchController.text = selectedCity!;
            });
          },
          getPlaceDetailWithLatLng: (prediction) {},
        ),

        SizedBox(height: 20),

        // 📍 CURRENT LOCATION
        ListTile(
          leading: Icon(Icons.my_location,
              color: Colors.purple),
          title: Text(
            "Use Current Location",
            style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500),
          ),
          onTap: () async {
            await detectCurrentLocation();
          },
        ),

        SizedBox(height: 20),
        if (selectedCity != null && selectedCity!.trim().isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.purple),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on,
                    color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  selectedCity!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'poppins',
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _brandTile(String brand, String query) {
    final bool selected = selectedBrands.contains(brand);

    return InkWell(
      onTap: () {
        setState(() {
          selected ? selectedBrands.remove(brand) : selectedBrands.add(brand);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Checkbox(
              value: selected,
              activeColor: Colors.purple,
              onChanged: (v) {
                setState(() {
                  v! ? selectedBrands.add(brand) : selectedBrands.remove(brand);
                });
              },
            ),
            Expanded(child: _highlightText(brand, query)),
          ],
        ),
      ),
    );
  }

  Widget _highlightText(String text, String query) {
    if (query.isEmpty) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'poppins',
        ),
      );
    }
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    if (!lowerText.contains(lowerQuery)) {
      return Text(text);
    }

    final startIndex = lowerText.indexOf(lowerQuery);
    final endIndex = startIndex + query.length;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text.substring(0, startIndex),
            style: TextStyle(color: Colors.black, fontFamily: 'poppins'),
          ),
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.w600,
              fontFamily: 'poppins',
            ),
          ),
          TextSpan(
            text: text.substring(endIndex),
            style: TextStyle(color: Colors.black, fontFamily: 'poppins'),
          ),
        ],
      ),
    );
  }

  void _applyFilters() {
    int safeMinPrice = minPrice;
    int safeMaxPrice = maxPrice;

    if (safeMinPrice > safeMaxPrice) {
      final temp = safeMinPrice;
      safeMinPrice = safeMaxPrice;
      safeMaxPrice = temp;
    }

    final List<VehicleModel> filtered = widget.allBikes.where((bike) {

      final int price = bike.price ?? 0;

      if (price < safeMinPrice || price > safeMaxPrice) {
        return false;
      }

      if (selectedBrands.isNotEmpty &&
          !selectedBrands.contains(bike.brandName)) {
        return false;
      }

      if (selectedCity != null && selectedCity!.trim().isNotEmpty) {

        final selected =
        selectedCity!.trim().toLowerCase();

        final bikeCity =
        (bike.city ?? "")
            .trim()
            .toLowerCase();
        final cleanBikeCity =
        bikeCity.split(",")[0];

        final cleanSelectedCity =
        selected.split(",")[0];

        if (!cleanBikeCity.contains(cleanSelectedCity)) {
          return false;
        }
      }



      return true;

    }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FilteredBikePage(bikes: filtered),
      ),
    );
  }


}
