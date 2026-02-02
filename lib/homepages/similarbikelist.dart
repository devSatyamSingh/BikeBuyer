import 'package:flutter/material.dart';
import 'bikedetailpage.dart';

class SimilarBikesSection extends StatefulWidget {
  final double w;
  final double h;

  const SimilarBikesSection({
    super.key,
    required this.w,
    required this.h,
  });

  @override
  State<SimilarBikesSection> createState() => _SimilarBikesSectionState();
}

class _SimilarBikesSectionState extends State<SimilarBikesSection> {

  List similarBikes = [
    {
      "name": "Royal Enfield Hunter",
      "price": "₹1.70 Lakh",
      "brand": "Royal Enfield",
      "cc": "349 cc",
      "km": "36 kmpl",
      "runKm": "6,000 km",
      "fuel": "Petrol",
      "regYear": "2022",
      "owner": "1st Owner",
      "rto": "UP32",
      "location": "Lucknow, UP",
      "images": [
        "assets/images/bullet.jpg",
        "assets/images/bullet.jpg",
        "assets/images/bullet.jpg",
        "assets/images/bulletbg.jpg",
        "assets/images/bulletfront.webp",
      ],
    },
    {
      "name": "Honda CB350",
      "price": "₹2.10 Lakh",
      "brand": "Honda",
      "cc": "348 cc",
      "km": "35 kmpl",
      "runKm": "4,500 km",
      "fuel": "Petrol",
      "regYear": "2021",
      "owner": "1st Owner",
      "rto": "UP32",
      "location": "Ayodhya, UP",
      "images": [
        "assets/images/honda.jpg",
        "assets/images/honda.jpg",
        "assets/images/honda.jpg",
        "assets/images/honda.jpg",
        "assets/images/honda.jpg",
      ],
    },
    {
      "name": "Jawa 42",
      "price": "₹1.95 Lakh",
      "brand": "Jawa",
      "cc": "293 cc",
      "km": "33 kmpl",
      "runKm": "7,200 km",
      "fuel": "Petrol",
      "regYear": "2020",
      "owner": "2nd Owner",
      "rto": "UP62",
      "location": "Varanasi, UP",
      "images": [
        "assets/images/hero1.webp",
        "assets/images/hero1.webp",
        "assets/images/hero1.webp",
        "assets/images/hero1.webp",
        "assets/images/hero1.webp",
      ],
    },
    {
      "name": "TVS Ronin",
      "price": "₹1.49 Lakh",
      "brand": "TVS",
      "cc": "225 cc",
      "km": "42 kmpl",
      "runKm": "5,300 km",
      "fuel": "Petrol",
      "regYear": "2022",
      "owner": "1st Owner",
      "rto": "UP32",
      "location": "Prayagraj, UP",
      "images": [
        "assets/images/pulsar1.png",
        "assets/images/pulsar1.png",
        "assets/images/pulsar1.png",
        "assets/images/pulsar1.png",
        "assets/images/pulsar1.png",
      ],
    },
    {
      "name": "Yamaha FZ-X",
      "price": "₹1.36 Lakh",
      "brand": "Yamaha",
      "cc": "149 cc",
      "km": "48 kmpl",
      "runKm": "6,800 km",
      "fuel": "Petrol",
      "regYear": "2021",
      "owner": "1st Owner",
      "rto": "UP62",
      "location": "Jaunpur, UP",
      "images": [
        "assets/images/R15.webp",
        "assets/images/R15.webp",
        "assets/images/R15.webp",
        "assets/images/R15.webp",
        "assets/images/R15.webp",
      ],
    },
    {
      "name": "Bajaj Dominar 400",
      "price": "₹2.30 Lakh",
      "brand": "Bajaj",
      "cc": "373 cc",
      "km": "27 kmpl",
      "runKm": "9,000 km",
      "fuel": "Petrol",
      "regYear": "2020",
      "owner": "1st Owner",
      "rto": "UP32",
      "location": "Kanpur, UP",
      "images": [
        "assets/images/pulsar1.png",
        "assets/images/pulsar1.png",
        "assets/images/pulsar1.png",
        "assets/images/pulsar1.png",
        "assets/images/pulsar1.png",
      ],
    },
    {
      "name": "KTM Duke 250",
      "price": "₹2.39 Lakh",
      "brand": "KTM",
      "cc": "248 cc",
      "km": "30 kmpl",
      "runKm": "4,200 km",
      "fuel": "Petrol",
      "regYear": "2022",
      "owner": "1st Owner",
      "rto": "UP32",
      "location": "Lucknow, UP",
      "images": [
        "assets/images/ktm2.webp",
        "assets/images/ktm2.webp",
        "assets/images/ktm2.webp",
        "assets/images/ktm2.webp",
        "assets/images/ktm2.webp",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Similar Bikes",
          style: TextStyle(
            fontSize: widget.w * 0.044,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: widget.h * 0.017),
        SizedBox(
          height: widget.h * 0.26,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: similarBikes.length,
            itemBuilder: (context, index) {
              final bike = similarBikes[index];
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
                  width: widget.w * 0.60,
                  margin: EdgeInsets.only(right: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 8),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            bike["images"][0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          bike["name"],
                          style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins',),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        bike["price"],
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
