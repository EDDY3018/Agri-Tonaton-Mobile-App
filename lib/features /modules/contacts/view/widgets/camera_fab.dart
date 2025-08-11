import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:flutter/material.dart';


class CameraFab extends StatelessWidget {
  final VoidCallback onTap;
  const CameraFab({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64, height: 64,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 12, offset: Offset(0,4))],
                border: Border.all(color: PRIMARY, width: 2),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent, shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onTap,
                child: const Center(child: Icon(Icons.camera_alt, color: PRIMARY, size: 28)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
