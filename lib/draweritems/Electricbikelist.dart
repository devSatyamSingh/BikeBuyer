import 'package:flutter/material.dart';
import '../homepages/vehicalservice.dart';
import '../modal/vehicalmodel.dart';
import '../widget/loderanimation.dart';
import '../widget/pagenavigationanimation.dart';
import '../homepages/bikeditailspagess.dart';

class ElectricBikeLIst extends StatefulWidget {
  const ElectricBikeLIst({super.key});

  @override
  State<ElectricBikeLIst> createState() => _ElectricBikeLIstState();
}

class _ElectricBikeLIstState extends State<ElectricBikeLIst> {
  late Future<List<VehicleModel>> bikesFuture;

  @override
  void initState() {
    super.initState();

    bikesFuture = VehicleService.fetchVehicles(
      category: "bike",
      subCategoryName: "Electric Bike",
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: FutureBuilder<List<VehicleModel>>(
        future: bikesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: SegmentLoader());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Container(
                height: 200,
                width: w * 0.85,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.electric_bike,
                      size: 60,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "No Electric Bikes Available",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "New listings will appear here soon.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final bikes = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            itemCount: bikes.length,
            itemBuilder: (context, index) {
              final bike = bikes[index];

              return Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                margin: const EdgeInsets.only(bottom: 17),
                child: Container(
                  height: 305,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// IMAGE
                      Container(
                        height: 170,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
                          child: bike.images.isNotEmpty
                              ? Image.network(
                                  bike.images.first,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return const Center(child: SegmentLoader());
                                  },
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.image_not_supported,
                                    size: 60,
                                  ),
                                )
                              : const Icon(Icons.electric_bike, size: 60),
                        ),
                      ),

                      /// DETAILS
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${bike.brandName} ${bike.model}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "₹${bike.price}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 12),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  SlidePageRoute(
                                    page: BikeDetailPages(bike: bike),
                                  ),
                                );
                              },
                              child: Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    colors: [Colors.purple, Colors.deepPurple],
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "View Bike Details",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
