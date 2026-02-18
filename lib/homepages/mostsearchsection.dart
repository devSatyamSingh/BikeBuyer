import 'package:flutter/material.dart';
import '../draweritems/Electricbikelist.dart';
import '../hometabitems/commutertab.dart';
import '../hometabitems/cruiserbike.dart';
import '../hometabitems/sportsbiketab.dart';
import '../hometabitems/ElectricScooty.dart';

class MostSearchedSection extends StatelessWidget {
  const MostSearchedSection({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "The Most Searched Bikes",
          style: TextStyle(
            fontSize: w * 0.042,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: h * 0.009),
        DefaultTabController(
          length: 4,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.white,
                unselectedLabelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.purple,
                tabs: [
                  Tab(text: "Commuter Bikes"),
                  Tab(text: "Cruiser Bikes"),
                  Tab(text: "Sports Bikes"),
                  Tab(text: "Electric Bikes"),
                ],
              ),
              SizedBox(height: 12),
              SizedBox(
                height: h * 0.29,
                child: TabBarView(
                  children: [
                    CommuterBikeTab(),
                    CruiserBikePage(),
                    SportsBikeTab(),
                    ElectricBikeLIst(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}