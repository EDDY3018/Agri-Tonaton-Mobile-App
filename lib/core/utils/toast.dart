import 'package:flutter/material.dart';

class Toast {
  static void show(
    BuildContext context, {
    required String text,
    required Color color,
    Duration duration = const Duration(seconds: 2),
  }) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            bottom: 50,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(duration).then((_) {
      overlayEntry.remove();
    });
  }
}
