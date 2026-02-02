import 'package:flutter/material.dart';
import 'editprofile.dart';

class ProfileSettings extends StatefulWidget {
  final String name;
  final String number;

  const ProfileSettings({
    super.key,
    required this.name,
    required this.number,
  });

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  late String userName;
  late String userNumber;
  bool showFullNumber = false;

  @override
  void initState() {
    super.initState();
    userName = widget.name;
    userNumber = widget.number;
  }

  String get maskedNumber {
    if (showFullNumber) return "+91 $userNumber";
    return "+91 ******${userNumber.substring(userNumber.length - 4)}";
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Profile Settings", style: TextStyle(fontFamily: 'Poppins',),),
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 3,
      ),
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
                          fontSize: w * 0.044,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            showFullNumber = !showFullNumber;
                          });
                        },
                        child: Text(
                          "View Contact",
                          style: TextStyle(
                            fontFamily: 'Poppins',
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
                        style: TextStyle(fontSize: w*0.037, fontFamily: 'Poppins',),
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
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditProfilePage(
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

                  Navigator.pop(context, {
                    "name": userName,
                    "number": userNumber,
                  });
                }
              },
                child: Container(
                width: w*0.58,
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
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
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
