import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../homepages/location_provider.dart';
import '../widget/locationbottomsheet.dart';

class ServiceCenterListPage extends StatefulWidget {
  final String brandName;

  const ServiceCenterListPage({
    super.key,
    required this.brandName,
  });

  @override
  State<ServiceCenterListPage> createState() => _ServiceCenterListPageState();
}

class _ServiceCenterListPageState extends State<ServiceCenterListPage> {
  String currentLocation = "Ghaziabad";
  final List serviceCenters = [
    {
      "name": "ASA Riders LLP - Raj Nagar",
      "address":
      "Noor Nagar, Raj Nagar extn, Ghaziabad, Uttar Pradesh, 201017",
      "phone": "91828706348",
    },
    {
      "name": "Amar Autos - Vijay Nagar",
      "address":
      "Vijay Nagar, Sector 9, Ghaziabad, Uttar Pradesh, 201009",
      "phone": "91828706348",
    },
    {
      "name": "Rawat Automobiles Pvt Ltd - Rakeshmarg",
      "address":
      "Nehru Nagar Rakeshmarg, Ghaziabad, Uttar Pradesh, 201002",
      "phone": "91935035311",
    },
  ];


  Future<void> openMapByAddress(String address) async {
    final url = "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}";
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw "Could not open Google Maps";
    }
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "${widget.brandName} Service Centers",
          style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins', ),
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<LocationProvider>(
              builder: (context, loc, _) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey, size: 18,),
                      const SizedBox(width: 4),
                      Text(loc.city, style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins', fontSize: 16)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      showLocationBottomSheet(context);
                    },
                    child: Text("Change"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                itemCount: serviceCenters.length,
                itemBuilder: (context, index) {
                  final center = serviceCenters[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 6),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          center["name"],
                          style: TextStyle(
                            fontSize: w * 0.041,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on,
                                size: 16, color: Colors.grey),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                center["address"],
                                style: TextStyle(color: Colors.black54, fontFamily: 'Poppins',),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.call,
                                size: 16, color: Colors.grey),
                            SizedBox(width: 6),
                            Text(
                              center["phone"],
                              style: TextStyle(color: Colors.black54, fontFamily: 'Poppins',),
                            ),
                          ],
                        ),
                        SizedBox(height: 14),
                        GestureDetector(
                          onTap: () {
                            openMapByAddress(center["address"]);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.purple.shade400,
                              borderRadius: BorderRadius.circular(16)
                            ), child: Center(
                              child: Text(
                              "Location",
                              style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 20),),
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
        ),
      ),
    );
  }
}
