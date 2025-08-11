import 'package:flutter/material.dart';

import 'profile_stat.dart';


class ProfileHeader extends StatelessWidget {
  final String name;
  final String location;
  final String? photoUrl;
  final String totalOrders;
  final String pendingOrders;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.location,
    required this.photoUrl,
    required this.totalOrders,
    required this.pendingOrders,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        const Text("My Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),

        // Avatar + stats rail
        Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  ProfileStatChip(title: "Total Orders", value: totalOrders),
                  const SizedBox(width: 12),
                  ProfileStatChip(title: "Pending Orders", value: pendingOrders),
                ],
              ),
            ),
            CircleAvatar(
              radius: 54,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    (photoUrl != null && photoUrl!.isNotEmpty) ? NetworkImage(photoUrl!) : null,
                child: (photoUrl == null || photoUrl!.isEmpty)
                    ? const Icon(Icons.person, size: 48, color: Colors.black38)
                    : null,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),
        Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF0B8A2A))),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, size: 16, color: Color(0xFF0B8A2A)),
            const SizedBox(width: 4),
            Text(location, style: const TextStyle(color: Colors.black54)),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
