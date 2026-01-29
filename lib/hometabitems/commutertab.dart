import 'package:flutter/material.dart';

import '../homepages/bikedetailpage.dart';

class CommuterBikeTab extends StatefulWidget {
  const CommuterBikeTab({super.key});

  @override
  State<CommuterBikeTab> createState() => _CommuterBikeTabState();
}

class _CommuterBikeTabState extends State<CommuterBikeTab> {

  final List<Map<String, String>> bikes = [
    {
      "name": "TVS Sport",
      "brand": "TVS",
      "price": "₹64,000",
      "img": "assets/images/tvs.jpg",
    },
    {
      "name": "Hero Splendor Plus",
      "brand": "Hero",
      "price": "₹52,000 - 76,437",
      "img": "assets/images/hero1.webp",
    },

    {
      "name": "Honda Shine",
      "brand": "Honda",
      "price": "₹79,000",
      "img": "assets/images/honda.jpg",
    },
    {
      "name": "Bajaj Platina",
      "brand": "Bajaj",
      "price": "₹70,000",
      "img": "assets/images/bullet.jpg",
    },
    {
      "name": "TVS Radeon",
      "brand": "TVS",
      "price": "₹80,750 - 96,100",
      "img": "assets/images/tvs.jpg",
    },
    {
      "name": "Hero HF Deluxe",
      "brand": "Hero",
      "price": "₹59,000",
      "img": "assets/images/honda.jpg",
    },
    {
      "name": "Hero Passion Pro",
      "brand": "Hero",
      "price": "₹75,000",
      "img": "assets/images/Rs15.jpg",
    },
  ];
  void openBikeDetails(BuildContext context, Map<String, String> bike) {
    final detailBike = {
      "name": bike["name"],
      "price": bike["price"],
      "brand": bike["brand"],
      "cc": "125 cc",
      "km": "55 kmpl",
      "runKm": "8,000 km",
      "fuel": "Petrol",
      "regYear": "2021",
      "owner": "1st Owner",
      "rto": "UP32",
      "location": "Ayodhya, UP",
      "mileage": "55 kmpl",
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
      MaterialPageRoute(
        builder: (_) => BikeDetailPage(bike: detailBike),
      ),
    );
  }

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
          return GestureDetector(
            onTap: () {
              openBikeDetails(context, bike);
            },
            child: Container(
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
            ),
          );
        },
      ),
    );
  }
}

