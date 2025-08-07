import 'package:flutter/material.dart';

class ToPayOrdersPage extends StatelessWidget {
  const ToPayOrdersPage({super.key});

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
          'To Pay Orders',
          style: TextStyle(color: Color(0xFF175C2B), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7E0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('3 pending', style: TextStyle(color: Color(0xFFF7B801), fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ToPayOrderCard(
            name: 'Pedro Miguel',
            price: '₱4,200',
            time: '8h ago',
            id: '#12848',
            products: 'Tomatoes • 10kg',
          ),
          _ToPayOrderCard(
            name: 'Anna Rodriguez',
            price: '₱1,850',
            time: '1d ago',
            id: '#12851',
            products: 'Lettuce • 5kg',
          ),
          _ToPayOrderCard(
            name: 'Carlos Mendoza',
            price: '₱3,100',
            time: '2d ago',
            id: '#12852',
            products: 'Onions • 8kg',
          ),
        ],
      ),
    );
  }
}

class _ToPayOrderCard extends StatelessWidget {
  final String name, price, time, id, products;
  const _ToPayOrderCard({
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
                    color: const Color(0xFFFFF7E0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('To Pay', style: TextStyle(color: Color(0xFFF7B801), fontWeight: FontWeight.bold, fontSize: 11)),
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
                _OrderActionButton(icon: Icons.mail, label: 'Send Reminder', onTap: () {}),
                _OrderActionButton(
                  icon: Icons.cancel,
                  label: 'Cancel Order',
                  onTap: () {},
                  color: Colors.red,
                  isOutlined: true,
                ),
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
  final Color? color;
  final bool isOutlined;

  const _OrderActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Icon(icon, color: color ?? const Color(0xFF175C2B), size: 18),
        label: Text(label, style: TextStyle(color: color ?? const Color(0xFF175C2B))),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color ?? const Color(0xFF175C2B)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: isOutlined ? Colors.transparent : Colors.white,
        ),
        onPressed: onTap,
      ),
    );
  }
}