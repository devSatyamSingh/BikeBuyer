import 'package:bikebuyer/homepages/hometabs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../homepages/bikedetailpage.dart';
import '../homepages/bikeditailspagess.dart';
import '../modal/vehicalmodel.dart';
import '../widget/app_snackbar.dart';
import '../widget/loderanimation.dart';
import '../widget/pagenavigationanimation.dart';
import '../widget/wishlist_service.dart';
import 'loginpage.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  bool isSearching = false;
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  List<VehicleModel> wishlist = [];
  List<VehicleModel> filteredWishlist = [];

  @override
  void initState() {
    super.initState();
    checkLoginAndLoad();
  }

  Future<void> checkLoginAndLoad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    if (!isLoggedIn) {
      if (!mounted) return;
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
      SharedPreferences prefsAfter =
      await SharedPreferences.getInstance();
      bool loggedInNow =
          prefsAfter.getBool("isLoggedIn") ?? false;
      if (!loggedInNow) {
        setState(() {
          isLoading = false;
        });
        AppSnackBar.show(
          context,
          message: "Please login to view wishlist",
          type: SnackType.warning,
        );
        return;
      }

    }
    await loadWishlist();
  }

  Future<void> loadWishlist() async {
    setState(() {
      isLoading = true;
    });
    final data = await WishlistService.getWishlist();
    setState(() {
      wishlist = data;
      filteredWishlist = data;
      isLoading = false;
    });
  }

  void searchWishlist(String query) {
    query = query.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        filteredWishlist = List.from(wishlist);
      } else {
        filteredWishlist = wishlist.where((bike) {
          return ("${bike.brandName} ${bike.model}").toLowerCase().contains(
            query,
          );
        }).toList();
      }
    });
  }

  void openBikeDetails(BuildContext context, VehicleModel bike) {
    Navigator.push(context, SlidePageRoute(page: BikeDetailPages(bike: bike)));
  }

  Future<void> removeBike(VehicleModel bike) async {
    await WishlistService.removeFromWishlist(bike.vehicleId);
    await loadWishlist();

    AppSnackBar.show(
      context,
      message: "Removed from wishlist",
      type: SnackType.success,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (isSearching) {
              setState(() {
                isSearching = false;
                searchController.clear();
                filteredWishlist = List.from(wishlist);
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeTabs()),
              );
            }
          },
        ),
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                onChanged: searchWishlist,
                decoration: const InputDecoration(
                  hintText: "Search wishlist bikes...",
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
              )
            : const Text(
                "Wishlist",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
        actions: [
          if (!isSearching && wishlist.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: "Clear All",
              onPressed: showClearAllDialog,
            ),
          Padding(
            padding: const EdgeInsets.only(right: 17),
            child: IconButton(
              icon: Icon(
                isSearching ? Icons.close : Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    searchController.clear();
                    filteredWishlist = List.from(wishlist);
                  }
                });
              },
            ),
          ),
        ],
      ),
      body: isLoading
          ? const SegmentLoader()
          : RefreshIndicator(
              color: Colors.purple,
              onRefresh: loadWishlist,
              child: wishlist.isEmpty
                  ? const Center(
                      child: Text(
                        "Your wishlist is empty ❤️",
                        style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                      ),
                    )
                  : filteredWishlist.isEmpty
                  ? const Center(
                      child: Text(
                        "Bike not found 😕",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(12),
                      itemCount: filteredWishlist.length,
                      itemBuilder: (context, index) {
                        final bike = filteredWishlist[index];

                        return GestureDetector(
                          onTap: () => openBikeDetails(context, bike),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: bike.images.isNotEmpty
                                      ? Image.network(
                                          bike.images.first,
                                          height: 70,
                                          width: 90,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(
                                                Icons.image_not_supported,
                                              ),
                                        )
                                      : const Icon(Icons.image_not_supported),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${bike.brandName} ${bike.model}",
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${bike.city}, ${bike.state}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "₹${bike.price}",
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    PopupMenuButton<String>(
                                      color: Colors.white,
                                      onSelected: (value) async {
                                        if (value == "delete") {
                                          await removeBike(bike);
                                        }
                                      },
                                      itemBuilder: (context) => const [
                                        PopupMenuItem(
                                          value: "delete",
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete, size: 18),
                                              SizedBox(width: 7),
                                              Text(
                                                "Remove",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }

  void showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Clear Wishlist",
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          content: const Text(
            "Are you sure you want to remove all items from wishlist?",
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () async {
                await WishlistService.clearWishlist();
                Navigator.pop(context);
                await loadWishlist();

                AppSnackBar.show(
                  context,
                  message: "Wishlist cleared successfully",
                  type: SnackType.success,
                );
              },

              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text("Yes", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
