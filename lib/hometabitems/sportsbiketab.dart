import 'package:flutter/material.dart';

import '../homepages/bikedetailpage.dart';
import '../widget/pagenavigationanimation.dart';
import 'filter_vehicalpagetab.dart';

class SportsBikeTab extends StatefulWidget {
  const SportsBikeTab({super.key});

  @override
  State<SportsBikeTab> createState() => _SportsBikeTabState();
}

class _SportsBikeTabState extends State<SportsBikeTab> {
  final List<Map<String, String>> bikes = [
    {
      "name": "Hero HF Deluxe",
      "brand": "Hero",
      "price": "₹59,000",
      "img": "assets/images/honda.jpg",
    },
    {
      "name": "Hero Splendor Plus",
      "brand": "Hero",
      "price": "₹52,000 - 76,437",
      "img": "assets/images/hero1.webp",
    },
    {
      "name": "TVS Sport",
      "brand": "TVS",
      "price": "₹64,000",
      "img": "assets/images/tvs.jpg",
    },
    {
      "name": "TVS Radeon",
      "brand": "TVS",
      "price": "₹80,750 - 96,100",
      "img": "assets/images/tvs.jpg",
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
      SlidePageRoute(page: BikeDetailPage(bike: detailBike)),
    );
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: const FilteredVehiclePage(
        category: "bike",
        subCategoryName: "sports bike",
      ),
    );
  }
}
