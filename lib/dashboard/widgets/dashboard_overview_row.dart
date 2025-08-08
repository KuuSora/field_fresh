import 'package:flutter/material.dart';

class DashboardOverviewRow extends StatelessWidget {
  final int productCount;
  final VoidCallback onAddProduct;
  final VoidCallback onDashboardTap;

  const DashboardOverviewRow({
    super.key,
    required this.productCount,
    required this.onAddProduct,
    required this.onDashboardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Dashboard Card (square, expanded)
        Expanded(
          flex: 1,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onDashboardTap,
            child: Container(
              height: 110,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.dashboard, size: 34, color: Colors.green[800]),
                  const SizedBox(height: 4),
                  const Text(
                    'DASHBOARD',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color(0xFF222222),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Your Products Card (rectangle)
        Expanded(
          flex: 2,
          child: Container(
            height: 110,
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.inventory_2, size: 16, color: Colors.green[800]),
                    const SizedBox(width: 4),
                    const Text(
                      'YOUR PRODUCTS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  productCount.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF388E3C),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF388E3C),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      minimumSize: const Size(0, 28),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                      textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    onPressed: onAddProduct,
                    child: const Text('+ ADD NEW PRODUCT'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}