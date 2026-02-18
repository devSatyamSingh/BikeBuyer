import 'package:bikebuyer/modal/vehicalmodel.dart';
import 'package:bikebuyer/homepages/vehicalservice.dart';
import 'package:flutter/material.dart';
import '../widget/loderanimation.dart';
import 'bikeditailspagess.dart';

class LatestBikesSection extends StatefulWidget {
  final String? searchQuery;

  const LatestBikesSection({super.key, this.searchQuery});

  @override
  State<LatestBikesSection> createState() => _LatestBikesSectionState();
}

class _LatestBikesSectionState extends State<LatestBikesSection> {
  bool isLoading = true;
  bool showAll = false; // 👈 show more logic
  List<VehicleModel> vehicles = [];
  String? error;

  @override
  void initState() {
    super.initState();
    loadVehicles();
  }

  @override
  void didUpdateWidget(covariant LatestBikesSection oldWidget) {
    if (oldWidget.searchQuery != widget.searchQuery) {
      loadVehicles();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> loadVehicles() async {
    try {
      setState(() => isLoading = true);

      vehicles = await VehicleService.fetchVehicles(search: widget.searchQuery);

      setState(() => isLoading = false);
    } catch (e) {
      error = e.toString();
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 37),
        child: SegmentLoader(),
      );
    }

    if (error != null) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: Text("Error loading vehicles")),
      );
    }

    if (vehicles.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: Text("No vehicles found")),
      );
    }
    final displayList = showAll ? vehicles : vehicles.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Latest Bikes & Scooters",
           style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: h * 0.013),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 13,
            crossAxisSpacing: 13,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final bike = displayList[index];

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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 5),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.network(
                          bike.images.isNotEmpty ? bike.images.first : "",
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Padding(
                                padding: const EdgeInsets.only(left: 55),
                                child: Icon(Icons.image_not_supported, size: 70, color: Colors.grey,),
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "${bike.brandName} ${bike.model}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "₹${bike.price}",
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        ),
        if (vehicles.length > 4)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showAll = !showAll;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.purple),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        showAll ? "Show Less" : "Show More",
                        style: TextStyle(
                          color: Colors.purple,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                       SizedBox(width: 6),
                      Icon(
                        showAll
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
