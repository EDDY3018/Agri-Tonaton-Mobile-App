import 'package:agri_tonaton/core/utils/customContiner.dart';
import 'package:agri_tonaton/features%20/modules/home/view/widgets/location_header.dart';
import 'package:agri_tonaton/features%20/modules/home/view/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:agri_tonaton/core/utils/app_colors.dart';

import 'widgets/market_price_tile.dart';
import 'widgets/product_carousel.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LocationHeader(),
            const SizedBox(height: 16),

            Container(
              margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
              child: CustomButton(label: "Sell My Product", onPressed: () {}),
            ),
            const SizedBox(height: 12),

            const SizedBox(height: 24),
            const SectionHeader(title: "Market Price"),
            const SizedBox(height: 12),

            MarketPriceTile(
              imageUrl: 'assets/rice.png',
              title: "Rice Seed",
              family: "Monstera family",
              price: "Ghc 55/Kg",
              rating: 4.8,
            ),
            MarketPriceTile(
              imageUrl: 'assets/mango.png',
              title: "Mango",
              family: "Monstera family",
              price: "Ghc 40/Kg",
              rating: 4.2,
            ),
            MarketPriceTile(
              imageUrl: 'assets/wheat.png',
              title: "Weat Seeds",
              family: "Monstera family",
              price: "Ghc 30/Kg",
              rating: 3.9,
            ),

            const SizedBox(height: 24),
            const SectionHeader(title: "Available Products"),
            const SizedBox(height: 12),
            const ProductCarousel(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
