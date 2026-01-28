import 'package:flutter/material.dart';

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
    {"name": "Royal Enfield Hunter", "price": "₹1.70 Lakh", "img": "assets/images/bullet.jpg"},
    {"name": "Honda CB350", "price": "₹2.10 Lakh", "img": "assets/images/honda.jpg"},
    {"name": "Jawa 42", "price": "₹1.95 Lakh", "img": "assets/images/hero1.webp"},
    {"name": "TVS Ronin", "price": "₹1.49 Lakh", "img": "assets/images/pulsar1.png"},
    {"name": "Yamaha FZ-X", "price": "₹1.36 Lakh", "img": "assets/images/R15.webp"},
    {"name": "Bajaj Dominar 400", "price": "₹2.30 Lakh", "img": "assets/images/pulsar1.png"},
    {"name": "KTM Duke 250", "price": "₹2.39 Lakh", "img": "assets/images/ktm2.webp"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Similar Bikes",
          style: TextStyle(
            fontSize: widget.w * 0.045,
            fontWeight: FontWeight.bold,
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
              return Container(
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
                          bike["img"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        bike["name"],
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      bike["price"],
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}
