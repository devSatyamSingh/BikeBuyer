import 'package:bikebuyer/homepages/bikeditailspagess.dart';
import 'package:flutter/material.dart';
import '../modal/vehicalmodel.dart';
import '../widget/loderanimation.dart';
import '../widget/pagenavigationanimation.dart';
import 'bikedetailpage.dart';

class BrandBikesPage extends StatefulWidget {
  final String brandName;
  final List<VehicleModel> bikes;

  const BrandBikesPage({
    super.key,
    required this.brandName,
    required this.bikes,
  });

  @override
  State<BrandBikesPage> createState() => _BrandBikesPageState();
}

class _BrandBikesPageState extends State<BrandBikesPage> {

  bool isPageLoading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isPageLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    if (isPageLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: SegmentLoader(),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          widget.brandName,
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400),
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: widget.bikes.isEmpty
          ? Center(
              child: Text(
                "No bikes available",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: widget.bikes.length,
              itemBuilder: (context, index) {
                final bike = widget.bikes[index];
                return Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  margin: const EdgeInsets.only(
                    bottom: 17,
                    left: 10,
                    right: 10,
                  ),
                  child: Container(
                    height: 305,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.6),
                          blurRadius: 7,
                          offset: Offset(2, 7),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white, Colors.white],
                            ),
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: AspectRatio(
                                  aspectRatio: 19 / 14,
                                  child: bike.images.isNotEmpty
                                      ? Image.network(
                                    bike.images.first,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;

                                      return const Center(
                                        child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: SegmentLoader(),
                                        ),
                                      );
                                    },
                                    errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.image_not_supported),
                                  )
                                      : const Icon(Icons.image_not_supported),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 14, 14, 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${bike.brandName} ${bike.model}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "₹${bike.price}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 12),
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
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.purple,
                                        Colors.deepPurple,
                                      ],
                                    ),
                                  ),
                                  child: Center(
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
                // return Container(
                //   margin: const EdgeInsets.symmetric(
                //     horizontal: 18,
                //     vertical: 10,
                //   ),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(18),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black12,
                //         blurRadius: 4,
                //         offset: Offset(0, 3),
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       ClipRRect(
                //         borderRadius: BorderRadius.vertical(
                //           top: Radius.circular(18),
                //         ),
                //         child: Image.asset(
                //           bike["images"][0],
                //           height: 250,
                //           width: 360,
                //           fit: BoxFit.contain,
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(18),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               bike["name"],
                //               style: TextStyle(
                //                 fontFamily: 'Poppins',
                //                 fontSize: 19,
                //                 fontWeight: FontWeight.w500,
                //               ),
                //             ),
                //             SizedBox(height: 6),
                //             Text(
                //               bike["price"],
                //               style: TextStyle(
                //                 fontSize: 18,
                //                 fontFamily: 'Poppins',
                //                 color: Colors.green,
                //                 fontWeight: FontWeight.w500,
                //               ),
                //             ),
                //             SizedBox(height: 14),
                //             SizedBox(
                //               height: 52,
                //               width: double.infinity,
                //               child: ElevatedButton(
                //                 style: ElevatedButton.styleFrom(
                //                   backgroundColor: Colors.purple,
                //                   shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(16),
                //                   ),
                //                 ),
                //                 onPressed: () {
                //                   Navigator.push(
                //                     context,
                //                     SlidePageRoute(
                //                       page: BikeDetailPage(bike: bike),
                //                     ),
                //                   );
                //                 },
                //                 child: Text(
                //                   "View Bike Details",
                //                   style: TextStyle(
                //                     fontSize: 17,
                //                     fontFamily: 'Poppins',
                //                     fontWeight: FontWeight.w500,
                //                     color: Colors.white,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // );
              },
            ),
    );
  }
}
