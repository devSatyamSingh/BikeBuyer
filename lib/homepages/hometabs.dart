import 'package:bikebuyer/page/bikesell.dart';
import 'package:bikebuyer/homepages/homepage.dart';
import 'package:bikebuyer/profilepage/userprofile.dart';
import 'package:bikebuyer/page/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter/services.dart';


class HomeTabs extends StatefulWidget {
  const HomeTabs({super.key});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {

  int SelectedIndex = 0;

  List Pages = [
    HomePage(),
    WishlistPage(),
    BikeSell(),
    UserProfile(),
  ];
  @override
  Widget build(BuildContext context) {

    final ScreenWidth = MediaQuery.of(context).size.width;
    final ScreenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        if (SelectedIndex != 0) {
          setState(() {
            SelectedIndex = 0;
          });
          return false;
        }
        final shouldExit = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => _exitDialog(context),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
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
              BottomNavigationBarItem(icon: Icon( SelectedIndex == 0 ? IconlyBold.home : IconlyLight.home, size: ScreenHeight*0.031,), label: "Home"),
              BottomNavigationBarItem(icon: Icon( SelectedIndex == 1 ? IconlyBold.heart : IconlyLight.heart, size: ScreenHeight*0.031,), label: "Wishlist"),
              BottomNavigationBarItem(icon: Icon( SelectedIndex == 2 ? IconlyBold.plus : IconlyLight.plus, size: ScreenHeight*0.031,), label: "Sell Bike"),
              BottomNavigationBarItem(icon: Icon( SelectedIndex == 3 ? IconlyBold.profile : IconlyLight.profile, size: ScreenHeight*0.031,), label: "Account"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _exitDialog(BuildContext context) {
  return Dialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.exit_to_app,
              size: 32,
              color: Colors.purple,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Exit App?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Are you sure you want to exit the app?\nYou can continue browsing bikes anytime.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    "No",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 1,
                  ),
                  child: Text(
                    "Yes",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

