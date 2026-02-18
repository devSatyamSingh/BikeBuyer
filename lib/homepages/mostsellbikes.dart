import 'package:bikebuyer/modal/vehicalmodel.dart';
import 'package:bikebuyer/homepages/vehicalservice.dart';
import 'package:flutter/material.dart';
import '../widget/loderanimation.dart';
import '../widget/pagenavigationanimation.dart';
import 'bikedetailpage.dart';
import 'bikeditailspagess.dart';

class MostSellBikesSection extends StatefulWidget {
  final String? searchQuery;

  const MostSellBikesSection({super.key, this.searchQuery});

  @override
  State<MostSellBikesSection> createState() => _MostSellBikesSectionState();
}

class _MostSellBikesSectionState extends State<MostSellBikesSection> {
  bool isLoading = true;
  bool showAll = false;
  List<VehicleModel> bikes = [];

  @override
  void initState() {
    super.initState();
    loadBikes();
  }

  @override
  void didUpdateWidget(covariant MostSellBikesSection oldWidget) {
    if (oldWidget.searchQuery != widget.searchQuery) {
      loadBikes();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> loadBikes() async {
    setState(() => isLoading = true);

    final allVehicles = await VehicleService.fetchVehicles(
      search: widget.searchQuery,
    );

    bikes = allVehicles
        .where((v) => v.categoryName?.toLowerCase() == "bike")
        .toList();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    if (bikes.isEmpty) return const SizedBox();

    final displayBikes = showAll ? bikes : bikes.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "The Most Sell Bikes",
          style: TextStyle(
            fontSize: w * 0.044,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: h * 0.0130),
        SizedBox(
          height: h * 0.26,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayBikes.length + (bikes.length > 3 ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == displayBikes.length && bikes.length > 3) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      showAll = !showAll;
                    });
                  },
                  child: Container(
                    width: w * 0.11,
                    margin: EdgeInsets.only(right: w * 0.028),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50.withAlpha(40),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.purple),
                    ),
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              showAll
                                  ? Icons.keyboard_arrow_down_outlined
                                  : Icons.keyboard_arrow_up,
                              color: Colors.purple,
                              size: 22,
                            ),
                            SizedBox(width: 6),
                            Text(
                              showAll ? "Show Less" : "Show More",
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              final bike = displayBikes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BikeDetailPages(bike: bike),
                    ),
                  );
                },
                child: Container(
                  height: h * 0.185,
                  width: w * 0.63,
                  margin: EdgeInsets.only(right: w * 0.025),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: bike.images.isNotEmpty
                              ? Image.network(
                                  bike.images.first,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        size: 70,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 70,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "${bike.brandName} ${bike.model}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "₹${bike.price}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
