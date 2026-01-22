import 'package:bikebuyer/page/otppage.dart';
import 'package:bikebuyer/page/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  bool isPhoneValid = false;



  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.of(context).size.width;
    final ScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: ScreenHeight*0.070, left: ScreenWidth*0.040, right: ScreenWidth*0.040),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ScreenHeight * 0.05),
              SizedBox(height: ScreenHeight * 0.03),
              Text(
                "Login or Register",
                style: TextStyle(
                  fontSize: ScreenWidth * 0.05,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text("Enter your mobile number to get OTP and login securely.", style: TextStyle(fontSize: ScreenWidth * 0.03, color: Colors.grey.shade600),),
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
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: ScreenWidth*0.014),
                          Expanded(
                            child: TextFormField(
                              controller: phoneController,
                              cursorColor: Colors.cyanAccent,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 14),
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
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OtpVerifyPage(phone: phoneController.text),
                      ),
                    );
                  }
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
                      colors: [
                        Color(0xff6BCFD1),
                        Color(0xff86C7E7),
                        Color(0xff86C7E7),
                      ],
                    )
                   : null,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Send OTP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenWidth * 0.045,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TextStyle(color: Colors.black),),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  }, child: Text('Sign up', style: TextStyle(color: Colors.black87),))
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
