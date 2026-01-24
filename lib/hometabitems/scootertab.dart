import 'package:flutter/material.dart';

class ScooterTab extends StatefulWidget {
  const ScooterTab({super.key});

  @override
  State<ScooterTab> createState() => _ScooterTabState();
}

class _ScooterTabState extends State<ScooterTab> {
  final List<Map<String, String>> bikes = [
    {
      "name": "Hero Splendor Plus",
      "price": "₹52,000 - 76,437",
      "img": "assets/images/hero1.webp",
    },
    {
      "name": "TVS Radeon",
      "price": "₹80,750 - 96,100",
      "img": "assets/images/tvs.jpg",
    },
    {
      "name": "Honda Shine",
      "price": "₹79,000",
      "img": "assets/images/honda.jpg",
    },
    {
      "name": "Bajaj Platina",
      "price": "₹70,000",
      "img": "assets/images/bullet.jpg",
    },
    {
      "name": "Hero HF Deluxe",
      "price": "₹59,000",
      "img": "assets/images/honda.jpg",
    },
    {
      "name": "TVS Sport",
      "price": "₹64,000",
      "img": "assets/images/tvs.jpg",
    },
    {
      "name": "Hero Passion Pro",
      "price": "₹75,000",
      "img": "assets/images/Rs15.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body:  ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: bikes.length,
        itemBuilder: (context, index) {
          var bike = bikes[index];
          return Container(
            width: w * 0.57,
            margin: const EdgeInsets.only(right: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 2),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: h * 0.19,
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(bike["img"]!, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    bike["name"]!,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                  child: Text(
                    bike["price"]!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "View Bikes Details",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
