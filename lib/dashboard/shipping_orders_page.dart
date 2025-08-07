import 'package:flutter/material.dart';

class ShippingOrdersPage extends StatelessWidget {
  const ShippingOrdersPage({super.key});

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
        title: const Text(
          'In Transit',
          style: TextStyle(color: Color(0xFF175C2B), fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFFF3E8FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('3 shipping', style: TextStyle(color: Color(0xFF9C27B0), fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ShippingOrderCard(
            name: 'Rosa Garcia',
            price: '₱5,100',
            time: '6h ago',
            id: '#12847',
            products: 'Potatoes • 20kg',
          ),
          _ShippingOrderCard(
            name: 'Miguel Santos',
            price: '₱3,450',
            time: '1d ago',
            id: '#12843',
            products: 'Sweet Potatoes • 8kg',
          ),
          _ShippingOrderCard(
            name: 'Elena Reyes',
            price: '₱2,880',
            time: '2d ago',
            id: '#12841',
            products: 'Eggplant • 6kg',
          ),
        ],
      ),
    );
  }
}

class _ShippingOrderCard extends StatelessWidget {
  final String name, price, time, id, products;
  const _ShippingOrderCard({
    required this.name,
    required this.price,
    required this.time,
    required this.id,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF175C2B))),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4, right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFFF3E8FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Shipping', style: TextStyle(color: Color(0xFF9C27B0), fontWeight: FontWeight.bold, fontSize: 11)),
                ),
                Text(time, style: const TextStyle(fontSize: 11, color: Colors.black54)),
              ],
            ),
            Text(id, style: const TextStyle(fontSize: 11, color: Colors.black54)),
            Text(products, style: const TextStyle(fontSize: 12, color: Colors.black87)),
            const SizedBox(height: 10),
            Column(
              children: [
                _OrderActionButton(icon: Icons.remove_red_eye, label: 'View Details', onTap: () {}),
                _OrderActionButton(icon: Icons.local_shipping, label: 'Track Package', onTap: () {}),
                _OrderActionButton(icon: Icons.phone, label: 'Contact Customer', onTap: () {}),
                _OrderActionButton(icon: Icons.update, label: 'Update Status', onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _OrderActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Icon(icon, color: const Color(0xFF175C2B), size: 18),
        label: Text(label, style: const TextStyle(color: Color(0xFF175C2B))),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF175C2B)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: onTap,
      ),
    );
  }
}