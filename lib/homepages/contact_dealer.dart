
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactDealerPage extends StatefulWidget {
  final Map seller;

  const ContactDealerPage({super.key, required this.seller});

  @override
  State<ContactDealerPage> createState() => _ContactDealerPageState();
}

class _ContactDealerPageState extends State<ContactDealerPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Contact Dealer", style : TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
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
                    radius: 32,
                    backgroundColor: Colors.purple.shade100,
                    child: Icon(Icons.store, size: 34, color: Colors.purple),
                  ),
                  SizedBox(height: 12),
                  Text(
                    widget.seller["name"],
                    style: TextStyle(
                      fontSize: w * 0.048,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        widget.seller["location"],
                        style: TextStyle(color: Colors.black54),
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
                      //  later: launch("tel:${seller["phone"]}");
                    },
                  ),
                  Divider(height: 50, thickness: 3),
                  contactTile(
                    icon: FontAwesomeIcons.whatsapp,
                    color: Colors.green.shade700,
                    title: "Chat on WhatsApp",
                    subtitle: "Quick response from seller",
                    onTap: () {
                      // 🔹 later:
                      // launch("https://wa.me/${seller["whatsapp"]}");
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
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(height: 3),
              Text(subtitle,
                  style: TextStyle(color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }
}

