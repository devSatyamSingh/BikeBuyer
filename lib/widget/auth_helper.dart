import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../page/loginpage.dart';

Future<bool> requireLogin(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

  if (!isLoggedIn) {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
    );

    return false;
  }

  return true;
}
