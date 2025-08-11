import 'package:flutter/material.dart';
import 'package:agri_tonaton/core/utils/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Spacer(),
          Container(
            width: 70,
            height: 32,
            decoration: BoxDecoration(
              color: const Color.fromARGB(173, 5, 91, 29),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "View All",
                style: TextStyle(color: WHITE, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
