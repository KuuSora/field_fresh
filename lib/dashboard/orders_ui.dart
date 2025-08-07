import 'package:flutter/material.dart';
import 'to_pay_orders_page.dart';
import 'to_ship_orders_page.dart';
import 'shipping_orders_page.dart';
import 'completed_orders_page.dart';
import 'returned_orders_page.dart';

class OrdersUi extends StatelessWidget {
  const OrdersUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF175C2B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Juan Dela Cruz',
              style: TextStyle(
                color: Color(0xFF175C2B),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              'Seller',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none, color: Color(0xFF175C2B)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter and status tabs
            Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF175C2B),
                    elevation: 0,
                    side: const BorderSide(color: Color(0xFF175C2B)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  icon: const Icon(Icons.filter_list, size: 18),
                  label: const Text('Filter', style: TextStyle(fontSize: 13)),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                _StatusTabChip(
                  label: 'To Pay (15)',
                  color: const Color(0xFFFFF7E0),
                  textColor: const Color(0xFFF7B801),
                  selected: true,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ToPayOrdersPage())),
                ),
                const SizedBox(width: 4),
                _StatusTabChip(
                  label: 'To Ship (23)',
                  color: const Color(0xFFEAF6FF),
                  textColor: const Color(0xFF2196F3),
                  selected: false,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ToShipOrdersPage())),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 5 status cards
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _StatusCard(
                  label: 'To Pay',
                  count: 15,
                  icon: Icons.access_time,
                  color: const Color(0xFFFFF7E0),
                  iconColor: const Color(0xFFF7B801),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ToPayOrdersPage())),
                ),
                _StatusCard(
                  label: 'To Ship',
                  count: 23,
                  icon: Icons.local_shipping,
                  color: const Color(0xFFEAF6FF),
                  iconColor: const Color(0xFF2196F3),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ToShipOrdersPage())),
                ),
                _StatusCard(
                  label: 'Shipping',
                  count: 18,
                  icon: Icons.local_shipping_outlined,
                  color: const Color(0xFFF3E8FF),
                  iconColor: const Color(0xFF9C27B0),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShippingOrdersPage())),
                ),
                _StatusCard(
                  label: 'Completed',
                  count: 955,
                  icon: Icons.check_circle,
                  color: const Color(0xFFE8F5E9),
                  iconColor: const Color(0xFF43A047),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CompletedOrdersPage())),
                ),
                _StatusCard(
                  label: 'Returned',
                  count: 5,
                  icon: Icons.undo,
                  color: const Color(0xFFFFEBEE),
                  iconColor: const Color(0xFFD32F2F),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReturnedOrdersPage())),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Transactions header
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Transactions',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Text('All', style: TextStyle(color: Color(0xFF175C2B), fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, color: Color(0xFF175C2B), size: 18),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Transaction list
            Column(
              children: const [
                _OrderTransactionItem(
                  name: 'Maria Santos',
                  id: '#12845',
                  status: 'Completed',
                  statusColor: Color(0xFF43A047),
                  statusBg: Color(0xFFE8F5E9),
                  icon: Icons.check_circle,
                  iconColor: Color(0xFF43A047),
                  products: 'Cabbages • 4kg',
                  price: '₱3,250',
                  time: '2h ago',
                ),
                _OrderTransactionItem(
                  name: 'Berting Dako',
                  id: '#12846',
                  status: 'To Ship',
                  statusColor: Color(0xFF2196F3),
                  statusBg: Color(0xFFEAF6FF),
                  icon: Icons.local_shipping,
                  iconColor: Color(0xFF2196F3),
                  products: 'Carrots • 6kg',
                  price: '₱2,890',
                  time: '4h ago',
                ),
                _OrderTransactionItem(
                  name: 'Rosa Garcia',
                  id: '#12847',
                  status: 'Shipping',
                  statusColor: Color(0xFF9C27B0),
                  statusBg: Color(0xFFF3E8FF),
                  icon: Icons.local_shipping_outlined,
                  iconColor: Color(0xFF9C27B0),
                  products: 'Potatoes • 20kg',
                  price: '₱5,100',
                  time: '6h ago',
                ),
                _OrderTransactionItem(
                  name: 'Pedro Miguel',
                  id: '#12848',
                  status: 'To Pay',
                  statusColor: Color(0xFFF7B801),
                  statusBg: Color(0xFFFFF7E0),
                  icon: Icons.access_time,
                  iconColor: Color(0xFFF7B801),
                  products: 'Tomatoes • 10kg',
                  price: '₱4,200',
                  time: '8h ago',
                ),
                _OrderTransactionItem(
                  name: 'Ana Rodriguez',
                  id: '#12849',
                  status: 'Returned',
                  statusColor: Color(0xFFD32F2F),
                  statusBg: Color(0xFFFFEBEE),
                  icon: Icons.undo,
                  iconColor: Color(0xFFD32F2F),
                  products: 'Cabbages • 2kg',
                  price: '₱1,625',
                  time: '1d ago',
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _StatusTabChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final bool selected;
  final VoidCallback onTap;

  const _StatusTabChip({
    required this.label,
    required this.color,
    required this.textColor,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: selected ? Border.all(color: textColor, width: 2) : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _StatusCard({
    required this.label,
    required this.count,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 80,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: iconColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                Text(
                  '$count',
                  style: TextStyle(
                    color: iconColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderTransactionItem extends StatelessWidget {
  final String name;
  final String id;
  final String status;
  final Color statusColor;
  final Color statusBg;
  final IconData icon;
  final Color iconColor;
  final String products;
  final String price;
  final String time;

  const _OrderTransactionItem({
    required this.name,
    required this.id,
    required this.status,
    required this.statusColor,
    required this.statusBg,
    required this.icon,
    required this.iconColor,
    required this.products,
    required this.price,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Status icon
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: statusBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 12),
            // Main info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(width: 8),
                      _StatusChip(label: status, color: statusColor, bg: statusBg),
                    ],
                  ),
                  Text(id, style: const TextStyle(fontSize: 10, color: Colors.black54)),
                  Text(products, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                ],
              ),
            ),
            // Price and time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF175C2B))),
                Text(time, style: const TextStyle(fontSize: 10, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color bg;

  const _StatusChip({required this.label, required this.color, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}