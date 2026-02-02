
import 'package:bikebuyer/draweritems/ServicesCenterPage.dart';
import 'package:bikebuyer/draweritems/finddealerpage.dart';
import 'package:bikebuyer/homepages/hometabs.dart';
import 'package:bikebuyer/draweritems/Electricbikelist.dart';
import 'package:bikebuyer/draweritems/bikelist.dart';
import 'package:bikebuyer/draweritems/scooterlist.dart';
import 'package:bikebuyer/draweritems/superbikelist.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
                    fontFamily: 'Poppins',
                    fontSize: screenWidth*0.033,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Buy & Sell Bikes",
                  style: TextStyle(color: Colors.white70, fontFamily: 'Poppins',),
                ),
              ],
            ),
          ),
          drawerTile(context, "Home", HomeTabs()),
          drawerTile(context, "Bikes", BikeListPage()),
          drawerTile(context, "Scooters", ScooterListPage()),
          drawerTile(context, "Electric Bikes", ElectricBikeLIst()),
          drawerTile(context, "Super Bikes", SuperBikeList()),
          drawerTile(context, "Find Dealers", Finddealerpage()),
          drawerTile(context, "Find Services Center", ServicesCenterPage()),
          SizedBox(height: screenHeight*0.015,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.044),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Connect with us",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: screenWidth*0.036,
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
                InkWell(
                  onTap: () {
                    openLink("https://facebook.com");
                  },
                  child: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                ),

                InkWell(
                  onTap: () {
                    openLink("https://www.instagram.com/");
                  },
                  child: FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
                ),

                InkWell(
                  onTap: () {
                    openLink("https://twitter.com/");
                  },
                  child: FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
                ),

                InkWell(
                  onTap: () {
                    openLink("https://www.youtube.com/");
                  },
                  child: FaIcon(FontAwesomeIcons.youtube, color: Colors.red),
                ),
              ],
            ),

          ),
          SizedBox(height: screenHeight*0.020),
        ],
      ),
    );
  }

  Future<void> openLink(String url) async {
    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint("Cannot launch $url");
      }
    } catch (e) {
      debugPrint("Error launching url: $e");
    }
  }

  Widget drawerTile(BuildContext context, String title, Widget page) {
    return ListTile(
      visualDensity: VisualDensity(vertical: -1),
      title: Text(title, style: TextStyle(fontSize: 16, fontFamily: 'Poppins',)),
      trailing: Icon(Icons.arrow_forward_ios, size: 15),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
    );
  }
}

