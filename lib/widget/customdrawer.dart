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
          drawerTile("Home"),
          drawerTile("Bikes"),
          drawerTile("Scooters"),
          drawerTile("Electric Bikes"),
          drawerTile("Super Bikes"),
          drawerTile("Offers"),
          drawerTile("Find Dealers"),
          drawerTile("Dealer Near Me"),
          drawerTile("Find Services Center"),
          drawerTile("Login"),
          SizedBox(height: screenHeight*0.020,),
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
          SizedBox(height: screenHeight*0.013),
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


  Widget drawerTile(String title) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
