import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class BikeDetailPage extends StatelessWidget {
  final Map bike;

  const BikeDetailPage({super.key, required this.bike});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Stack(
              children: [
                Container(
                  height: h * 0.45,
                  width: double.infinity,
                  color: Colors.white,
                  child: Image.asset(bike["img"], fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 15,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey.shade100,
                      child: Icon(Icons.arrow_back_ios, color: Colors.black),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 74,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey.shade100,
                    child: Icon(Icons.share, color: Colors.black),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 24,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey.shade100,
                    child: Icon(IconlyLight.heart, color: Colors.black),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(19),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bike["name"],
                    style: TextStyle(
                      fontSize: w * 0.048,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    bike["price"],
                    style: TextStyle(
                      fontSize: w * 0.045,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.speed, color: Colors.purple),
                          SizedBox(height: 4),
                          Text(bike["cc"], style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Engine", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.local_gas_station, color: Colors.purple),
                          SizedBox(height: 4),
                          Text(bike["km"], style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Mileage", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.settings_rounded, color: Colors.purple),
                          SizedBox(height: 4),
                          Text("Petrol", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Fuel", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Location', style: TextStyle(color: Colors.grey)),
                        Text('Ayodhya, UP', style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Registration Year', style: TextStyle(color: Colors
                            .grey)),
                        Text('2022', style: TextStyle(fontWeight: FontWeight
                            .w500)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ownership', style: TextStyle(color: Colors.grey)),
                        Text('First Owner',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  SizedBox(height: 28),
                  Container(
                    width: double.infinity,
                    height: h * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Contact Dealer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w * 0.042,
                          fontWeight: FontWeight.w600,
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
  }
}
