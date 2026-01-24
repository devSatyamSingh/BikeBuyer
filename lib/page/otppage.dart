import 'package:bikebuyer/page/homepage.dart';
import 'package:bikebuyer/page/hometabs.dart';
import 'package:bikebuyer/page/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

class OtpVerifyPage extends StatefulWidget {
  final String phone;
  OtpVerifyPage({required this.phone});

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

  @override
  void initState() {
    super.initState();
    startTimer();
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
      textStyle: const TextStyle(
        fontSize: 23,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
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
            SizedBox(height: ScreenHeight*0.060),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(IconlyBold.arrow_left)),
                SizedBox(width: 14),
                Text(
                  "OTP Verification",
                  style: TextStyle(
                    fontSize: ScreenWidth*0.052,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenHeight*0.010),
            Row(
              children: [
                Text(
                  " OTP has been Sent to +91 ${widget.phone}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.grey.shade700),
                ),
                SizedBox(width: 8),
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Icon(IconlyBold.edit,
                        size: ScreenWidth*0.040,
                        color: Colors.black87)),
              ],
            ),
            SizedBox(height: ScreenHeight*0.025),
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
                padding: EdgeInsets.only(top: ScreenHeight*0.0125),
                child: Center(
                  child: Text(
                    errorText,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              ),
            SizedBox(height: ScreenHeight*0.035),
            GestureDetector(
              onTap: isOtpComplete ? () {
                if (otpCode.isEmpty) {
                  setState(() {
                    showError = true;
                    errorText = "Please enter OTP";
                  });
                  return;
                }
                if (otpCode.length < 4) {
                  setState(() {
                    showError = true;
                    errorText = "OTP must be 4 digits";
                  });
                  return;
                }
                if (otpCode == validOtp) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HomeTabs()),
                  );
                } else {
                  setState(() {
                    showError = true;
                    errorText = "Invalid OTP — please try again";
                  });
                }
              } : null,
              child: Center(
                child: Container(
                  height: ScreenHeight * 0.058,
                  width: ScreenWidth * 0.85,
                  decoration: BoxDecoration(
                    color: isOtpComplete
                        ? null
                        : Colors.grey.shade400,
                    gradient: isOtpComplete
                        ? LinearGradient(
                      colors: [
                        Color(0xffCA48CE),
                        Color(0xff7A34BD),
                        Color(0xffC98BBE),
                      ],
                    )
                    : null,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Verify OTP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenWidth * 0.045,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 7),
            Center(
                child: Text('otp 1234 hai',
                    style:
                    TextStyle(fontSize: 10, color: Colors.grey))),
            SizedBox(height: 15),
            Center(
              child: Column(
                children: [
                  Text(
                    "Didn't receive OTP?",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: ScreenHeight*0.005),
                  canResend
                      ? GestureDetector(
                    onTap: () {
                      startTimer();
                    },
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.purple),
                    ),
                  )
                      : Text(
                    "Resend available in $resendTime s",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                        fontSize: ScreenWidth*0.030),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
