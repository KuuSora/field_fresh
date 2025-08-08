import 'package:flutter/material.dart';

enum ShopTab { home, onSale, requests }

class ShopTabBar extends StatelessWidget {
  final ShopTab selectedTab;
  final ValueChanged<ShopTab> onTabSelected;
  final VoidCallback onFilter;
  final bool isPremium;
  final VoidCallback onPremiumTap;
  final bool showHome; // <-- add this

  const ShopTabBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    required this.onFilter,
    required this.isPremium,
    required this.onPremiumTap,
    this.showHome = true, // <-- default true
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          if (showHome)
            GestureDetector(
              onTap: () => onTabSelected(ShopTab.home),
              child: Text(
                'HOME',
                style: TextStyle(
                  color: selectedTab == ShopTab.home ? const Color(0xFF175C2B) : Colors.black38,
                  fontWeight: selectedTab == ShopTab.home ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          if (showHome) const SizedBox(width: 16),
          GestureDetector(
            onTap: () => onTabSelected(ShopTab.onSale),
            child: Text(
              'ON SALE',
              style: TextStyle(
                color: selectedTab == ShopTab.onSale ? const Color(0xFF175C2B) : Colors.black38,
                fontWeight: selectedTab == ShopTab.onSale ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              if (isPremium) {
                onTabSelected(ShopTab.requests);
              } else {
                onPremiumTap();
              }
            },
            child: Text(
              'REQUESTS',
              style: TextStyle(
                color: selectedTab == ShopTab.requests ? const Color(0xFF175C2B) : Colors.black38,
                fontWeight: selectedTab == ShopTab.requests ? FontWeight.bold : FontWeight.normal,
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
    );
  }
}
