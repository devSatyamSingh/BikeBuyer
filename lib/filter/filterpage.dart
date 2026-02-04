import 'package:flutter/material.dart';
import 'filterbikespage.dart';
import 'filterlogicpage.dart';
import 'filtermodel.dart';
import '../main.dart';

enum FilterSection { budget, brand, engine, year }

class FilterPage extends StatefulWidget {
  final List<Map<String, dynamic>> allBikes;

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
  TextEditingController engineSearchController = TextEditingController();
  String engineQuery = "";
  TextEditingController yearSearchController = TextEditingController();
  String yearQuery = "";

  List<Map<String, dynamic>> engineRanges = [
    {"label": "Upto 100 cc", "min": 0, "max": 100},
    {"label": "100 - 125 cc", "min": 100, "max": 125},
    {"label": "125 - 150 cc", "min": 125, "max": 150},
    {"label": "150 - 200 cc", "min": 150, "max": 200},
    {"label": "200 - 250 cc", "min": 200, "max": 250},
    {"label": "250 - 500 cc", "min": 250, "max": 500},
    {"label": "500 - 1000 cc", "min": 500, "max": 1000},
    {"label": "1000 cc & above", "min": 1000, "max": 5000},
  ];

  List<Map<String, dynamic>> yearRanges = [
    {"label": "2016 - 2018", "min": 2016, "max": 2018},
    {"label": "2018 - 2020", "min": 2018, "max": 2020},
    {"label": "2020 - 2022", "min": 2020, "max": 2022},
    {"label": "2022 - 2024", "min": 2022, "max": 2024},
    {"label": "2024 - 2026", "min": 2024, "max": 2026},
  ];

  List<int> selectedEngineIndexes = [];
  List<int> selectedYearIndexes = [];

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
  Widget build(BuildContext context) {
    final brands = widget.allBikes
        .map((e) => e["brand"].toString())
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
            width: 130,
            color: Colors.grey.shade100,
            child: Column(
              children: [
                _menuItem("Budget", FilterSection.budget),
                _menuItem("Brand", FilterSection.brand),
                _menuItem("Engine", FilterSection.engine),
                _menuItem("Year", FilterSection.year),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
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
                    selectedEngineIndexes.clear();
                    selectedYearIndexes.clear();
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
      case FilterSection.engine:
        return _engineUI();
      case FilterSection.year:
        return _yearUI();
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
    double sliderHeight = 440;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: const EdgeInsets.symmetric(vertical: 10),
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
                Text(
                  "–",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 10),
                _priceBox(formatPrice(maxPrice)),
              ],
            ),
          ),
          SizedBox(height: 24),
          Center(
            child: Text(
              "9 Lakh",
              style: TextStyle(fontSize: 17, color: Colors.grey),
            ),
          ),
          Center(
            child: SizedBox(
              height: sliderHeight,
              child: RotatedBox(
                quarterTurns: -1,
                child: RangeSlider(
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
              ),
            ),
          ),
          Center(
            child: Text(
              "10k",
              style: TextStyle(fontSize: 17, color: Colors.grey),
            ),
          ),
          SizedBox(height: 18),
          Text(
            "Frequently Used Budget",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
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
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
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

  Widget _engineUI() {
    final sorted = [...engineRanges];

    sorted.sort((a, b) {
      final aIndex = engineRanges.indexOf(a);
      final bIndex = engineRanges.indexOf(b);
      final aSelected = selectedEngineIndexes.contains(aIndex);
      final bSelected = selectedEngineIndexes.contains(bIndex);

      if (aSelected && !bSelected) return -1;
      if (!aSelected && bSelected) return 1;
      return a["label"].compareTo(b["label"]);
    });
    return ListView.builder(
      itemCount: sorted.length,
      itemBuilder: (context, i) {
        final range = sorted[i];
        final index = engineRanges.indexOf(range);
        final selected = selectedEngineIndexes.contains(index);

        return InkWell(
          onTap: () {
            setState(() {
              selected
                  ? selectedEngineIndexes.remove(index)
                  : selectedEngineIndexes.add(index);
            });
          },
          child: Row(
            children: [
              Checkbox(
                value: selected,
                activeColor: Colors.purple,
                onChanged: (v) {
                  setState(() {
                    v!
                        ? selectedEngineIndexes.add(index)
                        : selectedEngineIndexes.remove(index);
                  });
                },
              ),
              Expanded(
                child: Text(
                  range["label"],
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _yearUI() {
    final sorted = [...yearRanges];
    sorted.sort((a, b) {
      final aIndex = yearRanges.indexOf(a);
      final bIndex = yearRanges.indexOf(b);
      final aSelected = selectedYearIndexes.contains(aIndex);
      final bSelected = selectedYearIndexes.contains(bIndex);

      if (aSelected && !bSelected) return -1;
      if (!aSelected && bSelected) return 1;
      return a["label"].compareTo(b["label"]);
    });
    return ListView.builder(
      itemCount: sorted.length,
      itemBuilder: (context, i) {
        final range = sorted[i];
        final index = yearRanges.indexOf(range);
        final selected = selectedYearIndexes.contains(index);
        return InkWell(
          onTap: () {
            setState(() {
              selected
                  ? selectedYearIndexes.remove(index)
                  : selectedYearIndexes.add(index);
            });
          },
          child: Row(
            children: [
              Checkbox(
                value: selected,
                activeColor: Colors.purple,
                onChanged: (v) {
                  setState(() {
                    v!
                        ? selectedYearIndexes.add(index)
                        : selectedYearIndexes.remove(index);
                  });
                },
              ),
              Expanded(
                child: Text(
                  range["label"],
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
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

    final List<Map<String, dynamic>> filtered = widget.allBikes.where((bike) {
      final int price = bike["priceValue"] is int ? bike["priceValue"] : 0;
      final int cc = bike["ccValue"] is int ? bike["ccValue"] : 0;
      final int year = bike["year"] is int ? bike["year"] : 0;
      final String brand = bike["brand"] != null
          ? bike["brand"].toString()
          : "";

      // -------- PRICE --------
      if (price < safeMinPrice || price > safeMaxPrice) {
        return false;
      }

      // -------- BRAND --------
      if (selectedBrands.isNotEmpty && !selectedBrands.contains(brand)) {
        return false;
      }

      // -------- ENGINE --------
      if (selectedEngineIndexes.isNotEmpty) {
        bool engineMatch = false;

        for (final index in selectedEngineIndexes) {
          final r = engineRanges[index];
          if (cc >= r["min"] && cc <= r["max"]) {
            engineMatch = true;
            break;
          }
        }

        if (!engineMatch) return false;
      }

      // -------- YEAR --------
      if (selectedYearIndexes.isNotEmpty) {
        bool yearMatch = false;

        for (final index in selectedYearIndexes) {
          final r = yearRanges[index];
          if (year >= r["min"] && year <= r["max"]) {
            yearMatch = true;
            break;
          }
        }
        if (!yearMatch) return false;
      }
      return true;
    }).toList();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FilteredBikePage(bikes: filtered)),
    );
  }
}
