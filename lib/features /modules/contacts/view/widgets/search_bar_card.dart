import 'package:flutter/material.dart';


class SearchBarCard extends StatelessWidget {
  final String dropdown;
  final void Function(String) onDropdownChanged;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onMore;

  const SearchBarCard({
    super.key,
    required this.dropdown,
    required this.onDropdownChanged,
    required this.controller,
    required this.onChanged,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Color(0xFFEDEDED)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdown,
                      items: const [
                        DropdownMenuItem(value: 'Contacts', child: Text('Contacts')),
                        DropdownMenuItem(value: 'Buyers', child: Text('Buyers')),
                      ],
                      onChanged: (v) => onDropdownChanged(v ?? dropdown),
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: onChanged,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Search',
                      ),
                    ),
                  ),
                  const Icon(Icons.search, size: 20, color: Colors.black54),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Material(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFFEDEDED)),
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onMore,
              child: const SizedBox(
                width: 48, height: 48, child: Icon(Icons.more_vert, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
