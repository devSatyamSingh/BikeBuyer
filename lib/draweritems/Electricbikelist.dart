import 'package:flutter/material.dart';

import '../homepages/bikedetailpage.dart';

class ElectricBikeLIst extends StatefulWidget {
  const ElectricBikeLIst({super.key});

  @override
  State<ElectricBikeLIst> createState() => _ElectricBikeLIstState();
}

class _ElectricBikeLIstState extends State<ElectricBikeLIst> {
  final List<Map<String, String>> bikes = [
    {
      "name": "Pulsar 150 cc",
      "price": "₹1.30 Lakh",
      "img": "assets/images/pulsar1.png",
    },
    {
      "name": "Yamaha R15 V4",
      "price": "₹1.82 Lakh",
      "img": "assets/images/R15.webp",
    },
    {
      "name": "Hero Splendor Plus",
      "price": "₹82,000 Lakh",
      "img": "assets/images/hero1.webp",
    },
    {
      "name": "KTM Duke 250",
      "price": "₹2.82 Lakh",
      "img": "assets/images/ktm2.webp",
    },
    {
      "name": "Yamaha R15 V4",
      "price": "₹1.82 Lakh",
      "img": "assets/images/R15.webp",
    },
    {
      "name": "Honda SHine ",
      "price": "₹72,000 Lakh",
      "img": "assets/images/honda.jpg",
    },
  ];

  void openBikeDetails(BuildContext context, Map<String, String> bike) {
    final fullBike = {
      "name": bike["name"],
      "price": bike["price"],
      "cc": "150 cc",
      "km": "45 kmpl",
      "fuel": "Petrol",
      "runKm": "8,000 km",
      "regYear": "2021",
      "owner": "1st Owner",
      "rto": "UP32",
      "location": "Ayodhya, UP",
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
        builder: (_) => BikeDetailPage(bike: fullBike),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Electric Bikes", style: TextStyle(fontWeight: FontWeight.w500),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(14),
        itemCount: bikes.length,
        itemBuilder: (context, index) {
          final bike = bikes[index];
          return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(bottom: 20, left: 13, right: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  bike["img"]!,
                  height: 280,
                  width: 380,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.all(19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bike["name"]!,
                        style:TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text(
                        bike["price"]!,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 14),
                      GestureDetector(
                        onTap: () {
                          openBikeDetails(context, bike);
                        },
                        child: Container(
                          height: 50,
                          width: 360,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.purple
                          ),
                          child: Center(child: Text("View Bike Details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),)),
                        ),
                      )
                    ],
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
