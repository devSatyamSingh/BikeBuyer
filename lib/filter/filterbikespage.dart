import 'package:flutter/material.dart';
import '../modal/vehicalmodel.dart';
import '../widget/loderanimation.dart';
import 'filterbikescard.dart';

class FilteredBikePage extends StatefulWidget {
  final List<VehicleModel> bikes;

  const FilteredBikePage({
    super.key,
    required this.bikes,
  });

  @override
  State<FilteredBikePage> createState() => _FilteredBikePageState();
}

class _FilteredBikePageState extends State<FilteredBikePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // simulate small delay (smooth UI feel)
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("${widget.bikes.length} Bikes Found"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
        child: SegmentLoader()
      )
          : widget.bikes.isEmpty
          ? const Center(
        child: Text(
          "No Bikes Found 😕",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: widget.bikes.length,
        itemBuilder: (context, index) {
          return FilteredBikeLargeCard(
            bike: widget.bikes[index],
          );
        },
      ),
    );
  }
}
