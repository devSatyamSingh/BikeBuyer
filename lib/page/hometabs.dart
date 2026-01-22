import 'package:bikebuyer/page/bikesell.dart';
import 'package:bikebuyer/page/homepage.dart';
import 'package:bikebuyer/page/userprofile.dart';
import 'package:bikebuyer/page/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({super.key});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {

  int SelectedIndex = 0;

  List Pages = [
    HomePage(),
    Wishlist(),
    BikeSell(),
    UserProfile(),
  ];
  @override
  Widget build(BuildContext context) {

    final ScreenWidth = MediaQuery.of(context).size.width;
    final ScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body:  Pages[SelectedIndex],
      bottomNavigationBar: Container(
        height: ScreenHeight*0.07,
        decoration: BoxDecoration(
          color: Colors.grey.shade300.withOpacity(0.8),
          borderRadius: BorderRadius.circular(ScreenWidth*0.02),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle: TextStyle(color: Colors.white,fontSize: ScreenWidth*0.029, fontFamily: 'Poppins'),
          unselectedLabelStyle: TextStyle( color: Colors.black54, fontSize: ScreenWidth*0.029, fontFamily: 'Poppins'),
          currentIndex: SelectedIndex,
          onTap: (index) {
            setState(() {
              SelectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon( SelectedIndex == 0 ? IconlyBold.home : IconlyLight.home, size: ScreenHeight*0.032,), label: "Home"),
            BottomNavigationBarItem(icon: Icon( SelectedIndex == 1 ? IconlyBold.heart : IconlyLight.heart, size: ScreenHeight*0.032,), label: "Wishlist"),
            BottomNavigationBarItem(icon: Icon( SelectedIndex == 2 ? IconlyBold.plus : IconlyLight.plus, size: ScreenHeight*0.032,), label: "Sell Bike"),
            BottomNavigationBarItem(icon: Icon( SelectedIndex == 3 ? IconlyBold.profile : IconlyLight.profile, size: ScreenHeight*0.032,), label: "Account"),
          ],
        ),
      ),
    );
  }
}
