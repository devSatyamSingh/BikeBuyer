import 'dart:convert';

import 'package:bikebuyer/homepages/homepage.dart';
import 'package:bikebuyer/homepages/hometabs.dart';
import 'package:bikebuyer/page/loginpage.dart';
import 'package:bikebuyer/page/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../widget/app_snackbar.dart';
import '../widget/pagenavigationanimation.dart';

class OtpVerifyPage extends StatefulWidget {
  final String phone;
  final String? initialOtp;

  OtpVerifyPage({
    required this.phone,
    this.initialOtp,
  });

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  TextEditingController pinController = TextEditingController();
  bool isOtpComplete = false;
  final String validOtp = "1234";
  String otpCode = "";
  bool showError = false;
  String errorText = "";
  int resendTime = 30;
  bool canResend = false;
  Timer? timer;
  String? generatedOtp;
  bool showOtpBanner = false;
  Timer? otpVisibilityTimer;

  @override
  void initState() {
    super.initState();
    startTimer();

    if (widget.initialOtp != null) {
      generatedOtp = widget.initialOtp;
      showOtpBanner = true;

      otpVisibilityTimer = Timer(const Duration(seconds: 10), () {
        if (mounted) {
          setState(() {
            showOtpBanner = false;
          });
        }
      });
    }
  }


  void startTimer() {
    canResend = false;
    resendTime = 30;

    timer?.cancel();

    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (resendTime == 0) {
        setState(() {
          canResend = true;
        });
        t.cancel();
      } else {
        setState(() {
          resendTime--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    otpVisibilityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.of(context).size.width;
    final ScreenHeight = MediaQuery.of(context).size.height;

    const focusedBorderColor = Color(0xff7A34BD);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color(0xff7A34BD);

    final defaultPinTheme = PinTheme(
      width: 58,
      height: 57,
      textStyle: TextStyle(fontSize: 23, color: Color.fromRGBO(30, 60, 87, 1)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor.withOpacity(0.4)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 55, left: 28, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showOtpBanner && generatedOtp != null)
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.notifications_active,
                      color: Colors.purple,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Your OTP is $generatedOtp (valid for 10 sec)",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: ScreenHeight * 0.060),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(IconlyBold.arrow_left),
                ),
                SizedBox(width: 14),
                Text(
                  "OTP Verification",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ScreenWidth * 0.050,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenHeight * 0.010),
            Row(
              children: [
                Text(
                  " OTP has been Sent to +91 ${widget.phone}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Icon(
                    IconlyBold.edit,
                    size: ScreenWidth * 0.040,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenHeight * 0.025),
            Center(
              child: Pinput(
                controller: pinController,
                length: 4,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 13),
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  setState(() {
                    otpCode = value;
                    showError = false;
                    isOtpComplete = value.length == 4;
                  });
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: Color(0xff7A34BD),
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Color(0xff7A34BD)),
                ),
              ),
            ),
            if (showError)
              Padding(
                padding: EdgeInsets.only(top: ScreenHeight * 0.0125),
                child: Center(
                  child: Text(
                    errorText,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              ),
            SizedBox(height: ScreenHeight * 0.035),
            GestureDetector(
              // onTap: isOtpComplete ? () {
              //   if (otpCode.isEmpty) {
              //     setState(() {
              //       showError = true;
              //       errorText = "Please enter OTP";
              //     });
              //     return;
              //   }
              //   if (otpCode.length < 4) {
              //     setState(() {
              //       showError = true;
              //       errorText = "OTP must be 4 digits";
              //     });
              //     return;
              //   }
              //   if (otpCode == validOtp) {
              //
              //     Navigator.pushAndRemoveUntil(
              //       context,
              //       SlidePageRoute(page: HomeTabs()),
              //           (route) => false,
              //     );
              //   } else {
              //     setState(() {
              //       showError = true;
              //       errorText = "Invalid OTP — please try again";
              //     });
              //   }
              // } : null,
              onTap: isOtpComplete
                  ? () {
                      verifyOtp(widget.phone, otpCode);
                    }
                  : null,
              child: Center(
                child: Container(
                  height: ScreenHeight * 0.058,
                  width: ScreenWidth * 0.85,
                  decoration: BoxDecoration(
                    color: isOtpComplete ? null : Colors.grey.shade400,
                    gradient: isOtpComplete
                        ? LinearGradient(
                            colors: [Colors.purple, Colors.deepPurple],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Verify OTP",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: ScreenWidth * 0.045,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Column(
                children: [
                  Text(
                    "Didn't receive OTP?",
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: ScreenHeight * 0.005),
                  canResend
                      ? GestureDetector(
                          onTap: () async {
                            startTimer();
                            await generateAndShowOtp(); // 👈 new OTP
                          },

                          child: Text(
                            "Resend OTP",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: Colors.purple,
                            ),
                          ),
                        )
                      : Text(
                          "Resend available in $resendTime s",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            color: Colors.black54,
                            fontSize: ScreenWidth * 0.030,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyOtp(String phone, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("https://api.bikesbuyer.com/api/user/buyer/verify-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone, "otp": otp}),
      );

      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", data["token"]);
        await prefs.setBool("isLoggedIn", true);
        await prefs.setString("userName", data["name"] ?? "");
        await prefs.setString("userPhone", phone);

        // ✅ SUCCESS SNACKBAR
        AppSnackBar.show(
          context,
          message: "Login Successful 🎉",
          type: SnackType.success,
        );

        if (data["isProfileComplete"] == true) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => HomeTabs()),
            (route) => false,
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => SignUpPage(phone: phone, fromOtp: true),
            ),
          );
        }
      } else {
        // ❌ INVALID OTP
        AppSnackBar.show(
          context,
          message: data["message"] ?? "Invalid OTP",
          type: SnackType.error,
        );
      }
    } catch (e) {
      AppSnackBar.show(
        context,
        message: "Something went wrong",
        type: SnackType.error,
      );
    }
  }

  Future<void> generateAndShowOtp() async {
    final response = await http.post(
      Uri.parse("https://api.bikesbuyer.com/api/user/buyer/send-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": widget.phone}),
    );

    final data = jsonDecode(response.body);

    if (data["success"] == true) {
      setState(() {
        generatedOtp = data["otp"];
        showOtpBanner = true;
      });

      // ✅ Resend success snackbar
      AppSnackBar.show(
        context,
        message: "OTP Resent Successfully",
        type: SnackType.success,
      );

      otpVisibilityTimer?.cancel();
      otpVisibilityTimer = Timer(const Duration(seconds: 10), () {
        setState(() {
          showOtpBanner = false;
        });
      });
    } else {
      AppSnackBar.show(
        context,
        message: data["message"] ?? "Failed to resend OTP",
        type: SnackType.error,
      );
    }
  }
}
