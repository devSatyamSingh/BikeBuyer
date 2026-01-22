import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widget/customdrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

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
      "img": "assets/images/pulsar.webp",
      "cc": "220 cc",
      "km": "40 kmpl",
    },
  ];

  List<String> bannerImages = [
    "assets/images/banner1.jpg",
    "assets/images/banner2.jpg",
    "assets/images/banner3.jpg",
  ];

  List bikeList = [
    {
      "name": "Hero Splendor Plus",
      "price": "₹74,000",
      "img": "assets/images/hero.jpg",
    },
    {"name": "TVS Raider", "price": "₹80,750", "img": "assets/images/tvs.jpg"},
    {
      "name": "Bajaj Pulsar 125",
      "price": "₹85,000",
      "img": "assets/images/pulsar.webp",
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
        title: Row(
          children: [
            Icon(
              Icons.location_on,
              size: 18,
              color: Colors.cyan,
            ),
            SizedBox(width: 6),
            SizedBox(
              width: 80,
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Enter city",
                  hintStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  ),
                  border: UnderlineInputBorder(
                   borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.person, size: 20, color: Colors.black),
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
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search bikes...",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 180,
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
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  bannerImages.length,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    height: 6,
                    width: currentIndex == index ? 13 : 6,
                    decoration: BoxDecoration(
                      color: currentIndex == index ? Colors.black : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Popular Bikes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 14),
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
                                fit: BoxFit.cover,
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
                          SizedBox(height: 4),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Icon(Icons.speed, size: 14),
                                SizedBox(width: 4),
                                Text(bike["cc"]),
                                SizedBox(width: 10),
                                Icon(Icons.local_gas_station, size: 14),
                                SizedBox(width: 4),
                                Text(bike["km"]),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                "The Most Sell Bikes Brands",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bikeList.length,
                  itemBuilder: (context, index) {
                    var bike = bikeList[index];
                    return Container(
                      height: 170,
                      width: 280,
                      margin: EdgeInsets.only(right: 12),
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
                            height: 160,
                            width: 275,
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
                              horizontal: 12,
                              vertical: 4,
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
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "View Bikes Details",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
