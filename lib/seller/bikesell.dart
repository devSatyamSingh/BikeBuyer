import 'package:flutter/material.dart';
import '../widget/app_snackbar.dart';
import 'bikedetailsform.dart';

class SellBikeLandingPage extends StatefulWidget {
  @override
  State<SellBikeLandingPage> createState() => _SellBikeLandingPageState();
}

class _SellBikeLandingPageState extends State<SellBikeLandingPage> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(w * 0.038),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: h * 0.040),
            Container(
              height: h * 0.285,
              width: double.infinity,
              alignment: Alignment.center,
              child: Container(
                height: h * 0.27,
                width: w * 0.71, // 280
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(w * 0.052),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.shade100.withOpacity(0.30),
                      blurRadius: w * 0.05,
                      offset: Offset(0, h * 0.01),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(w * 0.048),
                  child: Image.asset(
                    "assets/images/sellerlanding.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: h * 0.020),
            Text(
              "Sell Your Bike Easily",
              style: TextStyle(
                fontSize: w * 0.047,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: h * 0.01), // 8
            Text(
              "Get best price from trusted dealers near you",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Poppins',
                fontSize: w * 0.035,
              ),
            ),
            SizedBox(height: h * 0.020), // 30
            stepBy(Icons.edit, "Add Bike Details", h, w),
            stepBy(Icons.camera_alt, "Upload Bike Photos", h, w),
            stepBy(Icons.currency_rupee, "Get Best Price", h, w),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: h * 0.055,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.035),
                  ),
                ),
                onPressed: () {
                  AppSnackBar.show(
                    context,
                    message:
                    "Sell Bike feature is temporarily unavailable. Coming soon 🚀",
                    type: SnackType.warning,
                  );
                },
                child: Text(
                  "Start Selling",
                  style: TextStyle(
                    fontSize: w * 0.045,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget stepBy(IconData icon, String text, double h, double w) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: h * 0.007),
      child: Row(
        children: [
          CircleAvatar(
            radius: w * 0.053,
            backgroundColor: Colors.purple.withOpacity(0.1),
            child: Icon(icon, color: Colors.purple, size: w * 0.055),
          ),
          SizedBox(width: w * 0.04),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: w * 0.035,
            ),
          ),
        ],
      ),
    );
  }
}
