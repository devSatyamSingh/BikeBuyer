import 'package:bikebuyer/page/hometabs.dart';
import 'package:flutter/material.dart';

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
      "name": "Hero Splendor Plus",
      "price": "₹ 92,094",
      "location": "Ex-showroom, Ayodhya",
      "img": "assets/images/hero1.webp",
    },
    {
      "name": "Royal Enfield Classic 350",
      "price": "₹ 3,64,569",
      "location": "Ex-showroom, Noida",
      "img": "assets/images/bullet.jpg",
    },
    {
      "name": "Bajaj Pulsar 150",
      "price": "₹ 1,38,070",
      "location": "Ex-showroom, Mumbai",
      "img": "assets/images/pulsar1.png",
    },
    {
      "name": "Yamaha R15 V4",
      "price": "₹ 1,65,061",
      "location": "Ex-showroom, Delhi",
      "img": "assets/images/Rs15.jpg",
    },
    {
      "name": "KTM 350",
      "price": "₹ 2,35,061",
      "location": "Ex-showroom, Lucknow",
      "img": "assets/images/ktm2.webp",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            isSearching ? Icons.arrow_back : Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            if (isSearching) {
              setState(() {
                isSearching = false;
                searchController.clear();
              });
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeTabs()));
            }
          },
        ),

        title: isSearching
            ? TextField(
          controller: searchController,
          autofocus: true,
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
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 35),
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
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          final bike = wishlist[index];

          return Container(
            margin:  EdgeInsets.only(bottom: h*0.0144),
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
                    height: h*0.083,
                    width: w*0.23,
                    fit: BoxFit.contain,
                  ),
                ),
               SizedBox(width: w*0.025),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bike["name"]!,
                        style: TextStyle(
                          fontSize: w * 0.040,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: h*0.005),
                      Text(
                        bike["location"]!,
                        style: TextStyle(
                          fontSize: w*0.030,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: h*0.006),
                      Text(
                        bike["price"]!,
                        style: TextStyle(
                          fontSize: h*0.0160,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "delete") {
                          setState(() {
                            wishlist.removeAt(index);
                          });
                        } else if (value == "share") {
                          
                        }
                      },
                      itemBuilder: (context) => [
                          PopupMenuItem(
                          value: "share",
                          child: Row(
                            children: [
                              Icon(Icons.share, size: h*0.022),
                              SizedBox(width: w*0.016),
                              Text("Share"),
                            ],
                          ),
                        ),
                         PopupMenuItem(
                          value: "delete",
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: h*0.022),
                              SizedBox(width: w*0.016),
                              Text("Remove"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
