import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "About Us",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About BikeBuyer",
                style: TextStyle(
                  fontSize: w * 0.046,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              paragraph(
                "BikeBuyer was built with a simple idea — to make buying and selling "
                    "two-wheelers easier, transparent, and more accessible for everyone. "
                    "We understand that a bike is not just a vehicle, but a part of daily life "
                    "for millions of people across India.",
              ),
              SizedBox(height: 12),
              paragraph(
                "Whether you are looking to buy your first bike, upgrade to a new one, "
                    "or sell your existing two-wheeler, BikeBuyer provides a trusted platform "
                    "where buyers, sellers, and agencies can connect with confidence.",
              ),
              sectionTitle("What We Do"),
              paragraph(
                "BikeBuyer is a digital marketplace that connects individual sellers, "
                    "verified dealers, and buyers on a single platform. Sellers can list their "
                    "bikes with detailed information, while buyers can explore multiple options "
                    "based on brand, price, location, and preferences.",
              ),
              sectionTitle("Our Vision"),
              paragraph(
                "Our vision is to simplify the two-wheeler buying and selling experience "
                    "by bringing transparency, convenience, and trust into every transaction. "
                    "We aim to become a platform where users feel confident while making "
                    "important vehicle decisions.",
              ),
              sectionTitle("Why BikeBuyer"),
              bulletPoint("Easy bike listing for sellers"),
              bulletPoint("Multiple bike options for buyers"),
              bulletPoint("Location-based discovery"),
              bulletPoint("Trusted dealers and agencies"),
              bulletPoint("Simple and user-friendly experience"),
              SizedBox(height: 10),
              sectionTitle("Our Commitment"),
              paragraph(
                "We are committed to continuously improving our platform based on user "
                    "feedback and evolving market needs. BikeBuyer focuses on building a "
                    "reliable ecosystem where users can make informed decisions without "
                    "unnecessary complexity.",
              ),
              SizedBox(height: 12),
              paragraph(
                "BikeBuyer does not directly buy or sell vehicles. Instead, we act as a "
                    "facilitator to help users connect, discover opportunities, and complete "
                    "transactions responsibly.",
              ),
              sectionTitle("Growing With You"),
              paragraph(
                "As BikeBuyer grows, we aim to introduce new features, smarter tools, "
                    "and better services that add value to both buyers and sellers. Our journey "
                    "is driven by trust, simplicity, and the belief that buying or selling a "
                    "bike should always be a smooth experience.",
              ),
              SizedBox(height: 14),
              Text(
                "Thank you for choosing BikeBuyer.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget sectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 18, bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget paragraph(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        height: 1.6,
        color: Colors.black87,
      ),
    );
  }


  Widget bulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("•  ", style: TextStyle(fontSize: 17)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
