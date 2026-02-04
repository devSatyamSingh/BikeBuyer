import 'package:flutter/material.dart';
import 'filterbikescard.dart';

class FilteredBikePage extends StatelessWidget {
  final List<Map<String, dynamic>> bikes;

  const FilteredBikePage({super.key, required this.bikes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("${bikes.length} Bikes Found"),
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: bikes.length,
        itemBuilder: (context, index) {
          return FilteredBikeLargeCard(bike: bikes[index]);
        },
      ),
    );
  }
}
