
import 'package:bikebuyer/homepages/hometabs.dart';
import 'package:bikebuyer/page/loginpage.dart';
import 'package:bikebuyer/page/signuppage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeTabs()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/videos/bike_splash.gif", width: 300, fit: BoxFit.contain,),
      ),
    );
  }
}

