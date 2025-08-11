import 'package:flutter/material.dart';
import 'package:agri_tonaton/core/utils/app_colors.dart';
import '../../../../../core/utils/customContiner.dart';


class ProductDetailSection extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String date;
  final String location;
  final String description;

  const ProductDetailSection({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.date,
    required this.location,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: SECADE.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.person, color: PRIMARY),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Manoj Kumar", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Theni, TamilNadu"),
                ],
              ),
              const Spacer(),
              Icon(Icons.call, color: PRIMARY),
            ],
          ),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Icon(Icons.attach_money, color: PRIMARY),
            const SizedBox(width: 4),
            Text(price),
            const Spacer(),
            Icon(Icons.calendar_month, color: PRIMARY),
            const SizedBox(width: 4),
            Text(date),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.location_on, color: PRIMARY),
            const SizedBox(width: 4),
            Text(location),
          ],
        ),
        const SizedBox(height: 12),
        Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(description, maxLines: 5, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 16),
        CustomButton(label: "Add to Cart", onPressed: () {}),
      ],
    );
  }
}
