import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDealerPage extends StatefulWidget {
  final Map seller;

  const ContactDealerPage({super.key, required this.seller});

  @override
  State<ContactDealerPage> createState() => _ContactDealerPageState();
}

class _ContactDealerPageState extends State<ContactDealerPage> {


  Future<void> callDealer(String phone) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      showError("Unable to open phone dialer");
    }
  }

  Future<void> openWhatsApp(String phone) async {
    final String whatsappUrl = "https://wa.me/$phone";
    final Uri uri = Uri.parse(whatsappUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      showError("WhatsApp not installed");
    }
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: TextStyle(fontFamily: 'Poppins')),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "Contact Dealer",
          style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
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
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.purple.shade100,
                    child: Icon(Icons.store, size: 33, color: Colors.purple),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.seller["name"],
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: w * 0.048,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        widget.seller["location"],
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 35),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Column(
                children: [
                  contactTile(
                    icon: Icons.call,
                    color: Colors.green,
                    title: "Call Dealer",
                    subtitle: widget.seller["phone"],
                    onTap: () {
                      callDealer(widget.seller["phone"]);
                    },
                  ),

                  Divider(height: 40),
                  contactTile(
                    icon: FontAwesomeIcons.whatsapp,
                    color: Colors.green.shade700,
                    title: "Chat on WhatsApp",
                    subtitle: "Quick response from seller",
                    onTap: () {
                      openWhatsApp(widget.seller["whatsapp"]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color),
          ),
          SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
