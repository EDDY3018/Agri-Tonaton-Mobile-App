// ignore_for_file: prefer_const_constructors
import 'package:agri_tonaton/core/utils/customContiner.dart' show CustomButton;
import 'package:agri_tonaton/features%20/modules/contacts/model/buyer_model.dart';
import 'package:agri_tonaton/features%20/modules/contacts/view/widgets/camera_fab.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/app_colors.dart';
import 'buyer_tile.dart';

class BuyersListPage extends StatelessWidget {
  final List<Buyer> selectedBuyers;
  const BuyersListPage({super.key, required this.selectedBuyers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Buyers List'),
      ),
      body: Column(
        children: [
          const Divider(height: 1, color: Color(0xFFEDEDED)),
          Expanded(
            child: ListView.separated(
              itemCount: selectedBuyers.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: Color(0xFFEDEDED)),
              itemBuilder: (_, i) {
                final b = selectedBuyers[i];
                return BuyerTile(
                  buyer: b,
                  onChanged: (_) {}, // locked checked
                  onCall: () => _dial(b.phone),
                  forceChecked: true,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: CustomButton(
              label: 'Send Notification',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notification sent')),
                );
              },
              backgroundColor: PRIMARY,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CameraFab(onTap: () {}),
    );
  }

  Future<void> _dial(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}

extension _FabCopy on CameraFab {
  CameraFab copyWith({VoidCallback? onTap}) =>
      CameraFab(onTap: onTap ?? this.onTap);
}
