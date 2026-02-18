import 'package:flutter/material.dart';
import '../modal/brandmodel.dart';
import '../modal/vehicalmodel.dart';
import '../widget/pagenavigationanimation.dart';
import 'brandbikespage.dart';

class PopularBrandsSection extends StatelessWidget {
  final List<BrandModel> brands;
  final List<VehicleModel> allBikes;

  const PopularBrandsSection({
    super.key,
    required this.brands,
    required this.allBikes,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Popular Brands",
          style: TextStyle(
            fontSize: w * 0.043,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            final brand = brands[index];
            return GestureDetector(
              onTap: () {
                List<VehicleModel> filtered = allBikes.where((bike) {
                  return bike.brandName.toLowerCase() ==
                      brand.name.toLowerCase();
                }).toList();
                Navigator.push(
                  context,
                  SlidePageRoute(
                    page: BrandBikesPage(
                      brandName: brand.name,
                      bikes: filtered,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: brand.logo != null
                      ? Image.network(
                    brand.logo!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_not_supported),
                  )
                      : const Icon(Icons.image_not_supported),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}