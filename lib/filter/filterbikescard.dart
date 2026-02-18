import 'package:flutter/material.dart';
import '../homepages/bikedetailpage.dart';
import '../homepages/bikeditailspagess.dart';
import '../modal/vehicalmodel.dart';
import '../widget/loderanimation.dart';
import '../widget/pagenavigationanimation.dart';

class FilteredBikeLargeCard extends StatelessWidget {
  final VehicleModel bike;

  const FilteredBikeLargeCard({super.key, required this.bike});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.only(bottom: 17, left: 10, right: 10),
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
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: AspectRatio(
                      aspectRatio: 16 / 12,
                      child: bike.images.isNotEmpty
                          ? Image.network(
                              bike.images.first,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const SegmentLoader();
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 60,
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Icon(Icons.image_not_supported, size: 60),
                            ),
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
                        SlidePageRoute(page: BikeDetailPages(bike: bike)),
                      );
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.deepPurple],
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
    // return Card(
    //   color: Colors.white,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    //   margin: const EdgeInsets.only(bottom: 18),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Image.asset(
    //         bike["images"][0],
    //         height: 240,
    //         width: 368,
    //         fit: BoxFit.contain,
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(16),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               bike["name"],
    //               style: TextStyle(
    //                 fontSize: 18,
    //                 fontFamily: 'Poppins',
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //             SizedBox(height: 6),
    //             Text(
    //               bike["price"],
    //               style: TextStyle(
    //                 fontSize: 16,
    //                 color: Colors.green,
    //                 fontFamily: 'Poppins',
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //             SizedBox(height: 14),
    //             GestureDetector(
    //               onTap: () {
    //                 Navigator.push(
    //                   context,
    //                   SlidePageRoute(page: BikeDetailPage(bike: bike)),
    //                 );
    //               },
    //               child: Container(
    //                 height: 48,
    //                 width: double.infinity,
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(20),
    //                   color: Colors.purple,
    //                 ),
    //                 child: Center(
    //                   child: Text(
    //                     "View Bike Details",
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontFamily: 'Poppins',
    //                       fontWeight: FontWeight.w500,
    //                       fontSize: 16,
    //                     ),
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
  }
}
