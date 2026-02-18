import 'dart:convert';

import 'package:bikebuyer/homepages/homepage.dart';
import 'package:bikebuyer/homepages/hometabs.dart';
import 'package:bikebuyer/page/loginpage.dart';
import 'package:bikebuyer/page/otppage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';
import 'package:country_state_picker/country_state_picker.dart';
import 'package:country_state_picker/components/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/customTextfield.dart';
import 'package:country_state_picker/country_state_picker.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../widget/pagenavigationanimation.dart';

class SignUpPage extends StatefulWidget {
  final String? phone;
  final bool fromOtp; // 🔥 NEW FLAG

  const SignUpPage({
    super.key,
    this.phone,
    required this.fromOtp,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  bool isSubmitted = false;
  bool isFormValid = false;
  final FocusNode cityFocus = FocusNode();

  void checkForm() {
    final phone = widget.phone ?? phoneController.text;

    final valid = nameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        phone.length == 10 &&
        cityController.text.trim().isNotEmpty;

    setState(() {
      isFormValid = valid;
    });
  }



  @override
  void initState() {
    super.initState();
    if (widget.phone != null) {
      phoneController.text = widget.phone!;
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: screenHeight * 0.065,
          left: screenWidth * 0.020,
          right: screenWidth * 0.030,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(IconlyBold.arrow_left),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(height: screenHeight * 0.002),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: screenWidth * 0.047,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Create your account to explore bikes easily",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.grey.shade600,
                    fontSize: screenWidth * 0.032,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
              satyamField(
                label: "Name",
                hint: "Enter your name",
                icon: IconlyBold.user_2,
                controller: nameController,
                onChanged: (_) {
                  setState(() {
                    isSubmitted = false;
                  });
                  checkForm();
                },
                validator: (v) {
                  if (!isSubmitted) return null;
                  if (v == null || v.isEmpty) {
                    return "Name required";
                  }
                  return null;
                },
              ),
              satyamField(
                label: "Email",
                hint: "Enter Your email",
                icon: IconlyBold.user_2,
                controller: emailController,
                keyboard: TextInputType.emailAddress,
                onChanged: (_) => checkForm(),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Email required";
                  if (!v.contains("@")) return "Enter valid email";
                  return null;
                },

              ),
              SizedBox(height: screenHeight * 0.016),
              satyamField(
                label: "Phone",
                hint: "Enter your phone",
                icon: IconlyBold.call,
                controller: phoneController,
                keyboard: TextInputType.number,
                maxLength: 10,
                onChanged: (_) => checkForm(),
                validator: (v) {
                  if (!isSubmitted) return null;
                  if (v == null || v.isEmpty) {
                    return "Enter valid 10 digit number";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 27),
                child: Text(
                  'City',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  height: 53,
                  width: 375,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: GooglePlaceAutoCompleteTextField(
                    focusNode: cityFocus,
                    textEditingController: cityController,
                    googleAPIKey: "AIzaSyDJ7qpCw3pf-zN-fY1DqWZ4HDK0Dmi62C4",
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    inputDecoration: InputDecoration(
                      hintText: "Enter your city",
                      hintStyle: TextStyle(fontFamily: 'Poppins'),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          getCurrentLocation();
                        },
                        child: Icon(Icons.my_location, color: Colors.black87),
                      ),
                      prefixIcon: Icon(
                        Icons.location_pin,
                        color: Colors.purple,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,

                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),

                    countries: ["in"],
                    isLatLngRequired: false,
                    getPlaceDetailWithLatLng: (prediction) {},

                    itemClick: (prediction) {
                      cityController.text = prediction.description!;
                      cityController.selection = TextSelection.fromPosition(
                        TextPosition(offset: prediction.description!.length),
                      );
                      checkForm();
                    },
                  ),
                ),
              ),
              if (isSubmitted && cityController.text.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Text(
                    "City required",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  // onTap: () {
                  //   setState(() {
                  //     isSubmitted = true;
                  //   });
                  //   if (_formKey.currentState!.validate() &&
                  //       cityController.text.isNotEmpty) {
                  //     Navigator.push(
                  //       context,
                  //       SlidePageRoute(page: HomeTabs()),
                  //     );
                  //   }
                  // },
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      buyerSignup();
                    }
                  },
                  child: Container(
                    height: screenHeight * 0.054,
                    width: screenWidth * 0.80,
                    decoration: BoxDecoration(
                      color: isFormValid ? null : Colors.grey.shade400,
                      gradient: isFormValid
                          ? LinearGradient(
                              colors: [Colors.purple, Colors.deepPurple],
                            )
                          : null,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.048,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          SlidePageRoute(page: LoginPage()),
                        );
                      },
                      child: Container(
                        height: 28,
                        width: 72,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.purple,
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks[0];
    String city = place.locality ?? "";
    String state = place.administrativeArea ?? "";

    setState(() {
      cityController.text = "$city, $state";
      checkForm();
    });
  }

  Future<void> buyerSignup() async {

    try {

      final response = await http.post(
        Uri.parse("https://api.bikesbuyer.com/api/user/buyer/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": nameController.text.trim(),
          "phone": widget.phone ?? phoneController.text.trim(),
          "email": emailController.text.trim(),
          "city": cityController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (data["success"] == true) {

        SharedPreferences prefs = await SharedPreferences.getInstance();

        // 🔐 SAFE TOKEN SAVE
        if (data.containsKey("token") && data["token"] != null) {
          await prefs.setString("token", data["token"]);
        }

        await prefs.setBool("isLoggedIn", true);
        await prefs.setString("userName", nameController.text.trim());
        await prefs.setString(
          "userPhone",
          widget.phone ?? phoneController.text.trim(),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomeTabs()),
              (route) => false,
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Signup failed")),
        );
      }

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong")),
      );

    }
  }





}
