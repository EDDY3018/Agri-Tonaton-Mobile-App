// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:agri_tonaton/features%20/modules/camera/view/camera.dart';
import 'package:agri_tonaton/features%20/modules/contacts/view/contacts.dart';
import 'package:agri_tonaton/features%20/modules/home/view/home.dart';
import 'package:agri_tonaton/features%20/modules/products/view/products.dart';
import 'package:agri_tonaton/features%20/modules/profile/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BTNAV extends StatelessWidget {
  final int pageIndex;
  const BTNAV({required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: PersistentTabController(initialIndex: pageIndex),
      tabs: [
        PersistentTabConfig(
          screen: Home(),
          item: ItemConfig(
            icon: Icon(Icons.tips_and_updates, color: BLACK),
            title: "Home",
            activeForegroundColor: WHITE,
            inactiveForegroundColor: BLACK,
          ),
        ),
        PersistentTabConfig(
          screen: Contacts(),
          item: ItemConfig(
            icon: Icon(Icons.monitor_heart_sharp, color: BLACK),
            title: "Contacts",
            activeForegroundColor: WHITE,
            inactiveForegroundColor: BLACK,
          ),
        ),
        PersistentTabConfig(
          screen: Camera(),
          item: ItemConfig(
            icon: Icon(Icons.camera_alt, color: BLACK),
            title: "Camera",
            activeForegroundColor: WHITE,
            inactiveForegroundColor: BLACK,
          ),
        ),
        PersistentTabConfig(
          screen: Product(),
          item: ItemConfig(
            icon: Icon(Icons.shopping_cart, color: BLACK),
            title: "Products",
            activeForegroundColor: WHITE,
            inactiveForegroundColor: BLACK,
          ),
        ),
        PersistentTabConfig(
          screen: Profile(),
          item: ItemConfig(
            icon: Icon(Icons.person, color: BLACK),
            title: "Profile",
            activeForegroundColor: WHITE,
            inactiveForegroundColor: BLACK,
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style13BottomNavBar(
        navBarConfig: navBarConfig,

        navBarDecoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
      ),
    );
  }
}
