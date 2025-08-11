import 'package:agri_tonaton/features%20/modules/profile/model/inbound_order.dart';
import 'package:flutter/material.dart';


class InboundOrderCard extends StatelessWidget {
  final InboundOrder order;

  const InboundOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final brandColor = const Color(0xFF0B8A2A);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFE7F2EA),
            child: Icon(Icons.inventory_2_outlined, color: brandColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.displayId,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(order.requestedOnLabel,
                    style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text("Items: ${order.itemsCount}",
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(width: 16),
                    Text("Items: ${order.amountText}",
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          Icon(order.trailingIcon, color: brandColor),
        ],
      ),
    );
  }
}
