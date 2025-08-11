import 'package:flutter/material.dart';

class ProductCarousel extends StatelessWidget {
  const ProductCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCard("assets/rice.png"),
          _buildCard("assets/wheat.png"),
          _buildCard("assets/mango.png"),
        ],
      ),
    );
  }

  Widget _buildCard(String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: 140,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          border: Border.all(color: Colors.green),
        ),
      ),
    );
  }
}
