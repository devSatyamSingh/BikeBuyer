import 'package:bikebuyer/homepages/contact_dealer.dart';
import 'package:bikebuyer/homepages/send_inquiry.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../widget/pagenavigationanimation.dart';
import 'similarbikelist.dart';
import 'fullscreenimg.dart';

class BikeDetailPage extends StatefulWidget {
  final Map bike;

  const BikeDetailPage({super.key, required this.bike});

  @override
  State<BikeDetailPage> createState() => _BikeDetailPageState();
}

class _BikeDetailPageState extends State<BikeDetailPage> {

  bool isWishlisted = false;
  int currentImage = 0;
  final PageController _pageController = PageController();

  void goNextImage() {
    if (currentImage < widget.bike["images"].length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goPrevImage() {
    if (currentImage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100.withOpacity(0.9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: h * 0.38,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.bike["images"].length,
                    onPageChanged: (index) {
                      setState(() {
                        currentImage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenImageView(
                                  images: List<String>.from(widget.bike["images"]),
                                  initialIndex: index,
                                ),
                              ),
                            );
                          },
                          child: Center(
                            child: SizedBox(
                              height: h * 0.32,   // 👈 actual image height
                              width: w * 0.75,
                              child: Image.asset(
                                widget.bike["images"][index],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                circleIcon(Icons.arrow_back_ios, () {
                  Navigator.pop(context);
                }, left: 22, top: 55),
                circleIcon(Icons.share, () {}, right: 75, top: 55),
                Positioned(
                  top: 55,
                  right: 26,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isWishlisted = !isWishlisted;
                      });
                    },
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                      child: CircleAvatar(
                        key: ValueKey(isWishlisted),
                        radius: 20,
                        backgroundColor: Colors.grey.shade100,
                        child: Icon(
                          isWishlisted ? IconlyBold.heart : IconlyLight.heart,
                          color: isWishlisted ? Colors.red : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                if (currentImage > 0)
                  Positioned(
                    left: 10,
                    top: h * 0.22,
                    child: GestureDetector(
                      onTap: goPrevImage,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                        Colors.black.withOpacity(0.3),
                        child: const Icon(Icons.arrow_back_ios,
                            size: 18, color: Colors.white),
                      ),
                    ),
                  ),
                if (currentImage < widget.bike["images"].length - 1)
                  Positioned(
                    right: 10,
                    top: h * 0.22,
                    child: GestureDetector(
                      onTap: goNextImage,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                        Colors.black.withOpacity(0.3),
                        child: Icon(Icons.arrow_forward_ios,
                            size: 18, color: Colors.white),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 15,
                  left: 2,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.bike["images"].length,
                          (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 7,
                        width: currentImage == index ? 13 : 8,
                        decoration: BoxDecoration(
                          color: currentImage == index
                              ? Colors.purple
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.bike["name"],
                    style: TextStyle(
                      fontSize: w * 0.046,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.verified, color: Colors.blue, size: 17),
                      SizedBox(width: 4),
                      Text("Verified Dealer", style: TextStyle(color: Colors.blue, fontFamily: 'Poppins',)),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    widget.bike["price"],
                    style: TextStyle(
                      fontSize: w * 0.043,
                      fontFamily: 'Poppins',
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6,),
                  Row(
                    children: [
                      Icon(Icons.speed, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(widget.bike["runKm"], style: TextStyle(color: Colors.black54, fontFamily: 'Poppins',)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.store),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Shiv Motors | Ayodhya",
                                style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins',)),
                            Text("120+ Bikes", style: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Poppins',),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      spec(Icons.speed, widget.bike["cc"], "Engine"),
                      spec(Icons.local_gas_station, widget.bike["km"], "Mileage"),
                      spec(Icons.settings, widget.bike["fuel"], "Fuel"),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text("Basic Information", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, fontFamily: 'Poppins',)),
                  SizedBox(height: 12),
                   infoRow("Registration Year", widget.bike["regYear"]),
                   infoRow("KM Driven", widget.bike["runKm"]),
                   infoRow("Ownership", widget.bike["owner"]),
                   infoRow("RTO", widget.bike["rto"]),
                   infoRow("Location", widget.bike["location"]),
                  SizedBox(height: 22),
                  Text("Specifications", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, fontFamily: 'Poppins',)),
                  SizedBox(height: 12),
                   infoRow("Mileage", widget.bike["km"]),
                   infoRow("Engine", widget.bike["cc"]),
                   infoRow("Fuel Type", widget.bike["fuel"]),
                  SizedBox(height: 20),
                  SimilarBikesSection(w: w, h: h),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Safety Tips", style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins',)),
                      SizedBox(height: 6),
                      Text("• Meet seller in public place", style: TextStyle(fontFamily: 'Poppins',),),
                      Text("• Check RC & chassis number", style: TextStyle(fontFamily: 'Poppins',),),
                      Text("• Avoid advance payment", style: TextStyle(fontFamily: 'Poppins',),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child:GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   SlidePageRoute(page: SendInquiryPage()),
                  // );
                },
                child: Container(
                  width: 200,
                  height: h * 0.06,
                  decoration: BoxDecoration( color: Colors.white54,
                    borderRadius: BorderRadius.circular(20), ),
                  child: Center(
                    child: Text( "Send Inquiry",
                      style: TextStyle( color: Colors.black,
                        fontSize: w * 0.038,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    SlidePageRoute(page: ContactDealerPage(
                      seller: {
                        "name": "Shiv Motors",
                        "phone": "7860701843",
                        "whatsapp": "7860701843",
                        "location": "Ayodhya, UP",
                      },
                    ),),
                  );
                },
                child: Container(
                width: 200,
                 height: h * 0.06,
                  decoration: BoxDecoration( color: Colors.purple,
                   borderRadius: BorderRadius.circular(20), ),
                   child: Center(
                   child: Text( "Contact Dealer",
                    style: TextStyle( color: Colors.white,
                      fontSize: w * 0.038,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                   ),
                   ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget circleIcon(IconData icon, VoidCallback onTap,
      {double? left, double? right, double? top}) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      child: GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.shade100,
          child: Icon(icon, size: 22, color: Colors.black),
        ),
      ),
    );
  }

  Widget spec(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.purple),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins',)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Poppins',)),
      ],
    );
  }
  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey, fontFamily: 'Poppins',)),
          Text(value, style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins',)),
        ],
      ),
    );
  }
}
