import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Notifications",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(screenWidth * 0.04), // responsive
        children: [
          notificationTile(
            context: context,
            title: "New bike added!",
            subtitle: "Check out the latest KTM bike just launched.",
            time: "2 min ago",
            isNew: true,
          ),
          notificationTile(
            context: context,
            title: "Price dropped",
            subtitle: "Royal Enfield price dropped near you.",
            time: "1 hour ago",
          ),
          notificationTile(
            context: context,
            title: "New offer",
            subtitle: "Get exciting EMI offers on Yamaha bikes.",
            time: "Yesterday",
          ),
          notificationTile(
            context: context,
            title: "Your ad is live",
            subtitle: "Your bike ad is now visible to buyers.",
            time: "2 days ago",
          ),
        ],
      ),
    );
  }

  Widget notificationTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String time,
    bool isNew = false,
  }) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(
        bottom: screenHeight * 0.02,
      ),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: isNew
            ? Colors.purple.shade50
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(
          screenWidth * 0.03,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: screenWidth * 0.045,
            backgroundColor: Colors.purple.shade100,
            child: Icon(
              Icons.notifications,
              size: screenWidth * 0.045,
              color: Colors.purple,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.038,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (isNew)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: screenHeight * 0.002,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.01,
                          ),
                        ),
                        child: Text(
                          "NEW",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.025,
                          ),
                        ),
                      ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.005),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: screenWidth * 0.032,
                    color: Colors.grey.shade700,
                  ),
                ),

                SizedBox(height: screenHeight * 0.008),

                Text(
                  time,
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
