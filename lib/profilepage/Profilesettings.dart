import 'package:flutter/material.dart';
import 'editprofile.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  String userName = "Satyam";
  String userNumber = "7860701843";
  bool showFullNumber = false;

  String get maskedNumber {
    if (showFullNumber) return "+91 $userNumber";
    return "+91 ******${userNumber.substring(userNumber.length - 4)}";
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Settings"),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.all(w * 0.05),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            showFullNumber = !showFullNumber;
                          });
                        },
                        child: const Text(
                          "View Details",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h*0.0120),
                  Row(
                    children: [
                      Icon(Icons.call, size: h*0.020),
                      SizedBox(width: w*0.018),
                      Text(
                        maskedNumber,
                        style: TextStyle(fontSize: w*0.037),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: h*0.020),
            InkWell(
              onTap: () async {
                final result = await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => EditProfilePage(
                      name: userName,
                      number: userNumber,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    userName = result["name"];
                    userNumber = result["number"];
                    showFullNumber = false;
                  });
                }
              },
              child: Container(
                width: w*0.60,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
