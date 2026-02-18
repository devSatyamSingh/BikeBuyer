import 'dart:io';
import 'package:bikebuyer/seller/bikesubmitpage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BikeImgUploadPage extends StatefulWidget {
  final Map<String, String> bikeDetails;

  const BikeImgUploadPage({
    super.key,
    required this.bikeDetails,
  });

  @override
  State<BikeImgUploadPage> createState() => _BikeImgUploadPageState();
}

class _BikeImgUploadPageState extends State<BikeImgUploadPage> {
  final ImagePicker _picker = ImagePicker();

  final List<File?> images = List.generate(5, (_) => null);

  final List<String> titles = [
    "Front View",
    "Back View",
    "Left Side",
    "Right Side",
    "Meter / RC",
  ];

  int currentIndex = 0;

  Future<void> pickImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (picked == null) return;

    final file = File(picked.path);
    final sizeInMB = file.lengthSync() / (1024 * 1024);

    if (sizeInMB > 10) {
      _showMessage("⚠️ Image must be under 10MB");
      return;
    }

    setState(() {
      images[currentIndex] = file;
      if (currentIndex < 4) currentIndex++;
    });
  }

  void _showPickerWithWarning() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Upload Photo"),
        content: Text(
          "Please upload a clear photo.\n\n"
          "• Only 1 photo at a time\n"
          "• Max size 10MB\n"
          "• This photo is required",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            onPressed: () {
              Navigator.pop(context);
              _openBottomSheet();
            },
            child: Text("Continue", style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _pickerTile(Icons.camera_alt, "Camera", ImageSource.camera),
              _pickerTile(Icons.photo, "Gallery", ImageSource.gallery),
            ],
          ),
        );
      },
    );
  }

  void removeImage(int index) {
    setState(() {
      images[index] = null;
      currentIndex = index;
    });
  }

  Widget _pickerTile(IconData icon, String title, ImageSource source) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple),
      title: Text(title, style: TextStyle(fontFamily: 'Poppins')),
      onTap: () {
        Navigator.pop(context);
        pickImage(source);
      },
    );
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  bool get allUploaded => images.every((img) => img != null);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Upload Bike Photos"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.038),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _stepHeader(),
            SizedBox(height: h*0.0120),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.purple),
                  SizedBox(width: w*0.026),
                  Expanded(
                    child: Text(
                      "Upload 5 clear photos (max 10MB each)",
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: h*0.022),
            Text(
              "Step ${currentIndex + 1} of 5 · ${titles[currentIndex]}",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),

             SizedBox(height: h*0.0134),
            GestureDetector(
              onTap: _showPickerWithWarning,
              child: Container(
                height: h*0.280,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: images[currentIndex] == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo,
                            size: 50,
                            color: Colors.purple,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Tap to upload ${titles[currentIndex]}",
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          images[currentIndex]!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
              ),
            ),

            SizedBox(height: h*0.022),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (i) {
                return CircleAvatar(
                  radius: 18,
                  backgroundColor: images[i] != null
                      ? Colors.green
                      : Colors.grey.shade300,
                  child: Text(
                    "${i + 1}",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }),
            ),
            if (images.any((img) => img != null)) ...[
              SizedBox(height: h*0.0140),
              Text(
                "Uploaded Photos",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: h*0.0118),
              SizedBox(
                height: h*0.110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final file = images[index];
                    if (file == null) return const SizedBox.shrink();

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              file,
                              width: w*0.25,
                              height: h*0.14,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => removeImage(index),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],

            Spacer(),
            SizedBox(
              width: double.infinity,
              height: h*0.057,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: allUploaded ? Colors.purple : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: allUploaded
                    ? () {
                  _showMessage("✅ Images uploaded successfully");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BikeReviewSubmitPage(
                        bikeDetails: widget.bikeDetails,
                        images: images.whereType<File>().toList(), // 🔥 FIX
                      ),
                    ),
                  );
                }
                    : null,
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: w*0.039,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}


Widget _stepHeader() {
  return Builder(
    builder: (context) {
      final h = MediaQuery.of(context).size.height;
      final w = MediaQuery.of(context).size.width;

      return Container(
        padding: EdgeInsets.all(w * 0.030), // 14
        decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.08),
          borderRadius: BorderRadius.circular(w * 0.030), // 14
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: w * 0.031, // 14
              backgroundColor: Colors.purple,
              child: Text(
                "1",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.035,
                ),
              ),
            ),
            SizedBox(width: w * 0.026),
            Text(
              "Step 1 of 3 · Bike Details",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: w * 0.033,
              ),
            ),
          ],
        ),
      );
    },
  );
}
