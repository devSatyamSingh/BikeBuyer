import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:provider/provider.dart';
import '../homepages/location_provider.dart';

void showLocationBottomSheet(BuildContext context) {
  final locationProvider =
  Provider.of<LocationProvider>(context, listen: false);

  final TextEditingController searchController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Select your city",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              GooglePlaceAutoCompleteTextField(
                textEditingController: searchController,
                googleAPIKey: "AIzaSyDJ7qpCw3pf-zN-fY1DqWZ4HDK0Dmi62C4",
                debounceTime: 600,
                countries: ["in"],
                isLatLngRequired: false,
                inputDecoration: InputDecoration(
                  hintText: "Search city",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                itemClick: (prediction) {
                  locationProvider.setCity(prediction.description!);
                  Navigator.pop(context);
                },
                getPlaceDetailWithLatLng: (prediction) {},
              ),

              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.my_location, color: Colors.purple),
                title: Text("Use current location"),
                onTap: () async {
                  await detectCurrentLocation(context);
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> detectCurrentLocation(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;
  }

  if (permission == LocationPermission.deniedForever) return;

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  List<Placemark> placemarks =
  await placemarkFromCoordinates(position.latitude, position.longitude);

  Placemark place = placemarks.first;

  String city = place.locality ?? "";
  String state = place.administrativeArea ?? "";

  final locationProvider =
  Provider.of<LocationProvider>(context, listen: false);

  locationProvider.setCity("$city, $state");
}


