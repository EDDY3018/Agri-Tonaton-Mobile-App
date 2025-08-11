import 'package:agri_tonaton/features%20/modules/profile/view/inbound_order_page.dart';
import 'package:agri_tonaton/features%20/modules/profile/view_model/profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/edit_profile.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_option_tile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (_, vm, __) {
        if (vm.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = vm.user;
        final displayName = user?.fullName ?? 'Guest';
        final location = user?.location ?? '—';
        final photoUrl = user?.photoUrl;

        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FA),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                children: [
                  ProfileHeader(
                    name: displayName,
                    location: location,
                    photoUrl: photoUrl,
                    totalOrders: vm.totalOrders.toString(),
                    pendingOrders: vm.pendingOrders.toString(),
                  ),
                  const SizedBox(height: 12),

                  ProfileOptionTile(
                    icon: Icons.edit,
                    title: "Edit Profile",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const EditProfilePage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 14),

                  ProfileOptionTile(
                    icon: Icons.payment,
                    title: "Payment Method",
                    onTap: () {}, // TODO
                  ),
                  const SizedBox(height: 14),

                  ProfileOptionTile(
                    icon: Icons.history,
                    title: "In Bound Orders History",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => InboundOrdersPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 14),

                  ProfileOptionTile(
                    icon: Icons.settings,
                    title: "Settings",
                    onTap: () {},
                  ),
                  const SizedBox(height: 14),

                  ProfileOptionTile(
                    icon: Icons.privacy_tip_outlined,
                    title: "Privacy policy",
                    onTap: () {},
                  ),
                  const SizedBox(height: 14),

                  ProfileOptionTile(
                    icon: Icons.logout,
                    title: "Log out",
                    onTap: vm.logout,
                  ),
                  const SizedBox(height: 14),

                  ProfileOptionTile(
                    icon: Icons.list_alt_outlined,
                    title: "My Orders",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const InboundOrdersPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Your bottom nav sits outside this screen normally
        );
      },
    );
  }
}
