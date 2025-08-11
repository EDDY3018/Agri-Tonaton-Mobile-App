import 'package:flutter/material.dart';
import 'package:agri_tonaton/core/utils/app_colors.dart';

class LocationHeader extends StatelessWidget {
  const LocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        color: PRIMARY,
      ),
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.location_pin, color: WHITE),
              SizedBox(width: 4),
              Text("Chinnaya", style: TextStyle(color: WHITE)),
              Spacer(),
              Icon(Icons.chat_bubble_outline, color: WHITE),
              SizedBox(width: 8),
              Stack(
                children: [
                  Icon(Icons.notifications, color: WHITE),
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.red,
                      child: Text(
                        "2",
                        style: TextStyle(fontSize: 8, color: WHITE),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: const [
              Icon(Icons.location_pin, color: WHITE),
              SizedBox(width: 4),
              Text("Karur, Tamilnadu ", style: TextStyle(color: WHITE)),
            ],
          ),
        ],
      ),
    );
  }
}
