import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DealerListPage extends StatelessWidget {
  final String brandName;

  const DealerListPage({super.key, required this.brandName});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    final List dealers = [
      {
        "name": "Shiv Motors",
        "address": "Civil Lines, Ayodhya",
        "phone": "9876543210",
      },
      {
        "name": "Ravi Auto Wheels",
        "address": "Near Bus Stand, Ayodhya",
        "phone": "9123456789",
      },
      {
        "name": "Singh Bike Zone",
        "address": "Faizabad Road, Ayodhya",
        "phone": "9988776655",
      },
    ];

    Future<void> callDealer(String phone) async {
      final Uri uri = Uri(scheme: 'tel', path: phone);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch dialer';
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "$brandName Dealers",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            fontSize: w * 0.045,
          ),
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 3,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(w * 0.04),
        itemCount: dealers.length,
        itemBuilder: (context, index) {
          final dealer = dealers[index];
          return Container(
            margin: EdgeInsets.only(bottom: h * 0.022),
            padding: EdgeInsets.all(w * 0.053),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(w * 0.05),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: w * 0.015,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dealer["name"],
                  style: TextStyle(
                    fontSize: w * 0.044,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: h * 0.008),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: w * 0.040,
                      color: Colors.grey,
                    ),
                    SizedBox(width: w * 0.01),
                    Expanded(
                      child: Text(
                        dealer["address"],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: w * 0.033,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.02),
                SizedBox(
                  width: double.infinity,
                  height: h * 0.05,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w * 0.04),
                      ),
                    ),
                    onPressed: () {
                      callDealer(dealer["phone"]);
                    },
                    icon: Icon(
                      Icons.call,
                      size: w * 0.045,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Call Dealer",
                      style: TextStyle(
                        fontSize: w * 0.04,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
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
