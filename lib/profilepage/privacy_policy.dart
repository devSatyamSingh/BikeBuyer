import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
          "Privacy Policy",
          style: TextStyle(color: Colors.black, fontFamily: 'Poppins',),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(14),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy Policy",
                style: TextStyle(
                  fontSize: w * 0.044,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Last updated: 2026",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 14),
              bodyText(
                "BikeBuyer respects your privacy and is committed to protecting "
                    "the personal information of its users. This Privacy Policy explains "
                    "how information is collected, used, disclosed, and safeguarded when "
                    "you access or use the BikeBuyer mobile application or website.",
              ),
              sectionTitle("1. Scope of This Policy"),
              bodyText(
                "This Privacy Policy applies to all users who access the BikeBuyer "
                    "platform for browsing, buying, or selling two-wheelers. By using our "
                    "services, you consent to the practices described in this policy.",
              ),
              sectionTitle("2. Information We Collect"),
              bodyText(
                "We may collect personal information such as your name, mobile number, "
                    "email address, city, and location when you register or interact with "
                    "the platform. We may also collect vehicle-related details when you "
                    "list a bike for sale.",
              ),
              sectionTitle("3. Automatically Collected Information"),
              bodyText(
                "When you use BikeBuyer, certain information such as device type, "
                    "IP address, app usage data, and location information may be "
                    "automatically collected to improve platform performance and user experience.",
              ),
              sectionTitle("4. Use of Collected Information"),
              bodyText(
                "The information collected is used to provide, maintain, and improve "
                    "our services, facilitate buyer-seller interactions, personalize content, "
                    "send notifications, and ensure platform security.",
              ),
              sectionTitle("5. Sharing of Information"),
              bodyText(
                "BikeBuyer does not sell or rent your personal information. Information "
                    "may be shared with sellers, buyers, or third-party service providers "
                    "only when necessary to complete a transaction or provide services.",
              ),
              sectionTitle("6. Third-Party Services"),
              bodyText(
                "BikeBuyer may integrate third-party tools such as maps, analytics, "
                    "or notification services. These third parties have their own privacy "
                    "policies and BikeBuyer is not responsible for their practices.",
              ),
              sectionTitle("7. Data Security"),
              bodyText(
                "We implement reasonable security measures to protect your information "
                    "from unauthorized access, misuse, or disclosure. However, no method "
                    "of electronic transmission is completely secure.",
              ),
              sectionTitle("8. User Responsibilities"),
              bodyText(
                "Users are responsible for maintaining the confidentiality of their "
                    "account credentials. BikeBuyer shall not be liable for unauthorized "
                    "access resulting from user negligence.",
              ),
              sectionTitle("9. Cookies & Tracking Technologies"),
              bodyText(
                "We may use cookies or similar technologies to enhance user experience, "
                    "analyze trends, and improve platform functionality.",
              ),
              sectionTitle("10. Data Retention"),
              bodyText(
                "Personal data is retained only for as long as necessary to fulfill "
                    "the purposes outlined in this policy or as required by law.",
              ),
              sectionTitle("11. Changes to This Policy"),
              bodyText(
                "BikeBuyer reserves the right to update this Privacy Policy at any time. "
                    "Users are encouraged to review this page periodically.",
              ),
              sectionTitle("12. Contact Us"),
              bodyText(
                "If you have any questions or concerns regarding this Privacy Policy, "
                    "you may contact BikeBuyer support through the application.",
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget bodyText(String text) {
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
