import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../widget/app_snackbar.dart';

class SendInquiryPage extends StatefulWidget {
  final int vehicleId;

  const SendInquiryPage({super.key, required this.vehicleId});

  @override
  State<SendInquiryPage> createState() => _SendInquiryPageState();
}

class _SendInquiryPageState extends State<SendInquiryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController messageController = TextEditingController();

  bool isLoading = false;

  Future<void> sendInquiry() async {
    setState(() => isLoading = true);

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      if (token == null) {
        setState(() => isLoading = false);
        AppSnackBar.show(
          context,
          message: "User not logged in",
          type: SnackType.error,
        );

        return;
      }

      final response = await http.post(
        Uri.parse("https://api.bikesbuyer.com/api/buyer/requestBike"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "vehicleId": widget.vehicleId,
          "message": messageController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      setState(() => isLoading = false);

      if (response.statusCode == 200 && data["success"] == true) {
        AppSnackBar.show(
          context,
          message: data["message"] ?? "Inquiry sent",
          type: SnackType.success,
        );

        Navigator.pop(context);
      } else {
        AppSnackBar.show(
          context,
          message: data["message"] ?? "Failed to send inquiry",
          type: SnackType.error,
        );
      }

    } catch (e) {
      setState(() => isLoading = false);
      AppSnackBar.show(
        context,
        message: "Something went wrong",
        type: SnackType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "Send Inquiry",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: messageController,
                maxLines: 6,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please write a message";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Message to Seller",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                    if (_formKey.currentState!.validate()) {
                      sendInquiry();
                    }
                  },
                  child: isLoading
                      ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text(
                    "Submit Inquiry",
                    style: TextStyle(
                      fontSize: w * 0.041,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
}
