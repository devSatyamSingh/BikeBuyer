import 'package:flutter/material.dart';
import '../modal/sellbikemodel.dart';
import '../seller/sellbikestore.dart';

class MySellListingsPage extends StatefulWidget {
  const MySellListingsPage({super.key});

  @override
  State<MySellListingsPage> createState() => _MySellListingsPageState();
}

class _MySellListingsPageState extends State<MySellListingsPage> {
  @override
  Widget build(BuildContext context) {
    final bikes = SellBikeStore.mySellBikes;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: Text("My Sell Listings" , style: TextStyle(fontFamily: 'Poppins'),),
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: bikes.isEmpty
          ? Center(child: Text("No bikes sell listings", style: TextStyle(color: Colors.grey.shade800, fontFamily: 'Poppins', fontSize: 17),))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: bikes.length,
        itemBuilder: (_, i) => _card(bikes[i]),
      ),
    );
  }

  Widget _card(SellBikeModel bike) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Image.file(
                  bike.images.first,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${bike.brand} ${bike.model}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(bike.price),
                      Text(bike.status,
                          style: TextStyle(
                            color: bike.status == "Approved"
                                ? Colors.green
                                : Colors.orange,
                          )),
                    ],
                  ),
                ),
              ],
            ),
             SizedBox(height: 10),
            Row(
              children: [
                if (bike.status == "Pending")
                TextButton(
                  onPressed: () {
                    setState(() {
                      SellBikeStore.deleteBike(bike.id);
                    });
                  },
                  child: Text("Delete"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
