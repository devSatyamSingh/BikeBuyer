import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 170,
            width: double.infinity,
            padding: EdgeInsets.only(left: 30, top: 35),
            color: Colors.cyan,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 35),
                ),
                SizedBox(height: 10),
                Text(
                  "Welcome to BikeBuyer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
          SizedBox(height: 30,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Connect with us",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FaIcon(FontAwesomeIcons.facebook,
                    color: Colors.blue),
                FaIcon(FontAwesomeIcons.instagram,
                    color: Colors.pink),
                FaIcon(FontAwesomeIcons.twitter,
                    color: Colors.lightBlue),
                FaIcon(FontAwesomeIcons.youtube,
                    color: Colors.red),
              ],
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  // 🔥 Reusable tile
  Widget drawerTile(String title) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
