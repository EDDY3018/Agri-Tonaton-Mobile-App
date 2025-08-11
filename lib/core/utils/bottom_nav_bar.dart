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
            icon: Icon(Icons.home_filled, color: PRIMARY),
            title: "",
            activeForegroundColor: WHITE,
            inactiveForegroundColor: PRIMARY,
          ),
        ),
        PersistentTabConfig(
          screen: Contacts(),
          item: ItemConfig(
            icon: Icon(Icons.menu_outlined, color: PRIMARY),
            title: "",
            activeForegroundColor: WHITE,
            inactiveForegroundColor: PRIMARY,
          ),
        ),
        PersistentTabConfig(
          screen: Camera(),
          item: ItemConfig(
            icon: Icon(Icons.camera_alt, color: PRIMARY),
            title: "",
            activeForegroundColor: WHITE,
            inactiveForegroundColor: PRIMARY,
          ),
        ),
        PersistentTabConfig(
          screen: Product(),
          item: ItemConfig(
            icon: Icon(Icons.shopping_cart, color: PRIMARY),
            title: "",
            activeForegroundColor: WHITE,
            inactiveForegroundColor: PRIMARY,
          ),
        ),
        PersistentTabConfig(
          screen: Profile(),
          item: ItemConfig(
            icon: Icon(Icons.person, color: PRIMARY),
            title: "",
            activeForegroundColor: WHITE,
            inactiveForegroundColor: PRIMARY,
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style13BottomNavBar(
        navBarConfig: navBarConfig,

        navBarDecoration: NavBarDecoration(
          border: Border.all(color: PRIMARY),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
      ),
    );
  }
}
