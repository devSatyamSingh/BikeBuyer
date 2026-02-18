import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [
    {
      "title": "New bike added!",
      "subtitle": "Check out the latest KTM bike just launched.",
      "time": "2 min ago",
      "isNew": true,
    },
    {
      "title": "Price dropped",
      "subtitle": "Royal Enfield price dropped near you.",
      "time": "1 hour ago",
      "isNew": false,
    },
    {
      "title": "New offer",
      "subtitle": "Get exciting EMI offers on Yamaha bikes.",
      "time": "Yesterday",
      "isNew": false,
    },
    {
      "title": "Your ad is live",
      "subtitle": "Your bike ad is now visible to buyers.",
      "time": "2 days ago",
      "isNew": false,
    },
  ];

  void _confirmDeleteAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text(
          "Delete All Notifications?",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 21),
        ),
        content: Text(
          "Are you sure you want to delete all notifications?",
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "No",
              style: TextStyle(fontFamily: 'Poppins', color: Colors.black ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              setState(() {
                notifications.clear();
              });
              Navigator.pop(context);
            },
            child: const Text(
              "Yes",
              style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
        ),
        actions: [
          if (notifications.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: _confirmDeleteAll,
              ),
            ),
        ],
      ),

      body: notifications.isEmpty
          ? _buildEmptyState(screenWidth)
          : ListView.builder(
              padding: EdgeInsets.all(screenWidth * 0.04),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];

                return Container(
                  margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: item["isNew"] ? Colors.purple.shade50 : Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
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
                                    item["title"],
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: screenWidth * 0.037,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                                /// 🔥 DELETE ICON LEFT SHIFTED
                                Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        notifications.removeAt(index);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: 22,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            Text(
                              item["subtitle"],
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: screenWidth * 0.031,
                                color: Colors.grey.shade700,
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.008),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item["time"],
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: screenWidth * 0.03,
                                    color: Colors.grey,
                                  ),
                                ),
                                if (item["isNew"])
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
                                        fontFamily: 'Poppins',
                                        fontSize: screenWidth * 0.025,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  /// 🔥 EMPTY STATE UI
  Widget _buildEmptyState(double screenWidth) {
    return Center(
      child: Container(
        width: screenWidth * 0.85,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 65,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 15),
            const Text(
              "No Notifications Yet",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "You're all caught up!\nNew updates will appear here.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
