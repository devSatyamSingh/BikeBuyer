import 'package:flutter/material.dart';

import '../homepages/bikedetailpage.dart';
import '../widget/pagenavigationanimation.dart';

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
      SlidePageRoute(page: BikeDetailPage(bike: fullBike),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Electric Bikes", style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins'),),
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 3,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        itemCount: bikes.length,
        itemBuilder: (context, index) {
          final bike = bikes[index];
          return Card(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
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
                            aspectRatio: 16 / 10,
                            child: Image.asset(bike["img"]!, fit: BoxFit.cover),
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
                          bike["name"]!,
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
                          bike["price"]!,
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
                            openBikeDetails(context, bike);
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
                            child: const Center(
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
        },
      ),
    );
  }
}
