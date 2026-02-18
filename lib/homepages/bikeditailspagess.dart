import 'package:bikebuyer/homepages/contact_dealer.dart';
import 'package:bikebuyer/homepages/send_inquiry.dart';
import 'package:bikebuyer/modal/vehicalmodel.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../widget/auth_helper.dart';
import '../widget/pagenavigationanimation.dart';
import '../widget/wishlist_service.dart';
import 'similarbikelist.dart';
import 'fullscreenimg.dart';
import 'package:share_plus/share_plus.dart';

class BikeDetailPages extends StatefulWidget {
  final VehicleModel bike;

  const BikeDetailPages({super.key, required this.bike});

  @override
  State<BikeDetailPages> createState() => _BikeDetailPagesState();
}

class _BikeDetailPagesState extends State<BikeDetailPages> {
  bool isWishlisted = false;
  int currentImage = 0;
  final PageController _pageController = PageController();


  void goNextImage() {
    if (currentImage < widget.bike.images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goPrevImage() {
    if (currentImage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void shareBike() async {
    final bike = widget.bike;

    final String message = '''
🏍 ${bike.brandName} ${bike.model}

💰 Price: ₹${bike.price}
📍 Location: ${bike.city}, ${bike.state}
📅 Year: ${bike.year}

Check this bike on BikeBuyer App!
''';

    await SharePlus.instance.share(
      ShareParams(
        text: message,
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    checkWishlist();
  }

  void checkWishlist() async {
    bool exists = await WishlistService.isInWishlist(widget.bike.vehicleId);
    setState(() {
      isWishlisted = exists;
    });
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
                    itemCount: widget.bike.images.length,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenImageView(
                                  images: widget.bike.images,
                                  initialIndex: index,
                                ),
                              ),
                            );
                          },
                          child: Center(
                            child: SizedBox(
                              height: h * 0.32,
                              width: w * 0.75,
                              child: Image.network(
                                widget.bike.images[index],
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) =>
                                Icon(Icons.image_not_supported, size: 70, color: Colors.grey,),
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
                circleIcon(Icons.share, shareBike, right: 75, top: 55),
                Positioned(
                  top: 55,
                  right: 26,
                  child: GestureDetector(
                    onTap: () async {
                      bool loggedIn = await requireLogin(context);
                      if (!loggedIn) return;
                      if (isWishlisted) {
                        await WishlistService.removeFromWishlist(widget.bike.vehicleId);
                      } else {
                        await WishlistService.addToWishlist(widget.bike);
                      }
                      setState(() {
                        isWishlisted = !isWishlisted;
                      });
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: CircleAvatar(
                        key: ValueKey(isWishlisted),
                        radius: 20,
                        backgroundColor: Colors.grey.shade100,
                        child: Icon(
                          isWishlisted
                              ? IconlyBold.heart
                              : IconlyLight.heart,
                          color:
                          isWishlisted ? Colors.red : Colors.black,
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
                if (currentImage < widget.bike.images.length - 1)
                  Positioned(
                    right: 10,
                    top: h * 0.22,
                    child: GestureDetector(
                      onTap: goNextImage,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                        Colors.black.withOpacity(0.3),
                        child: const Icon(Icons.arrow_forward_ios,
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
                      widget.bike.images.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 7,
                        width: currentImage == index ? 13 : 8,
                        decoration: BoxDecoration(
                          color: currentImage == index
                              ? Colors.purple
                              : Colors.grey.shade400,
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(18),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.bike.brandName} ${widget.bike.model}",
                    style: TextStyle(
                      fontSize: w * 0.046,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.verified,
                          color: Colors.blue, size: 17),
                      SizedBox(width: 4),
                      Text("Verified Dealer",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Poppins')),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "₹${widget.bike.price}",
                    style: TextStyle(
                      fontSize: w * 0.043,
                      fontFamily: 'Poppins',
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                      Colors.grey.shade100.withOpacity(0.5),
                      borderRadius:
                      BorderRadius.circular(10),
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
                            Text(
                              "${widget.bike.shopName} | ${widget.bike.city}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins'),
                            ),
                            Text(
                              "${widget.bike.state}",
                              style: TextStyle(
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      spec(Icons.calendar_today,
                          widget.bike.year.toString(), "Year"),
                      spec(Icons.build,
                          widget.bike.condition, "Condition"),
                      spec(Icons.speed,
                          widget.bike.engineCC?.toString() ?? "N/A",
                          "Engine"),
                      spec(Icons.local_gas_station,
                          widget.bike.mileage?.toString() ?? "N/A",
                          "Mileage"),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     spec(Icons.speed,
                  //         widget.bike.engineCC?.toString() ?? "N/A",
                  //         "Engine"),
                  //     spec(Icons.local_gas_station,
                  //         widget.bike.mileage?.toString() ?? "N/A",
                  //         "Mileage"),
                  //     spec(Icons.calendar_today,
                  //         widget.bike.year.toString(),
                  //         "Year"),
                  //   ],
                  // ),
                  SizedBox(height: 25),

                  Text(
                    "Basic Information",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),

                  SizedBox(height: 10),

                  infoRow("Registration Year", widget.bike.year.toString()),
                  infoRow("KM Driven", "${widget.bike.kmDriven} km"),
                  infoRow("Ownership", widget.bike.numberOfOwners.toString()),
                  infoRow("Bike Number", widget.bike.registrationNumber ?? "N/A"),
                  infoRow("Location", "${widget.bike.city}, ${widget.bike.state}"),
                  SizedBox(height: 20),
                  SimilarBikesSection(w: w, h: h),
                  SizedBox(height: 20),
                  Text(
                    "About This Bike",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: w * 0.041,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.bike.description.isNotEmpty
                          ? widget.bike.description
                          : "No description available for this bike.",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Text("Safety Tips",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: w * 0.040,
                          fontFamily: 'Poppins')),
                  SizedBox(height: 6),
                  Text("• Meet seller in public place"),
                  Text("• Check RC & chassis number"),
                  Text("• Avoid advance payment"),
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
              child: GestureDetector(
                onTap: () async {

                  bool loggedIn = await requireLogin(context);

                  if (!loggedIn) return;

                  Navigator.push(
                    context,
                    SlidePageRoute(
                      page: SendInquiryPage(
                        vehicleId: widget.bike.vehicleId,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: h * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text("Send Inquiry"),
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
                    SlidePageRoute(
                      page: ContactDealerPage(
                        seller: {
                          "name": widget.bike.shopName, // ✅ agency name
                          "phone": widget.bike.dealerPhone,
                          "whatsapp": widget.bike.dealerPhone,
                          "location": "${widget.bike.city}, ${widget.bike.state}",
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  height: h * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text("Contact Dealer",
                        style:
                        TextStyle(color: Colors.white)),
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

  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Poppins')),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins')),
        ],
      ),
    );
  }


  Widget spec(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.purple),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins')),
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontFamily: 'Poppins')),
      ],
    );
  }
}