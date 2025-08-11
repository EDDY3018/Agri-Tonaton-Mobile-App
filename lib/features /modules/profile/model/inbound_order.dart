import 'package:flutter/material.dart';

enum InboundOrderStatus { newOrder, pending, finished }

class InboundOrder {
  final String id;
  final DateTime requestedOn;
  final int itemsCount;
  final String amountText; // "Ghc160"
  final InboundOrderStatus status;

  const InboundOrder({
    required this.id,
    required this.requestedOn,
    required this.itemsCount,
    required this.amountText,
    required this.status,
  });
}

/// Helpers (formatting once, reuse everywhere)
extension InboundOrderX on InboundOrder {
  String get displayId => "Order #$id";

  String get requestedOnLabel {
    // "Requested on October 19 2021"
    final months = [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December'
    ];
    final m = months[requestedOn.month - 1];
    return "Requested on $m ${requestedOn.day} ${requestedOn.year}";
  }

  IconData get trailingIcon =>
      status == InboundOrderStatus.pending ? Icons.arrow_drop_down_circle_outlined : Icons.arrow_drop_down;
}
