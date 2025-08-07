import 'package:flutter/material.dart';

class ReturnedOrdersPage extends StatelessWidget {
  const ReturnedOrdersPage({super.key});

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
          'Returned Items',
          style: TextStyle(color: Color(0xFF175C2B), fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('3 returns', style: TextStyle(color: Color(0xFFD32F2F), fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ReturnedOrderCard(
            name: 'Ana Morales',
            price: '₱2,400',
            time: '3h ago',
            id: '#12836',
            products: 'Damaged Tomatoes • 5kg',
          ),
          _ReturnedOrderCard(
            name: 'Luis Fernando',
            price: '₱1,680',
            time: '1d ago',
            id: '#12834',
            products: 'Wrong Order • 3kg',
          ),
          _ReturnedOrderCard(
            name: 'Carmen Valdez',
            price: '₱3,200',
            time: '2d ago',
            id: '#12831',
            products: 'Quality Issues • 8kg',
          ),
        ],
      ),
    );
  }
}

class _ReturnedOrderCard extends StatelessWidget {
  final String name, price, time, id, products;
  const _ReturnedOrderCard({
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
                    color: Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Returned', style: TextStyle(color: Color(0xFFD32F2F), fontWeight: FontWeight.bold, fontSize: 11)),
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
                _OrderActionButton(icon: Icons.assignment_return, label: 'Return Report', onTap: () {}),
                _OrderActionButton(
                  icon: Icons.attach_money,
                  label: 'Process Refund',
                  onTap: () {},
                  color: Color(0xFF175C2B),
                  textColor: Color(0xFF175C2B),
                ),
                _OrderActionButton(icon: Icons.inventory, label: 'Restock Items', onTap: () {}),
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
  final Color? textColor;

  const _OrderActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isGreen = label == 'Process Refund';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Icon(icon, color: isGreen ? Colors.green : (color ?? const Color(0xFF175C2B)), size: 18),
        label: Text(
          label,
          style: TextStyle(
            color: isGreen ? Colors.green : (textColor ?? const Color(0xFF175C2B)),
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: isGreen ? Colors.green : (color ?? const Color(0xFF175C2B))),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: onTap,
      ),
    );
  }
}