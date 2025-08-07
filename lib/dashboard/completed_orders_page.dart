import 'package:flutter/material.dart';

class CompletedOrdersPage extends StatelessWidget {
  const CompletedOrdersPage({super.key});

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
          'Completed Orders',
          style: TextStyle(color: Color(0xFF175C2B), fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('3 recent', style: TextStyle(color: Color(0xFF43A047), fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _CompletedOrderCard(
            name: 'Maria Santos',
            price: '₱3,250',
            time: '2h ago',
            id: '#12845',
            products: 'Cabbages • 4kg',
          ),
          _CompletedOrderCard(
            name: 'Rafael Torres',
            price: '₱2,150',
            time: '5h ago',
            id: '#12844',
            products: 'Radishes • 5kg',
          ),
          _CompletedOrderCard(
            name: 'Isabella Cruz',
            price: '₱4,800',
            time: '1d ago',
            id: '#12842',
            products: 'Green Beans • 10kg',
          ),
        ],
      ),
    );
  }
}

class _CompletedOrderCard extends StatelessWidget {
  final String name, price, time, id, products;
  const _CompletedOrderCard({
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
                    color: Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Completed', style: TextStyle(color: Color(0xFF43A047), fontWeight: FontWeight.bold, fontSize: 11)),
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
                _OrderActionButton(icon: Icons.download, label: 'Download Invoice', onTap: () {}),
                _OrderActionButton(icon: Icons.star_border, label: 'Request Review', onTap: () {}),
                _OrderActionButton(icon: Icons.refresh, label: 'Reorder', onTap: () {}),
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