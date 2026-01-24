import 'package:bikebuyer/draweritems/OfferPage.dart';
import 'package:bikebuyer/draweritems/ServicesCenterPage.dart';
import 'package:bikebuyer/draweritems/dealernearme.dart';
import 'package:bikebuyer/draweritems/finddealerpage.dart';
import 'package:bikebuyer/page/hometabs.dart';
import 'package:bikebuyer/draweritems/Electricbikelist.dart';
import 'package:bikebuyer/draweritems/bikelist.dart';
import 'package:bikebuyer/draweritems/scooterlist.dart';
import 'package:bikebuyer/draweritems/superbikelist.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: Column(
        children: [
          Container(
            height: screenHeight*0.18,
            width: double.infinity,
            padding: EdgeInsets.only(left: screenWidth*0.078, top: screenHeight*0.048),
            color: Colors.purple,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: screenWidth*0.090),
                ),
                SizedBox(height: screenHeight*0.012),
                Text(
                  "Welcome to BikeBuyer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth*0.034,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Buy & Sell Bikes",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          drawerTile(context, "Home", HomeTabs()),
          drawerTile(context, "Bikes", BikeListPage()),
          drawerTile(context, "Scooters", ScooterListPage()),
          drawerTile(context, "Electric Bikes", ElectricBikeLIst()),
          drawerTile(context, "Super Bikes", SuperBikeList()),
          drawerTile( context, "Offers", OfferPage()),
          drawerTile(context, "Find Dealers", Finddealerpage()),
          drawerTile(context, "Dealer Near Me", DealerNearPage()),
          drawerTile(context, "Find Services Center", ServicesCenterPage()),
          SizedBox(height: screenHeight*0.015,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.044),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Connect with us",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth*0.037,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight*0.011),
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth*0.020),
            padding: EdgeInsets.symmetric(vertical: screenHeight*0.020),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
                FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
                FaIcon(FontAwesomeIcons.youtube, color: Colors.red),
              ],
            ),
          ),
          SizedBox(height: screenHeight*0.020),
        ],
      ),
    );
  }


  Widget drawerTile(BuildContext context, String title, Widget page) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -2),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
      onTap: () {
        Navigator.pop(context); // close drawer
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
    );
  }
}

