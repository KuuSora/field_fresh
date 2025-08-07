import 'package:flutter/material.dart';

// This widget is only for UI. All navigation and dialogs should be handled in the parent widget.
class ShopTopBar extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;
  final VoidCallback onFilter;
  final VoidCallback onCart;
  final VoidCallback onDrawer;

  const ShopTopBar({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
    required this.onFilter,
    required this.onCart,
    required this.onDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- Top Row: Drawer, Search, Cart ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: onDrawer,
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
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            hintStyle: const TextStyle(color: Colors.black38, fontSize: 16),
                          ),
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
                onPressed: onCart,
              ),
            ],
          ),
        ),
        // --- Tabs and Filter Row ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => onTabChanged(0),
                child: Text(
                  'ON SALE',
                  style: TextStyle(
                    color: selectedTab == 0 ? const Color(0xFF175C2B) : Colors.black38,
                    fontWeight: selectedTab == 0 ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => onTabChanged(1),
                child: Text(
                  'REQUESTS',
                  style: TextStyle(
                    color: selectedTab == 1 ? const Color(0xFF175C2B) : Colors.black38,
                    fontWeight: selectedTab == 1 ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.filter_alt_outlined, color: Color(0xFF175C2B), size: 28),
                onPressed: onFilter,
              ),
            ],
          ),
        ),
      ],
    );
  }
}