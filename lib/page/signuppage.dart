import 'package:bikebuyer/homepages/homepage.dart';
import 'package:bikebuyer/homepages/hometabs.dart';
import 'package:bikebuyer/page/loginpage.dart';
import 'package:bikebuyer/page/otppage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:country_state_picker/country_state_picker.dart';
import 'package:country_state_picker/components/index.dart';
import '../widget/customTextfield.dart';
import 'package:country_state_picker/country_state_picker.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../widget/pagenavigationanimation.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  bool isSubmitted = false;
  bool isFormValid = false;
  final FocusNode cityFocus = FocusNode();

  void checkForm() {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        phoneController.text.length == 10 &&
        cityController.text.isNotEmpty) {
      setState(() {
        isFormValid = true;
      });
    } else {
      setState(() {
        isFormValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.of(context).size.width;
    final ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: ScreenHeight * 0.065,
          left: ScreenWidth * 0.020,
          right: ScreenWidth * 0.030,
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
              SizedBox(height: ScreenHeight * 0.002),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ScreenWidth * 0.047,
                    fontWeight: FontWeight.w600,
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
                    fontSize: ScreenWidth * 0.032,
                  ),
                ),
              ),
              SizedBox(height: ScreenHeight * 0.025),
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
                  if (!isSubmitted) return null;
                  if (v == null || v.isEmpty) {
                    return "Email required";
                  }
                  return null;
                },
              ),
              satyamField(
                label: "Password",
                hint: "Create a password",
                icon: IconlyBold.lock,
                controller: passwordController,
                obscure: true,
                onChanged: (_) => checkForm(),
                validator: (v) {
                  if (!isSubmitted) return null;
                  if (v == null || v.isEmpty) {
                    return "Password required";
                  }
                  return null;
                },
              ),
              SizedBox(height: ScreenHeight * 0.016),
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
                      suffixIcon: GestureDetector(
                        onTap: () {
                          getCurrentLocation();
                        },
                        child: Icon(Icons.my_location, color: Colors.black87),
                      ),
                      prefixIcon: Icon(Icons.location_pin, color: Colors.deepPurple),

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
                    style: TextStyle(color: Colors.red, fontSize: 12, fontFamily: 'Poppins',),
                  ),
                ),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isSubmitted = true;
                    });
                    if (_formKey.currentState!.validate() &&
                        cityController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        SlidePageRoute(page: HomeTabs()),
                      );
                    }
                  },
                  child: Container(
                    height: ScreenHeight * 0.054,
                    width: ScreenWidth * 0.80,
                    decoration: BoxDecoration(
                      color: isFormValid ? null : Colors.grey.shade400,
                      gradient: isFormValid
                          ? LinearGradient(
                              colors: [
                                Colors.purple, Colors.deepPurple
                              ],
                            )
                          : null,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenWidth * 0.048,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: ScreenHeight * 0.005),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    'Already have an account? Sign in',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
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

    // Get position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Convert lat lng to address
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
}
