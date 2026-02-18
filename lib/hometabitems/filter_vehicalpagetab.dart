import 'package:flutter/material.dart';
import '../homepages/vehicalservice.dart';
import '../modal/vehicalmodel.dart';
import '../widget/loderanimation.dart';
import '../widget/pagenavigationanimation.dart';
import '../homepages/bikeditailspagess.dart';

class FilteredVehiclePage extends StatefulWidget {
  final String category;
  final String subCategoryName;

  const FilteredVehiclePage({
    super.key,
    required this.category,
    required this.subCategoryName,
  });

  @override
  State<FilteredVehiclePage> createState() => _FilteredVehiclePageState();
}

class _FilteredVehiclePageState extends State<FilteredVehiclePage> {
  late Future<List<VehicleModel>> vehiclesFuture;

  @override
  void initState() {
    super.initState();
    vehiclesFuture = VehicleService.fetchVehicles(
      category: widget.category,
      subCategoryName: widget.subCategoryName,
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return FutureBuilder<List<VehicleModel>>(
      future: vehiclesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: SegmentLoader());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Container(
              height: 200,
              width: w * 0.85,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.motorcycle, size: 60, color: Colors.grey.shade400),
                  SizedBox(height: 15),
                  Text(
                    "No ${widget.subCategoryName} Available Yet",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "New bikes will appear here soon.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        final bikes = snapshot.data!;
        return SizedBox(
          height: h * 0.30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bikes.length,
            itemBuilder: (context, index) {
              final bike = bikes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    SlidePageRoute(page: BikeDetailPages(bike: bike)),
                  );
                },
                child: Container(
                  width: w * 0.60,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 6),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: h * 0.18,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
                          child: bike.images.isNotEmpty
                              ? Image.network(
                                  bike.images.first,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) {
                                      return child;
                                    }
                                    return const Center(child: SegmentLoader());
                                  },
                                  errorBuilder: (_, __, ___) => Icon(
                                    Icons.image_not_supported,
                                    size: 60,
                                  ),
                                )
                              :  Center(
                                  child: Icon(Icons.motorcycle, size: 60),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${bike.brandName} ${bike.model}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "₹${bike.price}",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "View Details",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
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
          ),
        );
      },
    );
  }
}
