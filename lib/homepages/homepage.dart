import 'dart:convert';
import 'dart:async';
import 'package:bikebuyer/homepages/popular_brands.dart';
import 'package:bikebuyer/page/notificationpage.dart';
import 'package:bikebuyer/widget/loderanimation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../draweritems/customdrawer.dart';
import 'package:provider/provider.dart';
import '../modal/brandmodel.dart';
import '../modal/vehicalmodel.dart';
import '../widget/locationbottomsheet.dart';
import '../widget/pagenavigationanimation.dart';
import 'bikedetailpage.dart';
import '../filter/filterpage.dart';
import 'bikeditailspagess.dart';
import 'brandbikespage.dart';
import 'latestbikessection.dart';
import 'location_provider.dart';
import 'mostsearchsection.dart';
import 'mostsellbikes.dart';

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
  late List<Map<String, dynamic>> allBikes;
  List<Map<String, dynamic>> filteredBikes = [];
  bool isSearching = false;
  final FocusNode searchFocus = FocusNode();
  bool showAllPopular = false;
  String userName = "";
  bool isLoggedIn = false;
  bool isUserLoading = true;
  List<VehicleModel> allApiBikes = [];


  Timer? _debounce;
  List<VehicleModel> apiSearchResults = [];

  List bikes = [
    // {
    //   "name": "Royal Enfield Classic 350",
    //   "price": "₹1.90 Lakh",
    //   "priceValue": 190000,
    //   "ccValue": 350, // 👈 new
    //   "year": 2021,
    //   "brand": "Royal Enfield",
    //   "cc": "349 cc",
    //   "km": "35 kmpl",
    //   "runKm": "12,500 km",
    //   "fuel": "Petrol",
    //   "regYear": "2021",
    //   "owner": "1st Owner",
    //   "rto": "UP32",
    //   "location": "Ayodhya, UP",
    //   "mileage": "35 kmpl",
    //   "images": [
    //     "assets/images/bullet.jpg",
    //     "assets/images/bulletbg.jpg",
    //     "assets/images/bulletfront.webp",
    //     "assets/images/bulletright.jpg",
    //     "assets/images/bulletbg.jpg",
    //   ],
    // },
    // {
    //   "name": "Yamaha R15 V4",
    //   "price": "₹1.82 Lakh",
    //   "brand": "Yamaha",
    //   "priceValue": 182000,
    //   "ccValue": 155, // 👈 new
    //   "year": 2022,
    //   "cc": "155 cc",
    //   "km": "45 kmpl",
    //   "runKm": "5,500 km",
    //   "fuel": "Petrol",
    //   "regYear": "2022",
    //   "owner": "1st Owner",
    //   "rto": "UP62",
    //   "location": "Jaunpur, UP",
    //   "mileage": "45 kmpl",
    //   "images": [
    //     "assets/images/Rs15.jpg",
    //     "assets/images/bulletright.jpg",
    //     "assets/images/bulletfront.webp",
    //     "assets/images/bulletbg.jpg",
    //     "assets/images/Rs15.jpg",
    //   ],
    // },
    // {
    //   "name": "KTM Duke 200",
    //   "price": "₹1.96 Lakh",
    //   "brand": "KTM",
    //   "priceValue": 196000,
    //   "ccValue": 200, // 👈 new
    //   "year": 2021,
    //   "cc": "200 cc",
    //   "km": "33 kmpl",
    //   "runKm": "8,300 km",
    //   "fuel": "Petrol",
    //   "regYear": "2021",
    //   "owner": "1st Owner",
    //   "rto": "UP32",
    //   "location": "Ayodhya, UP",
    //   "mileage": "33 kmpl",
    //   "images": [
    //     "assets/images/ktm2.webp",
    //     "assets/images/bulletfront.webp",
    //     "assets/images/bulletright.jpg",
    //     "assets/images/bulletbg.jpg",
    //     "assets/images/ktm2.webp",
    //   ],
    // },
    // {
    //   "name": "Bajaj Pulsar 220C",
    //   "price": "₹1.34 Lakh",
    //   "brand": "Bajaj",
    //   "cc": "220 cc",
    //   "priceValue": 134000,
    //   "ccValue": 220, // 👈 new
    //   "year": 2020,
    //   "km": "40 kmpl",
    //   "runKm": "10,000 km",
    //   "fuel": "Petrol",
    //   "regYear": "2020",
    //   "owner": "1st Owner",
    //   "rto": "UP32",
    //   "location": "Lucknow, UP",
    //   "mileage": "40 kmpl",
    //   "images": [
    //     "assets/images/pulsar1.png",
    //     "assets/images/bulletfront.webp",
    //     "assets/images/bulletright.jpg",
    //     "assets/images/bulletbg.jpg",
    //     "assets/images/pulsar1.png",
    //   ],
    // },
  ];

  List bikeList = [
    // {
    //   "name": "Hero Splendor Plus",
    //   "price": "₹74,000",
    //   "brand": "Hero",
    //   "priceValue": 74000,
    //   "ccValue": 97, // 👈 new
    //   "year": 2019,
    //   "cc": "97 cc",
    //   "km": "65 kmpl",
    //   "runKm": "18,000 km",
    //   "fuel": "Petrol",
    //   "regYear": "2019",
    //   "owner": "2nd Owner",
    //   "rto": "UP32",
    //   "location": "Ayodhya, UP",
    //   "mileage": "65 kmpl",
    //   "images": [
    //     "assets/images/hero1.webp",
    //     "assets/images/hero1.webp",
    //     "assets/images/hero1.webp",
    //     "assets/images/hero1.webp",
    //     "assets/images/hero1.webp",
    //   ],
    // },
    // {
    //   "name": "TVS Raider",
    //   "price": "₹80,750",
    //   "brand": "TVS",
    //   "priceValue": 80000,
    //   "ccValue": 125,
    //   "year": 2022,
    //   "cc": "125 cc",
    //   "km": "56 kmpl",
    //   "runKm": "6,500 km",
    //   "fuel": "Petrol",
    //   "regYear": "2022",
    //   "owner": "1st Owner",
    //   "rto": "UP62",
    //   "location": "Varanasi, UP",
    //   "mileage": "56 kmpl",
    //   "images": [
    //     "assets/images/tvs.jpg",
    //     "assets/images/tvs.jpg",
    //     "assets/images/tvs.jpg",
    //     "assets/images/tvs.jpg",
    //     "assets/images/tvs.jpg",
    //   ],
    // },
    // {
    //   "name": "Bajaj Pulsar 125",
    //   "price": "₹85,000",
    //   "brand": "Bajaj",
    //   "priceValue": 85000,
    //   "ccValue": 125,
    //   "year": 2024,
    //   "cc": "125 cc",
    //   "km": "50 kmpl",
    //   "runKm": "9,200 km",
    //   "fuel": "Petrol",
    //   "regYear": "2024",
    //   "owner": "1st Owner",
    //   "rto": "UP32",
    //   "location": "Ayodhya, UP",
    //   "mileage": "50 kmpl",
    //   "images": [
    //     "assets/images/pulsar1.png",
    //     "assets/images/pulsar1.png",
    //     "assets/images/pulsar1.png",
    //     "assets/images/pulsar1.png",
    //     "assets/images/pulsar1.png",
    //   ],
    // },
    // {
    //   "name": "Honda Shine",
    //   "price": "₹79,000",
    //   "brand": "Honda",
    //   "priceValue": 79000,
    //   "ccValue": 125,
    //   "year": 2025,
    //   "cc": "125 cc",
    //   "km": "55 kmpl",
    //   "runKm": "11,000 km",
    //   "fuel": "Petrol",
    //   "regYear": "2025",
    //   "owner": "2nd Owner",
    //   "rto": "UP32",
    //   "location": "Prayagraj, UP",
    //   "mileage": "55 kmpl",
    //   "images": [
    //     "assets/images/honda.jpg",
    //     "assets/images/honda.jpg",
    //     "assets/images/honda.jpg",
    //     "assets/images/honda.jpg",
    //     "assets/images/honda.jpg",
    //   ],
    // },
    // {
    //   "name": "Yamaha FZ",
    //   "price": "₹1.20 Lakh",
    //   "brand": "Yamaha",
    //   "priceValue": 120000,
    //   "ccValue": 149,
    //   "year": 2025,
    //   "cc": "149 cc",
    //   "km": "48 kmpl",
    //   "runKm": "7,800 km",
    //   "fuel": "Petrol",
    //   "regYear": "2025",
    //   "owner": "1st Owner",
    //   "rto": "UP62",
    //   "location": "Jaunpur, UP",
    //   "mileage": "48 kmpl",
    //   "images": [
    //     "assets/images/R15.webp",
    //     "assets/images/R15.webp",
    //     "assets/images/R15.webp",
    //     "assets/images/R15.webp",
    //     "assets/images/R15.webp",
    //   ],
    // },
  ];

  List<String> bannerImages = [
    "assets/images/banner4.jpg",
    "assets/images/banner5.png",
    "assets/images/bannerhero.jpg",
  ];

  // List brands = [
  //   {"name": "Bajaj", "img": "assets/images/Bajajlogo.webp"},
  //   {"name": "Hero", "img": "assets/images/herologo.png"},
  //   {"name": "Kawasaki", "img": "assets/images/kawa2logo.webp"},
  //   {"name": "Honda", "img": "assets/images/hondalogo3.jpg"},
  //   {"name": "KTM", "img": "assets/images/ktmlogo.png"},
  //   {"name": "Royal Enfield", "img": "assets/images/royalnewlogo.png"},
  //   {"name": "TVS", "img": "assets/images/tvslogo3.png"},
  //   {"name": "Triumph", "img": "assets/images/triumplogo.webp"},
  //   {"name": "Yamaha", "img": "assets/images/yamahalogo.webp"},
  //   {"name": "BMW", "img": "assets/images/bmwlogo.png"},
  //   {"name": "Ola", "img": "assets/images/olalogo2.png"},
  //   {"name": "Ducati", "img": "assets/images/Ducatilogo.png"},
  // ];

  List<dynamic> apiBikes = [];
  bool isLoadingSearch = false;

  List<BrandModel> apiBrands = [];
  bool isBrandLoading = true;


  @override
  void initState() {
    super.initState();
    startAutoScroll();
    loadUser();
    fetchAllBikes();
    fetchBrands(); // 👈 ADD THIS
  }

  Future<void> fetchBrands() async {
    try {
      final response = await http.get(
        Uri.parse("https://api.bikesbuyer.com/api/admin/getBrands"),
      );

      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        List brands = data["brands"] ?? [];

        List<BrandModel> parsed =
        brands.map((e) => BrandModel.fromJson(e)).toList();

        setState(() {
          apiBrands = parsed;
          isBrandLoading = false;
        });

        print("TOTAL BRANDS: ${parsed.length}");
      }
    } catch (e) {
      print("ERROR FETCHING BRANDS: $e");
      setState(() {
        isBrandLoading = false;
      });
    }
  }


  Future<void> fetchAllBikes() async {
    try {
      final response = await http.get(
        Uri.parse("https://api.bikesbuyer.com/api/buyer/vehicles"),
      );

      final data = jsonDecode(response.body);

      if (data["success"] == true) {

        List vehicles = data["vehicles"] ?? [];

        List<VehicleModel> parsed =
        vehicles.map((e) => VehicleModel.fromJson(e)).toList();

        setState(() {
          allApiBikes = parsed;
        });

        print("TOTAL BIKES RECEIVED: ${parsed.length}");
      }

    } catch (e) {
      print("ERROR FETCHING ALL BIKES: $e");
    }
  }


  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    bool loginStatus = prefs.getBool("isLoggedIn") ?? false;

    if (loginStatus) {
      userName = prefs.getString("userName") ?? "";
      isLoggedIn = true;
    }

    setState(() {
      isUserLoading = false;
    });
  }

  void searchBike(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.trim().isEmpty) {
      setState(() {
        isSearching = false;
        apiSearchResults.clear();
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        isSearching = true;
        isLoadingSearch = true;
      });

      try {
        final response = await http.get(
          Uri.parse(
            "https://api.bikesbuyer.com/api/buyer/vehicles?search=$query",
          ),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          if (data["success"] == true) {
            List vehicles = data["vehicles"] ?? [];

            List<VehicleModel> parsed = vehicles
                .map<VehicleModel>((e) => VehicleModel.fromJson(e))
                .toList();

            setState(() {
              apiSearchResults = parsed;
            });

            print("TOTAL BIKES RECEIVED: ${parsed.length}");
          } else {
            setState(() {
              apiSearchResults = [];
            });
          }
        } else {
          setState(() {
            apiSearchResults = [];
          });
        }
      } catch (e) {
        print("SEARCH ERROR: $e");

        setState(() {
          apiSearchResults = [];
        });
      }

      setState(() {
        isLoadingSearch = false;
      });
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
  void dispose() {
    searchController.dispose();
    searchFocus.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              Icon(Icons.location_on, size: 18, color: Colors.red),
              SizedBox(width: 6),
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
              Navigator.push(context, SlidePageRoute(page: NotificationPage()));
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
                          isLoggedIn
                              ? "Hi $userName"
                              : "Hi Guest",
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
              child: isUserLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.grey.shade300,
                      child: Text(
                        isLoggedIn && userName.isNotEmpty
                            ? userName[0].toUpperCase()
                            : "?",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: w * 0.040,
                          color: Colors.black,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    focusNode: searchFocus,
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
                  if (isLoadingSearch)
                    Center(child: CircularProgressIndicator())
                  else if (apiSearchResults.isEmpty)
                    Center(child: Text("No bikes found"))
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: apiSearchResults.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 13,
                        crossAxisSpacing: 13,
                        childAspectRatio: 0.70,
                      ),
                      itemBuilder: (context, index) {
                        final bike = apiSearchResults[index];
                        final vehicle = apiSearchResults[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              SlidePageRoute(
                                page: BikeDetailPages(bike: vehicle),
                              ),
                            );
                          },
                          child: buildVehicleCard(vehicle),
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
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: Icon(Icons.tune, color: Colors.black),
                          label: Text(
                            "Filters",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FilterPage(
                                  allBikes: isSearching
                                      ? apiSearchResults
                                      : allApiBikes,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  SizedBox(height: h * 0.018),
                  LatestBikesSection(
                    searchQuery: isSearching ? searchController.text : null,
                  ),
                  SizedBox(height: h * 0.010),
                  MostSellBikesSection(
                    searchQuery: isSearching ? searchController.text : null,
                  ),
                  SizedBox(height: h * 0.022),
                  PopularBrandsSection(
                    brands: apiBrands,
                    allBikes: allApiBikes,
                  ),
                  SizedBox(height: 20),
                  MostSearchedSection(),
                  SizedBox(height: h * 0.020),
                ],
              ],
            ),
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

Widget buildVehicleCard(VehicleModel bike) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 5)
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: bike.images.isNotEmpty
                ? Image.network(
              bike.images.first,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.image_not_supported),
            )
                : const Icon(Icons.image_not_supported),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "${bike.brandName} ${bike.model}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "₹${bike.price}",
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    ),
  );
}

