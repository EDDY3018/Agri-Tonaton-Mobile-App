import 'package:agri_tonaton/core/utils/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class ConnectionChecker extends StatefulWidget {
  final Widget child;

  const ConnectionChecker({super.key, required this.child});

  @override
  State<ConnectionChecker> createState() => _ConnectionCheckerState();
}

class _ConnectionCheckerState extends State<ConnectionChecker> {
  bool isOffline = false;
  Widget? lastOnlineScreen;

  @override
  void initState() {
    super.initState();

    // Initial check
    Connectivity().checkConnectivity().then((status) {
      if (status == ConnectivityResult.none) {
        setState(() => isOffline = true);
      } else {
        lastOnlineScreen = widget.child;
        setState(() => isOffline = false);
      }
    });

    // Real-time listener
    Connectivity().onConnectivityChanged.listen((status) {
      if (status == ConnectivityResult.none) {
        setState(() => isOffline = true);
      } else {
        setState(() => isOffline = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isOffline) {
      lastOnlineScreen = widget.child; // Update last online screen
    }

    return isOffline
        ? const NoInternetScreen()
        : lastOnlineScreen ?? widget.child;
  }
}
