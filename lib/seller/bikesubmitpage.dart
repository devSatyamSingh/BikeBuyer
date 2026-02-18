import 'dart:io';
import 'package:flutter/material.dart';
import '../modal/sellbikemodel.dart';
import '../seller/sellbikestore.dart';

class BikeReviewSubmitPage extends StatefulWidget {
  final Map<String, String> bikeDetails;
  final List<File> images;

  const BikeReviewSubmitPage({
    super.key,
    required this.bikeDetails,
    required this.images,
  });

  @override
  State<BikeReviewSubmitPage> createState() => _BikeReviewSubmitPageState();
}

class _BikeReviewSubmitPageState extends State<BikeReviewSubmitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Review & Submit"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _stepHeader(),
            SizedBox(height: 16),
            _sectionHeader(
              title: "Bike Details",
              onEdit: () {
                Navigator.pop(context); // back to edit
              },
            ),
            _detailsCard(),
            SizedBox(height: 20),
            _sectionHeader(title: "Price & Location"),
            _infoRow("City", widget.bikeDetails["city"] ?? ""),
            _infoRow("Expected Price", "₹${widget.bikeDetails["price"]}"),
             SizedBox(height: 20),
            _sectionHeader(
              title: "Uploaded Photos",
              onEdit: () {
                Navigator.pop(context);
              },
            ),
            _photoGrid(),
            SizedBox(height: 24),
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (_) {},
                  activeColor: Colors.purple,
                ),
                Expanded(
                  child: Text(
                    "I confirm that all details and photos are correct",
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  final bike = SellBikeModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    brand: widget.bikeDetails["brand"] ?? "",
                    model: widget.bikeDetails["model"] ?? "",
                    price: "₹${widget.bikeDetails["price"]}",
                    status: "Pending",
                    date: DateTime.now(),
                    images: widget.images,
                  );

                  SellBikeStore.addBike(bike);
                  _showSuccess(context);
                },
                child: Text(
                  "Submit for Verification",
                  style: TextStyle(
                    fontSize: 16,
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

  /// ================= UI COMPONENTS =================

  Widget _stepHeader() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.purple,
            child: Text("3", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 10),
          Text(
            "Step 3 of 3 · Review & Submit",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader({required String title, VoidCallback? onEdit}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (onEdit != null)
          TextButton.icon(
            onPressed: onEdit,
            icon: Icon(Icons.edit, size: 18),
            label: Text("Edit"),
          ),
      ],
    );
  }

  Widget _detailsCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          _infoRow("Brand", widget.bikeDetails["brand"] ?? ""),
          _infoRow("Model", widget.bikeDetails["model"] ?? ""),
          _infoRow("Engine CC", widget.bikeDetails["engine"] ?? ""),
          _infoRow("Mileage", "${widget.bikeDetails["mileage"] ?? ""} kmpl"),
          _infoRow("Fuel", widget.bikeDetails["fuel"] ?? ""),
          _infoRow("Registration No", widget.bikeDetails["regNo"] ?? ""),
          _infoRow("Registration Year", widget.bikeDetails["regYear"] ?? ""),
          _infoRow("KM Driven", "${widget.bikeDetails["km"] ?? ""} km"),
          _infoRow("Owner", widget.bikeDetails["owner"] ?? ""),

        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontFamily: 'Poppins', color: Colors.grey)),
          Text(value,
              style: TextStyle(
                  fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _photoGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, i) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(widget.images[i], fit: BoxFit.cover),
        );
      },
    );
  }

  void _showSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: Text("🎉 Submitted"),
        content: Text(
          "Your bike details have been submitted successfully.\n\n"
              "Our team will review and connect you with nearby dealers.",
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
            ),
            onPressed: () {
              Navigator.popUntil(context, (r) => r.isFirst);
            },
            child: Text("Go to Home", style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
