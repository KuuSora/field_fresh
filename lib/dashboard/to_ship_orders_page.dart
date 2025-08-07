import 'package:flutter/material.dart';

class ToShipOrdersPage extends StatelessWidget {
  const ToShipOrdersPage({super.key});

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
          'Ready to Ship',
          style: TextStyle(color: Color(0xFF175C2B), fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF6FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('3 ready', style: TextStyle(color: Color(0xFF2196F3), fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ToShipOrderCard(
            name: 'Berting Dako',
            price: '₱2,890',
            time: '4h ago',
            id: '#12846',
            products: 'Carrots • 6kg',
          ),
          _ToShipOrderCard(
            name: 'Maria Gonzales',
            price: '₱1,540',
            time: '6h ago',
            id: '#12847',
            products: 'Spinach • 3kg',
          ),
          _ToShipOrderCard(
            name: 'Roberto Cruz',
            price: '₱4,120',
            time: '12h ago',
            id: '#12850',
            products: 'Mixed Vegetables • 12kg',
          ),
        ],
      ),
    );
  }
}

class _ToShipOrderCard extends StatelessWidget {
  final String name, price, time, id, products;
  const _ToShipOrderCard({
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
                    color: const Color(0xFFEAF6FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('To Ship', style: TextStyle(color: Color(0xFF2196F3), fontWeight: FontWeight.bold, fontSize: 11)),
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
                _OrderActionButton(icon: Icons.print, label: 'Print Label', onTap: () {}),
                _OrderActionButton(
                  icon: Icons.local_shipping,
                  label: 'Mark as Shipped',
                  onTap: () {},
                  color: Colors.white,
                  bgColor: Color(0xFF175CFF),
                  textColor: Colors.white,
                  isFilled: true,
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
  final Color? bgColor;
  final Color? textColor;
  final bool isFilled;

  const _OrderActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.bgColor,
    this.textColor,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      child: isFilled
          ? ElevatedButton.icon(
              icon: Icon(icon, color: color ?? Colors.white, size: 18),
              label: Text(label, style: TextStyle(color: textColor ?? Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: bgColor ?? const Color(0xFF175C2B),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: onTap,
            )
          : OutlinedButton.icon(
              icon: Icon(icon, color: color ?? const Color(0xFF175C2B), size: 18),
              label: Text(label, style: TextStyle(color: color ?? const Color(0xFF175C2B))),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: color ?? const Color(0xFF175C2B)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: onTap,
            ),
    );
  }
}