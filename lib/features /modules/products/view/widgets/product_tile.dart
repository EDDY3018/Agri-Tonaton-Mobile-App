import 'package:flutter/material.dart';
import 'package:agri_tonaton/core/utils/app_colors.dart';
import '../../model/product_model.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductTile({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: SECADE.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: PRIMARY),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(product.imageUrl, fit: BoxFit.cover, height: 100, width: double.infinity),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(product.price),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      product.selected ? Icons.check_box : Icons.check_box_outline_blank,
                      color: PRIMARY,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
