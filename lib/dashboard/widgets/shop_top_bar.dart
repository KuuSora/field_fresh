import 'package:flutter/material.dart';

class ShopTopBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String userName;
  final String userPhone;
  final VoidCallback onCartPressed;
  final ValueChanged<String> onSearch;

  const ShopTopBar({
    super.key,
    required this.scaffoldKey,
    required this.userName,
    required this.userPhone,
    required this.onCartPressed,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF1F8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  const Icon(Icons.search, color: Colors.black, size: 24),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black38, fontSize: 16),
                      ),
                      onChanged: onSearch,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart, color: Colors.black),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: onCartPressed,
          ),
        ],
      ),
    );
  }
}
