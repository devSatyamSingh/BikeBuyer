import 'package:flutter/material.dart';
import 'dealerlistpage.dart';

class Finddealerpage extends StatefulWidget {
  const Finddealerpage({super.key});

  @override
  State<Finddealerpage> createState() => _FinddealerpageState();
}

class _FinddealerpageState extends State<Finddealerpage> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> brands = [
    {"name": "Hero", "img": "assets/images/herologo.png"},
    {"name": "Honda", "img": "assets/images/hondalogo3.jpg"},
    {"name": "Yamaha", "img": "assets/images/yamahalogo.webp"},
    {"name": "Bajaj", "img": "assets/images/Bajajlogo.webp"},
    {"name": "TVS", "img": "assets/images/tvslogo3.png"},
    {"name": "Royal Enfield", "img": "assets/images/royalnewlogo.png"},
    {"name": "KTM", "img": "assets/images/ktmlogo.png"},
    {"name": "Kawasaki", "img": "assets/images/kawa2logo.webp"},
    {"name": "Triumph", "img": "assets/images/triumplogo.webp"},
    {"name": "BMW", "img": "assets/images/bmwlogo.png"},
    {"name": "Ola", "img": "assets/images/olalogo2.png"},
    {"name": "Ducati", "img": "assets/images/Ducatilogo.png"},
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Find Dealer",
          style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins',),
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search by Brand",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            SizedBox(height: 18),
            Text(
              "Select Brand",
              style: TextStyle(fontSize: 17, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 14),
            Expanded(
              child: GridView.builder(
                itemCount: brands.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final brand = brands[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DealerListPage(
                            brandName: brand["name"]!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            brand["img"]!,
                            height: w * 0.12,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            brand["name"]!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
