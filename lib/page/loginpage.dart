import 'dart:convert';

import 'package:bikebuyer/page/otppage.dart';
import 'package:bikebuyer/page/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';

import '../widget/app_snackbar.dart';
import '../widget/pagenavigationanimation.dart';

class LoginPage extends StatefulWidget {
  final String? prefilledPhone;

  const LoginPage({super.key, this.prefilledPhone});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  bool isPhoneValid = false;

  @override
  void initState() {
    super.initState();
    if (widget.prefilledPhone != null) {
      phoneController.text = widget.prefilledPhone!;
      isPhoneValid = widget.prefilledPhone!.length == 10;
    }
  }


  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final ScreenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: ScreenHeight * 0.070,
          left: ScreenWidth * 0.040,
          right: ScreenWidth * 0.040,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ScreenHeight * 0.09),
              Text(
                "Login or Register",
                style: TextStyle(
                  fontSize: ScreenWidth * 0.05,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Enter your mobile number to get OTP and login securely.",
                style: TextStyle(
                  fontSize: ScreenWidth * 0.03,
                  fontFamily: 'Poppins',
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: ScreenHeight * 0.016),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: ScreenWidth * 0.85,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400.withAlpha(40),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  "+91",
                                  style: TextStyle(
                                    fontSize: ScreenWidth * 0.04,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: ScreenWidth * 0.014),
                          Expanded(
                            child: TextFormField(
                              controller: phoneController,
                              cursorColor: Colors.purple,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                counterText: "",
                              ),
                              onChanged: (value) {
                                setState(() {
                                  isPhoneValid = value.length == 10;
                                });
                              },

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Mobile number required";
                                }
                                if (value.length != 10) {
                                  return "Mobile number must be 10 digits";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenHeight * 0.04),
              InkWell(
                onTap: isPhoneValid
                    ? () {
                  sendOtp(phoneController.text);
                }
                    : null,
                child: Container(
                  height: ScreenHeight * 0.058,
                  width: ScreenWidth * 0.85,
                  decoration: BoxDecoration(
                    color: isPhoneValid
                        ? null
                        : Colors.grey.shade400, // grey jab empty ho

                    gradient: isPhoneValid
                        ? LinearGradient(
                      colors: [Colors.purple, Colors.deepPurple],
                    )
                        : null,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Send OTP",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: ScreenWidth * 0.045,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendOtp(String phone) async {
    try {
      final response = await http.post(
        Uri.parse("https://api.bikesbuyer.com/api/user/buyer/send-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone}),
      );

      final data = jsonDecode(response.body);

      if (data["success"] == true) {

        AppSnackBar.show(
          context,
          message: data["message"] ?? "OTP Send Successful",
          type: SnackType.success,
        );

        String? otpFromServer = data["otp"]; // 👈 OTP lo

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpVerifyPage(
              phone: phone,
              initialOtp: otpFromServer, // 👈 pass karo
            ),
          ),
        );

      } else {
        AppSnackBar.show(
          context,
          message: data["message"] ?? "Failed to send OTP",
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

}
