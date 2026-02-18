import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CityAutoCompleteField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final VoidCallback? onChanged;

  const CityAutoCompleteField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onChanged,
  });

  @override
  State<CityAutoCompleteField> createState() =>
      _CityAutoCompleteFieldState();
}

class _CityAutoCompleteFieldState extends State<CityAutoCompleteField> {

  Future<void> getCurrentLocation() async {
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

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks.first;
    String city = place.locality ?? "";
    String state = place.administrativeArea ?? "";

    setState(() {
      widget.controller.text = "$city, $state";
    });

    widget.onChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 6, bottom: 6),
          child: Text(
            "City",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Container(
          height: 54,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(18),
          ),
          child: GooglePlaceAutoCompleteTextField(
            focusNode: widget.focusNode,
            textEditingController: widget.controller,
            googleAPIKey: "AIzaSyDJ7qpCw3pf-zN-fY1DqWZ4HDK0Dmi62C4",
            inputDecoration: InputDecoration(
              hintText: "Enter your city",
              prefixIcon: const Icon(
                Icons.location_pin,
                color: Colors.purple,
              ),
              suffixIcon: GestureDetector(
                onTap: getCurrentLocation,
                child: const Icon(Icons.my_location),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            countries: const ["in"],
            isLatLngRequired: false,
            itemClick: (prediction) {
              widget.controller.text = prediction.description!;
              widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length),
              );
              widget.onChanged?.call();
            },
          ),
        ),
      ],
    );
  }
}
