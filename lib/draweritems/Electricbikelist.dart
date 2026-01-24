import 'package:flutter/material.dart';

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
      "name": "KTM Duke 250",
      "price": "₹2.82 Lakh",
      "img": "assets/images/ktm2.webp",
    },
    {
      "name": "Hero Splendor Plus",
      "price": "₹82,000 Lakh",
      "img": "assets/images/hero1.webp",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Electric Bikes"),
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
                  fit: BoxFit.cover,
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
                      Container(
                        height: 50,
                        width: 360,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.purple
                        ),
                        child: Center(child: Text("View Bike Details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),)),
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
