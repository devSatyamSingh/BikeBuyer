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
import '../draweritems/customdrawer.dart';
import 'package:provider/provider.dart';
import '../widget/locationbottomsheet.dart';
import 'bikedetailpage.dart';
import 'brandbikespage.dart';
import 'location_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  final PageController _pageController = PageController();
  int currentIndex = 0;
  final FocusNode locationFocus = FocusNode();
  late List allBikes; // master list
  List filteredBikes = []; // search result
  bool isSearching = false;

  List bikes = [
    {
      "name": "Royal Enfield Classic 350",
      "price": "₹1.90 Lakh",
      "brand": "Royal Enfield",
      "cc": "349 cc",
      "km": "35 kmpl",
      "runKm": "12,500 km",
      "fuel": "Petrol",
      "regYear": "2021",
      "owner": "1st Owner",
      "rto": "UP32",
      "location": "Ayodhya, UP",
      "mileage": "35 kmpl",
      "images": [
        "assets/images/bullet.jpg",
        "assets/images/bulletbg.jpg",
        "assets/images/bulletfront.webp",
        "assets/images/bulletright.jpg",
        "assets/images/bulletbg.jpg",
      ],
    },
    {
      "name": "Yamaha R15 V4",
      "price": "₹1.82 Lakh",
      "brand": "Yamaha",
      "cc": "155 cc",
      "km": "45 kmpl",
      "runKm": "5,500 km",
      "fuel": "Petrol",
      "regYear": "2022",
      "owner": "1st Owner",
      "rto": "UP62",
      "location": "Jaunpur, UP",
      "mileage": "45 kmpl",
      "images": [
        "assets/images/Rs15.jpg",
        "assets/images/bulletright.jpg",
        "assets/images/bulletfront.webp",
        "assets/images/bulletbg.jpg",
        "assets/images/Rs15.jpg",
      ],
    },
    {
      "name": "KTM Duke 200",
      "price": "₹1.96 Lakh",
      "brand": "KTM",
      "cc": "199 cc",
      "km": "33 kmpl",
      "runKm": "8,300 km",
      "fuel": "Petrol",
      "regYear": "2021",
      "owner": "1st Owner",
      "rto": "UP32",
      "location": "Ayodhya, UP",
      "mileage": "33 kmpl",
      "images": [
        "assets/images/ktm2.webp",
        "assets/images/bulletfront.webp",
        "assets/images/bulletright.jpg",
        "assets/images/bulletbg.jpg",
        "assets/images/ktm2.webp",
      ],
    },
    {
      "name": "Bajaj Pulsar 220C",
      "price": "₹1.34 Lakh",
      "brand": "Bajaj",
      "cc": "220 cc",
      "km": "40 kmpl",
      "runKm": "10,000 km",
      "fuel": "Petrol",
      "regYear": "2020",
      "owner": "1st Owner",
      "rto": "UP32",
      "location": "Lucknow, UP",
      "mileage": "40 kmpl",
      "images": [
        "assets/images/pulsar1.png",
        "assets/images/bulletfront.webp",
        "assets/images/bulletright.jpg",
        "assets/images/bulletbg.jpg",
        "assets/images/pulsar1.png",
      ],
    },
  ];

  List bikeList = [
    {
      "name": "Hero Splendor Plus",
      "price": "₹74,000",
      "brand": "Hero",
      "cc": "97 cc",
      "km": "65 kmpl",
      "runKm": "18,000 km",
      "fuel": "Petrol",
      "regYear": "2019",
      "owner": "2nd Owner",
      "rto": "UP32",
      "location": "Ayodhya, UP",
      "mileage": "65 kmpl",
      "images": [
        "assets/images/hero1.webp",
        "assets/images/hero1.webp",
        "assets/images/hero1.webp",
        "assets/images/hero1.webp",
        "assets/images/hero1.webp",
      ],
    },
    {
      "name": "TVS Raider",
      "price": "₹80,750",
      "brand": "TVS",
      "cc": "125 cc",
      "km": "56 kmpl",
      "runKm": "6,500 km",
      "fuel": "Petrol",
      "regYear": "2022",
      "owner": "1st Owner",
      "rto": "UP62",
      "location": "Varanasi, UP",
      "mileage": "56 kmpl",
      "images": [
        "assets/images/tvs.jpg",
        "assets/images/tvs.jpg",
        "assets/images/tvs.jpg",
        "assets/images/tvs.jpg",
        "assets/images/tvs.jpg",
      ],
    },
    {
      "name": "Bajaj Pulsar 125",
      "price": "₹85,000",
      "brand": "Bajaj",
      "cc": "125 cc",
      "km": "50 kmpl",
      "runKm": "9,200 km",
      "fuel": "Petrol",
      "regYear": "2021",
      "owner": "1st Owner",
      "rto": "UP32",
      "location": "Ayodhya, UP",
      "mileage": "50 kmpl",
      "images": [
        "assets/images/pulsar1.png",
        "assets/images/pulsar1.png",
        "assets/images/pulsar1.png",
        "assets/images/pulsar1.png",
        "assets/images/pulsar1.png",
      ],
    },
    {
      "name": "Honda Shine",
      "price": "₹79,000",
      "brand": "Honda",
      "cc": "125 cc",
      "km": "55 kmpl",
      "runKm": "11,000 km",
      "fuel": "Petrol",
      "regYear": "2020",
      "owner": "2nd Owner",
      "rto": "UP32",
      "location": "Prayagraj, UP",
      "mileage": "55 kmpl",
      "images": [
        "assets/images/honda.jpg",
        "assets/images/honda.jpg",
        "assets/images/honda.jpg",
        "assets/images/honda.jpg",
        "assets/images/honda.jpg",
      ],
    },
    {
      "name": "Yamaha FZ",
      "price": "₹1.20 Lakh",
      "brand": "Yamaha",
      "cc": "149 cc",
      "km": "48 kmpl",
      "runKm": "7,800 km",
      "fuel": "Petrol",
      "regYear": "2021",
      "owner": "1st Owner",
      "rto": "UP62",
      "location": "Jaunpur, UP",
      "mileage": "48 kmpl",
      "images": [
        "assets/images/R15.webp",
        "assets/images/R15.webp",
        "assets/images/R15.webp",
        "assets/images/R15.webp",
        "assets/images/R15.webp",
      ],
    },
  ];

  List<String> bannerImages = [
    "assets/images/banner4.jpg",
    "assets/images/banner5.png",
    "assets/images/bannerhero.jpg",
  ];

  List brands = [
    {"name": "Bajaj", "img": "assets/images/Bajajlogo.webp", "brand": "Yamaha"},
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
    allBikes = [...bikes, ...bikeList];
    filteredBikes = [...allBikes];
  }

  void searchBike(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        isSearching = false;
        filteredBikes = [...allBikes];
      });
      return;
    }

    setState(() {
      isSearching = true;
      filteredBikes = allBikes.where((bike) {
        final name = bike["name"].toString().toLowerCase();
        final brand = bike["brand"].toString().toLowerCase();

        return name.contains(query.toLowerCase()) ||
            brand.contains(query.toLowerCase());
      }).toList();
    });
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
        foregroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 5,
        leadingWidth: 45,
        leading: Padding(
          padding: EdgeInsets.only(left: w * 0.018),
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
              const Icon(Icons.location_on, size: 18, color: Colors.red),
              const SizedBox(width: 6),
              Consumer<LocationProvider>(
                builder: (context, loc, _) => Text(
                  loc.city,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
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
                    height: h * 0.070,
                    width: w * 0.46,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Hi Satyam",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            fontSize: w * 0.040,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.redAccent,
                            ),
                            SizedBox(width: 4),
                            Consumer<LocationProvider>(
                              builder: (context, loc, _) => Text(
                                loc.city,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: w * 0.028,
                                  color: Colors.black54,
                                ),
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
                height: h * 0.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: searchBike,
                  decoration: InputDecoration(
                    hintText: "Search bikes or brands...",
                    prefixIcon: Icon(Icons.search, color: Colors.purple),
                    suffixIcon: isSearching
                        ? IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              searchController.clear();
                              searchBike("");
                            },
                          )
                        : null,
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: h * 0.0150),
              if (isSearching) ...[
                filteredBikes.isEmpty
                    ? Center(
                        child: Column(
                          children: const [
                            SizedBox(height: 60),
                            Icon(
                              Icons.search_off,
                              size: 90,
                              color: Colors.purple,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "No bikes found",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredBikes.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 13,
                              crossAxisSpacing: 13,
                              childAspectRatio: 0.70,
                            ),
                        itemBuilder: (context, index) {
                          final bike = filteredBikes[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BikeDetailPage(bike: bike),
                                ),
                              );
                            },
                            child: buildBikeCard(bike),
                          );
                        },
                      ),
              ] else ...[
                SizedBox(
                  height: h * 0.21,
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
                SizedBox(height: h * 0.0115),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    bannerImages.length,
                    (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      height: h * 0.008,
                      width: currentIndex == index ? 12 : 6,
                      decoration: BoxDecoration(
                        color: currentIndex == index
                            ? Colors.black
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.020),
                Text(
                  "Popular Bikes",
                  style: TextStyle(
                    fontSize: w * 0.045,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: h * 0.0135),
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BikeDetailPage(bike: bikes[index]),
                          ),
                        );
                      },
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
                                  bike["images"][0],
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
                                style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Poppins', fontSize: 13),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                bike["price"],
                                style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: h * 0.004),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.speed, size: w * 0.034),
                                  SizedBox(width: w * 0.012),
                                  Text(bike["cc"]),
                                  SizedBox(width: w * 0.025),
                                  Icon(
                                    Icons.local_gas_station,
                                    size: w * 0.035,
                                  ),
                                  SizedBox(width: w * 0.011),
                                  Text(bike["km"]),
                                ],
                              ),
                            ),
                            SizedBox(height: h * 0.0120),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: h * 0.023),
                Text(
                  "The Most Sell Bikes Brands",
                  style: TextStyle(
                    fontSize: w * 0.044,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: h * 0.0125),
                SizedBox(
                  height: h * 0.26,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: bikeList.length,
                    itemBuilder: (context, index) {
                      var bike = bikeList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BikeDetailPage(bike: bike),
                            ),
                          );
                        },
                        child: Container(
                          height: h * 0.190,
                          width: w * 0.67,
                          margin: EdgeInsets.only(right: w * 0.025),
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
                                height: h * 0.170,
                                width: w * 0.66,
                                padding: EdgeInsets.all(8),
                                child: Image.asset(
                                  bike["images"][0],
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  bike["name"],
                                  style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Poppins',),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.026,
                                  vertical: h * 0.005,
                                ),
                                child: Text(
                                  bike["price"],
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.026,
                                ),
                                child: Text(
                                  "View Bikes Details",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: 'Poppins',
                                    fontSize: w * 0.032,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: h * 0.022),
                Text(
                  "Popular Brands",
                  style: TextStyle(
                    fontSize: w * 0.043,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: h * 0.0130),
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
                    return GestureDetector(
                      onTap: () {
                        List allBikes = [...bikes, ...bikeList];

                        List filteredBikes = allBikes.where((bike) {
                          return bike["brand"] == brand["name"];
                        }).toList();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BrandBikesPage(
                              brandName: brand["name"],
                              bikes: filteredBikes,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Image.asset(brand["img"], fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: h * 0.0180),
                Text(
                  "The Most Searched Bikes",
                  style: TextStyle(
                    fontSize: w * 0.042,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
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
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
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
                            children: [
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
            ],
          ),
        ),
      ),
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

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks.first;

    String city = place.locality ?? "";
    String state = place.administrativeArea ?? "";

    final locationProvider = Provider.of<LocationProvider>(
      context,
      listen: false,
    );

    locationProvider.setCity("$city, $state");
  }
}

Widget buildBikeCard(Map bike) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(bike["images"][0], fit: BoxFit.contain),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            bike["name"],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins',),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            bike["price"],
            style: TextStyle(
              color: Colors.green,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    ),
  );
}
