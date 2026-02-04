import 'package:bikebuyer/homepages/hometabs.dart';
import 'package:flutter/material.dart';

import '../homepages/bikedetailpage.dart';
import '../widget/pagenavigationanimation.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<Map<String, String>> wishlist = [
    {
      "id": "bike_1",
      "name": "Hero Splendor Plus",
      "price": "₹ 92,094",
      "location": "Ex-showroom, Ayodhya",
      "img": "assets/images/hero1.webp",
    },
    {
      "id": "bike_2",
      "name": "Royal Enfield Classic 350",
      "price": "₹ 3,64,569",
      "location": "Ex-showroom, Noida",
      "img": "assets/images/bullet.jpg",
    },
    {
      "id": "bike_3",
      "name": "Bajaj Pulsar 150",
      "price": "₹ 1,38,070",
      "location": "Ex-showroom, Mumbai",
      "img": "assets/images/pulsar1.png",
    },
    {
      "id": "bike_4",
      "name": "Yamaha R15 V4",
      "price": "₹ 1,65,061",
      "location": "Ex-showroom, Delhi",
      "img": "assets/images/Rs15.jpg",
    },
    {
      "id": "bike_5",
      "name": "KTM 350",
      "price": "₹ 2,35,061",
      "location": "Ex-showroom, Lucknow",
      "img": "assets/images/ktm2.webp",
    },
  ];

  List<Map<String, String>> filteredWishlist = [];

  @override
  void initState() {
    super.initState();
    filteredWishlist = List.from(wishlist);
  }

  void searchWishlist(String query) {
    query = query.toLowerCase().trim();

    setState(() {
      if (query.isEmpty) {
        filteredWishlist = List.from(wishlist);
      } else {
        filteredWishlist = wishlist.where((bike) {
          return bike["name"]!.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void openBikeDetails(BuildContext context, Map<String, String> bike) {
    final Map<String, dynamic> fullBike = {
      "id": bike["id"],
      "name": bike["name"],
      "price": bike["price"],
      "brand": bike["name"]!.split(" ").first,
      "cc": "150 cc",
      "km": "45 kmpl",
      "fuel": "Petrol",
      "runKm": "8,000 km",
      "regYear": "2021",
      "owner": "1st Owner",
      "rto": "UP32",
      "location": bike["location"],
      "mileage": "45 kmpl",
      "images": [
        bike["img"],
        bike["img"],
        bike["img"],
        bike["img"],
        bike["img"],
      ],
    };

    Navigator.push(
      context,
      SlidePageRoute(page: BikeDetailPage(bike: fullBike)),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 3,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (isSearching) {
              setState(() {
                isSearching = false;
                searchController.clear();
                filteredWishlist = List.from(wishlist);
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeTabs()),
              );
            }
          },
        ),
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                onChanged: searchWishlist,
                decoration: const InputDecoration(
                  hintText: "Search wishlist bikes...",
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black),
              )
            : Text(
                "Wishlist",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
        actions: [
          if (!isSearching && wishlist.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_outline),
              tooltip: "Clear All",
              onPressed: showClearAllDialog,
            ),
          Padding(
            padding: const EdgeInsets.only(right: 17),
            child: IconButton(
              icon: Icon(
                isSearching ? Icons.close : Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    searchController.clear();
                    filteredWishlist = List.from(wishlist);
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: wishlist.isEmpty
          ? const Center(
              child: Text(
                "Your wishlist is empty ❤️",
                style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
              ),
            )
          : filteredWishlist.isEmpty
          ? Center(
              child: Text(
                "Bike not found 😕",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredWishlist.length,
              itemBuilder: (context, index) {
                final bike = filteredWishlist[index];

                return GestureDetector(
                  onTap: () {
                    openBikeDetails(context, bike);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: h * 0.0144),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            bike["img"]!,
                            height: h * 0.083,
                            width: w * 0.23,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: w * 0.025),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bike["name"]!,
                                style: TextStyle(
                                  fontSize: w * 0.038,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: h * 0.005),
                              Text(
                                bike["location"]!,
                                style: TextStyle(
                                  fontSize: w * 0.028,
                                  fontFamily: 'Poppins',
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(height: h * 0.006),
                              Text(
                                bike["price"]!,
                                style: TextStyle(
                                  fontSize: w * 0.031,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Icon(Icons.favorite, color: Colors.red),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == "delete") {
                                  setState(() {
                                    wishlist.removeWhere((item) => item["id"] == bike["id"]);
                                    filteredWishlist.removeAt(index);
                                  });
                                } else if (value == "share") {}
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: "share",
                                  child: Row(
                                    children: [
                                      Icon(Icons.share, size: h * 0.022),
                                      SizedBox(width: w * 0.016),
                                      Text(
                                        "Share",
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "delete",
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, size: h * 0.022),
                                      SizedBox(width: w * 0.016),
                                      Text(
                                        "Remove",
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Clear Wishlist",
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          content: Text(
            "Are you sure you want to remove all items from wishlist?",
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(width: 7),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  wishlist.clear();
                  filteredWishlist.clear();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Wishlist cleared successfully",
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Yes",
                style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
