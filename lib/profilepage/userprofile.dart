import 'package:bikebuyer/profilepage/Profilesettings.dart';
import 'package:bikebuyer/profilepage/aboutuspage.dart';
import 'package:bikebuyer/profilepage/editprofile.dart';
import 'package:bikebuyer/profilepage/privacy_policy.dart';
import 'package:bikebuyer/profilepage/terms_condi.dart';
import 'package:bikebuyer/profilepage/dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.purple.shade100.withOpacity(0.3),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.0065),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.2),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: screenWidth * 0.11,
                backgroundColor: Colors.grey.shade200,
                child: Icon(
                  Icons.person,
                  size: screenWidth * 0.16,
                  color: Colors.purple,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.009),
            Text(
              "Satyam Singh",
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Text(
              "+91 9161440593",
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: screenHeight * 0.0200),
            profileTile(
              context: context,
              icon: IconlyLight.profile,
              title: "Profile Settings",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileSettings(),
                  ),
                );
              },
            ),
            profileTile(
              context: context,
              icon: IconlyLight.document,
              title: "Terms & Conditions",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsConditionPage(),
                  ),
                );
              },
            ),
            profileTile(
              context: context,
              icon: IconlyLight.shield_done,
              title: "Privacy Policy",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyPage(),
                  ),
                );
              },
            ),
            profileTile(
              context: context,
              icon: IconlyLight.activity,
              title: "About Us",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUsPage(),
                  ),
                );
              },
            ),
            profileTile(
              context: context,
              icon: IconlyLight.logout,
              title: "Logout",
              isLogout: true,
              onTap: () {
                showLogoutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget profileTile({
  required BuildContext context,
  required IconData icon,
  required String title,
  bool isLogout = false,
  required VoidCallback onTap,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(
        bottom: screenHeight * 0.015,
      ),
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.015,
        horizontal: screenWidth * 0.04,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(
          screenWidth * 0.06,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isLogout ? Colors.red : Colors.black,
            size: screenWidth * 0.050,
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.038,
                fontWeight: FontWeight.w500,
                color: isLogout ? Colors.red : Colors.black,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: screenWidth * 0.04,
            color: Colors.grey,
          ),
        ],
      ),
    ),
  );
}
