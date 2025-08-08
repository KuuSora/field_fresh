import 'package:flutter/material.dart';
import 'dashboard_overview_row.dart';
import 'trends_card.dart';
import 'add_new_product.dart';

class HomeTab extends StatelessWidget {
  final int productCount;
  final VoidCallback onAddProduct;
  final VoidCallback onDashboardTap;
  final VoidCallback onReadMore;

  const HomeTab({
    super.key,
    required this.productCount,
    required this.onAddProduct,
    required this.onDashboardTap,
    required this.onReadMore,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dashboard Overview Row
          DashboardOverviewRow(
            productCount: productCount,
            onAddProduct: () {
              showDialog(
                context: context,
                builder: (_) => const AddNewProductScreen(),
              );
            },
            onDashboardTap: onDashboardTap,
          ),
          // Trends Card
          TrendsCard(
            onReadMore: onReadMore,
          ),
          // Find Buyers Map Card
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 4),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.green[800], size: 20),
                      const SizedBox(width: 6),
                      const Text(
                        'FIND BUYERS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ],
                  ),
                ),
                // Map Image
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/rc_map.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 120,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}