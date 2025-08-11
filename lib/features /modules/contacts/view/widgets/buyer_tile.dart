import 'package:agri_tonaton/features%20/modules/contacts/model/buyer_model.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';

class BuyerTile extends StatelessWidget {
  final Buyer buyer;
  final ValueChanged<bool> onChanged;
  final VoidCallback onCall;
  final bool forceChecked; // for Buyers List page

  const BuyerTile({
    super.key,
    required this.buyer,
    required this.onChanged,
    required this.onCall,
    this.forceChecked = false,
  });

  @override
  Widget build(BuildContext context) {
    final isChecked = forceChecked ? true : buyer.selected;

    Widget checkbox(bool checked) => Transform.scale(
      scale: 1.1,
      child: Checkbox(
        value: checked,
        onChanged: (v) => onChanged(v ?? false),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: Color(0xFFBFBFBF), width: 1.6),
        activeColor: PRIMARY,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );

    final squareUnchecked = Container(
      width: 22, height: 22,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFBFBFBF), width: 1.6),
        borderRadius: BorderRadius.circular(4),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Row(
        children: [
          const SizedBox(width: 6),
          isChecked ? checkbox(true) : squareUnchecked,
          const SizedBox(width: 14),
          const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFE6E6E6),
            child: Icon(Icons.person, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(buyer.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.black,
                      )),
                  const SizedBox(height: 2),
                  Text(buyer.phone,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF7D7D7D),
                        height: 1.2,
                      )),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.phone, size: 22, color: PRIMARY),
            onPressed: onCall,
            splashRadius: 22,
          ),
          const SizedBox(width: 2),
        ],
      ),
    );
  }
}
