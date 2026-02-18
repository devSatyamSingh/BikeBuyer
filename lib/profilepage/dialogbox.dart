import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homepages/hometabs.dart';
import '../page/loginpage.dart';
import '../widget/app_snackbar.dart';

Future<void> showLogoutDialog(
    BuildContext context, {
      required VoidCallback onConfirm,
    }) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout, size: 45, color: Colors.purple),
              SizedBox(height: 12),
              Text(
                "Logout?",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Are you sure you want to logout?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("No"),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onConfirm();
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  // await prefs.clear();

  await prefs.remove("isLoggedIn");
  await prefs.remove("token");
  await prefs.remove("userName");
  await prefs.remove("userPhone");

  AppSnackBar.show(
    context,
    message: "Logged out successfully",
    type: SnackType.success,
  );

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => HomeTabs()),
        (route) => false,
  );
}




