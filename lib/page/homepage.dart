import 'package:bikebuyer/page/notificationpage.dart';
import 'package:bikebuyer/hometabitems/commutertab.dart';
import 'package:bikebuyer/hometabitems/latestbikescooters.dart';
import 'package:bikebuyer/hometabitems/scootertab.dart';
import 'package:bikebuyer/hometabitems/sportsbiketab.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

import '../widget/customdrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final TextEditingController locationController = TextEditingController();
  final FocusNode locationFocus = FocusNode();


  List bikes = [
    {
      "name": "Royal Enfield Classic 350",
      "price": "₹1.90 Lakh",
      "img": "assets/images/bullet.jpg",
      "cc": "349 cc",
      "km": "35 kmpl",
    },
    {
      "name": "Yamaha R15 V4",
      "price": "₹1.82 Lakh",
      "img": "assets/images/Rs15.jpg",
      "cc": "155 cc",
      "km": "45 kmpl",
    },
    {
      "name": "KTM Duke 200",
      "price": "₹1.96 Lakh",
      "img": "assets/images/ktm2.webp",
      "cc": "199 cc",
      "km": "33 kmpl",
    },
    {
      "name": "Bajaj Pulsar 220F",
      "price": "₹1.34 Lakh",
      "img": "assets/images/pulsar1.png",
      "cc": "220 cc",
      "km": "40 kmpl",
    },
  ];

  List<String> bannerImages = [
    "assets/images/banner4.jpg",
    "assets/images/banner5.png",
    "assets/images/bannerhero.jpg",
  ];

  List bikeList = [
    {
      "name": "Hero Splendor Plus",
      "price": "₹74,000",
      "img": "assets/images/hero1.webp",
    },
    {"name": "TVS Raider", "price": "₹80,750", "img": "assets/images/tvs.jpg"},
    {
      "name": "Bajaj Pulsar 125",
      "price": "₹85,000",
      "img": "assets/images/pulsar1.png",
    },
    {
      "name": "Honda Shine",
      "price": "₹79,000",
      "img": "assets/images/honda.jpg",
    },
    {
      "name": "Yamaha FZ",
      "price": "₹1.20 Lakh",
      "img": "assets/images/R15.webp",
    },
  ];

  List brands = [
    {"name": "Bajaj", "img": "assets/images/Bajajlogo.webp"},
    {"name": "Hero", "img": "assets/images/herologo.png"},
    {"name": "Kawasaki", "img": "assets/images/kawa2logo.webp"},
    {"name": "Honda", "img": "assets/images/hondalogo3.jpg"},
    {"name": "KTM", "img": "assets/images/ktmlogo.png"},
    {"name": "Royal Enfield", "img": "assets/images/royalnewlogo.png"},
    {"name": "TVS", "img": "assets/images/tvslogo3.png"},
    {"name": "Triumph", "img": "assets/images/triumplogo.webp"},
    {"name": "Yamaha", "img": "assets/images/yamahalogo.webp"},
    {"name": "BMW", "img": "assets/images/bmwlogo.png"},
    {"name": "Ola", "img": "assets/images/olalogo2.png"},
    {"name": "Ducati", "img": "assets/images/Ducatilogo.png"},
  ];

  @override
  void initState() {
    super.initState();
    startAutoScroll();
  }

  void startAutoScroll() {
    Future.delayed(const Duration(seconds: 2), () {
      if (_pageController.hasClients) {
        currentIndex++;
        if (currentIndex == bannerImages.length) {
          currentIndex = 0;
        }
        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
        setState(() {});
      }
      startAutoScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: CustomDrawer(),
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 5,
        leadingWidth: 50,
        leading: Padding(
          padding: EdgeInsets.only(left: w * 0.020),
          child: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        title: GestureDetector(
          onTap: () {
            showLocationBottomSheet(context);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, size: 18, color: Colors.purple),
              const SizedBox(width: 6),
              Text(
                locationController.text.isEmpty
                    ? "Select City"
                    : locationController.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: w * 0.038,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, size: 25),
            ],
          ),
        ),



        /// 🔔 NOTIFICATION + 👤 PROFILE
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: w * 0.060),
            child: PopupMenuButton(
              color: Colors.white,
              offset: const Offset(10, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              itemBuilder: (context) => <PopupMenuEntry<int>>[
                PopupMenuItem(
                  enabled: false,
                  value: 0,
                  child: SizedBox(
                    height: h * 0.075,
                    width: w * 0.27,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hi Satyam",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: w * 0.040,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on,
                                size: 16, color: Colors.redAccent),
                            const SizedBox(width: 4),
                            Text(
                              locationController.text.isEmpty
                                  ? "Select city"
                                  : locationController.text,
                              style: TextStyle(
                                fontSize: w * 0.032,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              child: CircleAvatar(
                radius: 17,
                backgroundColor: Colors.grey.shade300,
                child: Icon(Icons.person, size: w * 0.050, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: h*0.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                    hintText: "Search bikes...",
                    prefixIcon: Icon(Icons.search, color: Colors.purple,),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: h*0.0150),
              SizedBox(
                height: h*0.21,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: bannerImages.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        bannerImages[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: h*0.0115),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  bannerImages.length,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    height: h*0.008,
                    width: currentIndex == index ? 12 : 6,
                    decoration: BoxDecoration(
                      color: currentIndex == index ? Colors.black : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h*0.020),
              Text(
                "Popular Bikes",
                style: TextStyle(fontSize: w*0.043, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: h*0.0135),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: bikes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 13,
                  crossAxisSpacing: 13,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  var bike = bikes[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Image.asset(
                                bike["img"],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              bike["name"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              bike["price"],
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: h*0.004),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Icon(Icons.speed, size: w*0.034),
                                SizedBox(width: w*0.012),
                                Text(bike["cc"]),
                                SizedBox(width: w*0.025),
                                Icon(Icons.local_gas_station, size: w*0.035),
                                SizedBox(width: w*0.011),
                                Text(bike["km"]),
                              ],
                            ),
                          ),
                          SizedBox(height: h*0.0120),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: h*0.023),
              Text(
                "The Most Sell Bikes Brands",
                style: TextStyle(fontSize: w*0.047, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: h*0.0125),
              SizedBox(
                height: h*0.26,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bikeList.length,
                  itemBuilder: (context, index) {
                    var bike = bikeList[index];
                    return Container(
                      height: h*0.190,
                      width: w*0.67,
                      margin: EdgeInsets.only(right: w*0.025),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: h*0.170,
                            width: w*0.66,
                            padding: EdgeInsets.all(8),
                            child: Image.asset(
                              bike["img"],
                              fit: BoxFit.contain,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              bike["name"],
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: w*0.026,
                              vertical: h*0.005,
                            ),
                            child: Text(
                              bike["price"],
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: w*0.026),
                            child: Text(
                              "View Bikes Details",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: w*0.034,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: h*0.022),
              Text(
                "Popular Brands",
                style: TextStyle(fontSize: w*0.043, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: h*0.0130),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: brands.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  var brand = brands[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Image.asset(brand["img"], fit: BoxFit.cover),
                    ),
                  );
                },
              ),
              SizedBox(height: h*0.0180),
              Text(
                "The Most Searched Bikes",
                style: TextStyle(fontSize: w * 0.043, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: h * 0.009),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        dividerColor: Colors.white,
                        labelColor: Colors.black,
                        labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.purple,
                        tabs: [
                          Tab(text: "Latest Bikes & Scooters"),
                          Tab(text: "Commuter Bikes"),
                          Tab(text: "Sports Bikes"),
                          Tab(text: "Scooter Bikes"),
                        ],
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        height: h * 0.29,
                        child: TabBarView(
                          children:[
                            LatestBikeScooterTab(),
                            CommuterBikeTab(),
                            SportsBikeTab(),
                            ScooterTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: h * 0.020),
            ],
          ),
        ),
      ),
    );
  }

  void showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Select your city", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
                  SizedBox(height: 12),
                  GooglePlaceAutoCompleteTextField(
                    textEditingController: locationController,
                    googleAPIKey: "AIzaSyDJ7qpCw3pf-zN-fY1DqWZ4HDK0Dmi62C4",
                    countries: ["in"],
                    isLatLngRequired: false,
                    debounceTime: 600,
                    inputDecoration: InputDecoration(
                      hintText: "Search city",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    itemClick: (prediction) {
                      setState(() {
                        locationController.text = prediction.description!;
                      });
                      Navigator.pop(context);
                    },
                    getPlaceDetailWithLatLng: (prediction) {},
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    leading: Icon(
                      Icons.my_location,
                      color: Colors.purple,
                    ),
                    title: const Text("Use current location"),
                    onTap: () async {
                      await detectCurrentLocation();
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> detectCurrentLocation() async {
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
      locationController.text = "$city, $state";
    });
  }

}
