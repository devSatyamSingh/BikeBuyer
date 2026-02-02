import 'package:flutter/material.dart';

class TermsConditionPage extends StatefulWidget {
  const TermsConditionPage({super.key});

  @override
  State<TermsConditionPage> createState() => _TermsConditionPageState();
}

class _TermsConditionPageState extends State<TermsConditionPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 3,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Terms & Conditions",
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins',),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(13),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Terms and Conditions",
                style: TextStyle(
                  fontSize: w * 0.044,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12),
              sectionText(
                "Welcome to BikeBuyer, a digital platform that enables users to buy and sell "
                    "two-wheelers through registered sellers, dealers, and individual owners. "
                    "By accessing, browsing, or using the BikeBuyer mobile application or website, "
                    "you agree to comply with and be bound by these Terms & Conditions. If you do not "
                    "agree with any part of these terms, you must refrain from using the platform. "
                    "These terms constitute a legally binding agreement between you (“User”) and BikeBuyer",
              ),
              sectionTitle("1. Nature of Services"),
              sectionText(
                "BikeBuyer acts as an online marketplace that connects buyers with sellers and dealers. "
                    "The platform does not directly sell, purchase, inspect, or guarantee any vehicle listed on the app."
                    " All listings, prices, descriptions, and images are provided by sellers or dealers."
                    " BikeBuyer only facilitates discovery, communication,"
                    " and lead generation between users.",
              ),
              sectionTitle("2. User Eligibility & Registration"),
              sectionText(
                "To use BikeBuyer services, you must be at least 18 years of age and capable of entering into a legally binding agreement. Users are required to register using a valid mobile number and may be required to provide additional details such as name, city, and vehicle information. You are responsible for maintaining the confidentiality of your login credentials and for all activities carried out under your account.",
              ),
              sectionTitle("3. Seller Responsibilities"),
              sectionText(
                "Users who list a bike for sale must ensure that all information provided is accurate, complete, and lawful. This includes vehicle ownership details, registration information, condition, price, images, and mileage. Any misleading, fraudulent, or false listing may be removed without notice, and BikeBuyer reserves the right to suspend or terminate such accounts.",
              ),
              sectionTitle("4. Buyer Responsibilities"),
              sectionText(
                "Buyers are advised to independently verify all details related to a vehicle before making any purchase decision. BikeBuyer does not conduct vehicle inspections, ownership verification, or price negotiations. Any transaction, agreement, or payment is strictly between the buyer and the seller. BikeBuyer is not responsible for disputes arising after a transaction.",
              ),
              sectionTitle("5. Payments & Transactions"),
              sectionText(
                "BikeBuyer does not handle payments between buyers and sellers unless explicitly stated. Any payment, advance, booking amount, or settlement is done at the user’s own risk. BikeBuyer shall not be liable for any financial loss, fraud, or payment disputes between users.",
              ),
              sectionTitle("6. Third-Party Dealers & Agencies"),
              sectionText(
                "The platform may display listings from third-party dealers, agencies, or resellers. BikeBuyer does not endorse or guarantee the quality, authenticity, or legality of such sellers. Users engaging with dealers do so at their own discretion and are advised to verify credentials independently.",
              ),
              sectionTitle("7. Prohibited Activities"),
              sectionText(
                "Users shall not misuse the platform for unlawful activities including but not limited to fraud, spamming, impersonation, uploading false documents, or posting prohibited content. Any violation may result in immediate account suspension, termination, or legal action as deemed necessary.",
              ),
              sectionTitle("8. Intellectual Property"),
              sectionText(
                "All content on the BikeBuyer platform, including logos, design, layout, text, graphics, and software, is the intellectual property of BikeBuyer and is protected by applicable copyright and trademark laws. Unauthorized reproduction, distribution, or modification of platform content is strictly prohibited.",
              ),
              sectionTitle("9. Limitation of Liability"),
              sectionText(
                "BikeBuyer shall not be liable for any direct, indirect, incidental, consequential, or special damages arising out of the use or inability to use the platform. This includes but is not limited to vehicle condition issues, financial loss, disputes, delays, or misrepresentation by sellers or buyers.",
              ),
              sectionTitle("10. Termination of Access"),
              sectionText(
                "BikeBuyer reserves the right to suspend or terminate any user account at its sole discretion, without prior notice, if the user violates these Terms & Conditions or engages in activities harmful to the platform or other users.",
              ),
              sectionTitle("11. Modifications & Governing Law"),
              sectionText(
                "BikeBuyer reserves the right to update or modify these Terms & Conditions at any time. Users are encouraged to review this page periodically. Continued use of the platform after changes constitutes acceptance of the updated terms. These terms shall be governed by and interpreted in accordance with the laws of India.",
              ),
              sectionTitle("12. Governing Law"),
              sectionText(
                "These terms shall be governed and interpreted in accordance with "
                    "the laws of India.",
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 17, bottom: 7),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget sectionText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        height: 1.6,
        fontFamily: 'Poppins',
        color: Colors.black87,
      ),
    );
  }
}

