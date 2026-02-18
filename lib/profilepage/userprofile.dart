import 'package:bikebuyer/profilepage/Profilesettings.dart';
import 'package:bikebuyer/profilepage/aboutuspage.dart';
import 'package:bikebuyer/profilepage/privacy_policy.dart';
import 'package:bikebuyer/profilepage/terms_condi.dart';
import 'package:bikebuyer/profilepage/dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../page/loginpage.dart';
import '../widget/app_snackbar.dart';
import '../widget/loderanimation.dart';
import '../widget/pagenavigationanimation.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  String userName = "";
  String userNumber = "";
  bool isLoggedIn = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool loginStatus = prefs.getBool("isLoggedIn") ?? false;

    if (loginStatus) {
      userName = prefs.getString("userName") ?? "";
      userNumber = prefs.getString("userPhone") ?? "";
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }

    setState(() {
      isLoading = false; // 🔥 now UI can render
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SegmentLoader(),
            SizedBox(height: 20),
            Text(
              "Loading Profile...",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      );
    }

    // 🔥 2️⃣ Login check ke baad hi UI decide hoga
    return isLoggedIn
        ? LoggedInProfileUI(
      userName: userName,
      userNumber: userNumber,
      onLogout: () async {
        await logout(context);
      },
    )
        : LoggedOutProfileUI(
      onLoginSuccess: () {
        loadUserData();
      },
    );
  }
}



class LoggedOutProfileUI extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoggedOutProfileUI({super.key, required this.onLoginSuccess});

  @override
  State<LoggedOutProfileUI> createState() => _LoggedOutProfileUIState();
}

class _LoggedOutProfileUIState extends State<LoggedOutProfileUI> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: w * 0.14,
                backgroundColor: Colors.purple.shade100.withAlpha(120),
                child: Icon(
                  IconlyLight.profile,
                  size: w * 0.16,
                  color: Colors.purple,
                ),
              ),

              SizedBox(height: h * 0.03),

              Text(
                "Unlock Your Bike Journey 🚀",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: w * 0.055,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),

              SizedBox(height: 10),

              Text(
                "Login to save bikes, contact dealers\nand manage your wishlist easily.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontFamily: 'Poppins',
                  height: 1.5,
                ),
              ),

              SizedBox(height: h * 0.04),

              SizedBox(
                width: double.infinity,
                height: h * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    );

                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                    bool loginStatus =
                        prefs.getBool("isLoggedIn") ?? false;

                    if (loginStatus) {
                      AppSnackBar.show(
                        context,
                        message: "Login successful 🎉",
                        type: SnackType.success,
                      );
                      widget.onLoginSuccess();
                    }

                  },
                  child: Text(
                    "Login / Signup",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: w * 0.042,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              Text(
                "Join thousands of bike buyers today!",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: w * 0.032,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class LoggedInProfileUI extends StatelessWidget {
  final String userName;
  final String userNumber;
  final VoidCallback onLogout;

  const LoggedInProfileUI({
    super.key,
    required this.userName,
    required this.userNumber,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: w * 0.11,
              backgroundColor: Colors.purple.shade100.withAlpha(110),
              child: Text(
                userName.isNotEmpty
                    ? userName[0].toUpperCase()
                    : "?",
                style: TextStyle(
                  fontSize: w * 0.13,
                  color: Colors.purple,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ),

            SizedBox(height: h * 0.01),

            Text(
              userName,
              style: TextStyle(
                fontSize: w * 0.045,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),

            Text(
              "+91 $userNumber",
              style: const TextStyle(
                color: Colors.black54,
                fontFamily: 'Poppins',
              ),
            ),

            SizedBox(height: h * 0.03),

            profileTile(
              context: context,
              icon: IconlyLight.profile,
              title: "Profile Settings",
              onTap: () async {

                final result = await Navigator.push(
                  context,
                  SlidePageRoute(
                    page: ProfileSettings(
                      name: userName,
                      number: userNumber,
                    ),
                  ),
                );

                if (result != null) {

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString("userName", result["name"]);
                  await prefs.setString("userPhone", result["number"]);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => UserProfile()),
                  );
                }
              },
            ),


            profileTile(
              context: context,
              icon: IconlyLight.document,
              title: "Terms & Conditions",
              onTap: () {
                Navigator.push(
                  context,
                  SlidePageRoute(page: TermsConditionPage()),
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
                  SlidePageRoute(page: PrivacyPolicyPage()),
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
                  SlidePageRoute(page: AboutUsPage()),
                );
              },
            ),

            profileTile(
              context: context,
              icon: IconlyLight.logout,
              title: "Logout",
              isLogout: true,
              onTap: () {
                showLogoutDialog(
                  context,
                  onConfirm: () async {
                    await logout(context);
                  },
                );
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
  final w = MediaQuery.of(context).size.width;
  final h = MediaQuery.of(context).size.height;

  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: h * 0.015),
      padding: EdgeInsets.symmetric(vertical: h * 0.015, horizontal: w * 0.04),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(w * 0.06),
      ),
      child: Row(
        children: [
          Icon(icon, color: isLogout ? Colors.red : Colors.black),
          SizedBox(width: w * 0.03),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: isLogout ? Colors.red : Colors.black,
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    ),
  );
}
