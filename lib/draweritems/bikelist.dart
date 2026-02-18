import 'package:bikebuyer/widget/vehicaleprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../homepages/bikeditailspagess.dart';
import '../widget/pagenavigationanimation.dart';
import '../widget/loderanimation.dart';

class BikeListPage extends StatefulWidget {
  const BikeListPage({super.key});

  @override
  State<BikeListPage> createState() => _BikeListPageState();
}

class _BikeListPageState extends State<BikeListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<VehicleProvider>(
        context,
        listen: false,
      ).fetchVehicles(category: "bike"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VehicleProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Bikes",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: provider.isLoading
          ? const Center(child: SegmentLoader())
          : provider.vehicles.isEmpty
          ? Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
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
                      Icons.motorcycle,
                      size: 65,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "No Bikes Available",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "New bikes will be listed here soon.\nPlease check back later.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.purple),
                      ),
                      child: const Text(
                        "Explore Other Categories",
                        style: TextStyle(
                          color: Colors.purple,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              itemCount: provider.vehicles.length,
              itemBuilder: (context, index) {
                final bike = provider.vehicles[index];

                return Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  margin: const EdgeInsets.only(bottom: 17),
                  child: Container(
                    height: 330,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 185,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(18),
                            ),
                            child: bike.images.isNotEmpty
                                ? Image.network(
                                    bike.images.first,
                                    fit: BoxFit.cover,

                                    /// Fade Animation
                                    frameBuilder:
                                        (
                                          context,
                                          child,
                                          frame,
                                          wasSynchronouslyLoaded,
                                        ) {
                                          if (wasSynchronouslyLoaded)
                                            return child;

                                          return AnimatedOpacity(
                                            opacity: frame == null ? 0 : 1,
                                            duration: const Duration(
                                              milliseconds: 400,
                                            ),
                                            curve: Curves.easeIn,
                                            child: child,
                                          );
                                        },

                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const Center(
                                            child: SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: SegmentLoader(),
                                            ),
                                          );
                                        },
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

                        /// DETAILS
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 14, 14, 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${bike.brandName} ${bike.model}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "₹${bike.price}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
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
                                      colors: [
                                        Colors.purple,
                                        Colors.deepPurple,
                                      ],
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "View Bike Details",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
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
            ),
    );
  }
}
