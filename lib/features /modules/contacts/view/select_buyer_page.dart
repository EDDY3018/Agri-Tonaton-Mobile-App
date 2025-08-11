// ignore_for_file: prefer_const_constructors
import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:agri_tonaton/core/utils/customContiner.dart';
import 'package:agri_tonaton/features%20/modules/contacts/view/widgets/buyer_tile.dart';
import 'package:agri_tonaton/features%20/modules/contacts/view/widgets/search_bar_card.dart';
import 'package:agri_tonaton/features%20/modules/contacts/view_model/contacts_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/buyers_list_page.dart';
import 'widgets/camera_fab.dart';

class SelectBuyerPage extends StatelessWidget {
  const SelectBuyerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ContactsViewModel>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Select Buyer'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CustomButton(
              label: 'Add Buyer',
              backgroundColor: PRIMARY,
              textColor: Colors.white,
              onPressed: () {/* open add-buyer flow */},
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 6),
          SearchBarCard(
            dropdown: vm.dropdown,
            onDropdownChanged: vm.setDropdown,
            controller: vm.searchCtl,
            onChanged: vm.onSearch,
            onMore: () {},
          ),
          const Divider(height: 1, color: Color(0xFFEDEDED)),
          Expanded(
            child: vm.loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemCount: vm.list.length,
                    separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFEDEDED)),
                    itemBuilder: (_, i) {
                      final b = vm.list[i];
                      return BuyerTile(
                        buyer: b,
                        onChanged: (v) => vm.toggle(b.id, v),
                        onCall: () => _dial(b.phone),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CameraFab(onTap: () async {
        await vm.persistSelection(); // save to Firestore
        if (!context.mounted) return;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => BuyersListPage(selectedBuyers: vm.selected),
        ));
      }),

    );
  }

  Future<void> _dial(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}
