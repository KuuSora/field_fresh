import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

// Appwrite setup (reuse your existing client/databases)
Client client = Client()
  .setEndpoint('https://nyc.cloud.appwrite.io/v1')
  .setProject('6892ed1d003d8b9dfc27');
Databases databases = Databases(client);

const String databaseId = '6892ed30001d2e66eb97';
const String collectionId = '6892edcd0036f3eae39d';

class SalesProfileScreen extends StatefulWidget {
  final String userPhone;
  const SalesProfileScreen({super.key, required this.userPhone});

  @override
  State<SalesProfileScreen> createState() => _SalesProfileScreenState();
}

class _SalesProfileScreenState extends State<SalesProfileScreen> {
  String userName = 'Loading...';
  int selectedTab = 0; // 0 = Orders, 1 = Customers

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    try {
      final models.DocumentList result = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
        queries: [
          Query.equal('phone', widget.userPhone),
        ],
      );
      if (result.documents.isNotEmpty) {
        setState(() {
          userName = result.documents.first.data['name'] ?? 'Guest';
        });
      }
    } catch (e) {
      setState(() {
        userName = 'Guest';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Pinned header
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              expandedHeight: 110,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hamburger menu
                      IconButton(
                        icon: const Icon(Icons.menu, color: Color(0xFF175C2B)),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                      const SizedBox(width: 8),
                      // Profile image and name
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: const Color(0xFFD9D9D9),
                        child: const Icon(Icons.person, size: 32, color: Color(0xFF175C2B)),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                              color: Color(0xFF175C2B),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            'Seller',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(Icons.notifications_none, color: Color(0xFF175C2B)),
                    ],
                  ),
                ),
              ),
              toolbarHeight: 80,
            ),
            // Main content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats grid (2x3)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _StatCard(
                          icon: Icons.monetization_on_outlined,
                          label: 'TOTAL SALES',
                          value: '₱12,345',
                          sub: '↑ 5.3% vs Last Month',
                          subColor: Color(0xFF175C2B),
                        ),
                        _StatCard(
                          icon: Icons.inventory_2_outlined,
                          label: 'ALL PRODUCTS',
                          value: '67',
                        ),
                        _StatCard(
                          icon: Icons.people_outline,
                          label: 'TOTAL SHOP VISITORS',
                          value: '89',
                          sub: '↓ 5.3% vs Last Month',
                          subColor: Colors.red,
                        ),
                        _StatCard(
                          icon: Icons.shopping_cart_outlined,
                          label: 'ORDERS',
                          value: '1011',
                          sub: '↑ 5.3% vs Last Month',
                          subColor: Color(0xFF175C2B),
                        ),
                        _StatCard(
                          icon: Icons.mail_outline,
                          label: 'MESSAGES',
                          value: '15 NEW',
                        ),
                        _StatCard(
                          icon: Icons.attach_money,
                          label: 'COMMISSION',
                          value: '₱30',
                          sub: '2% per transaction',
                          subColor: Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Sale Summary
                    const Text(
                      'SALE SUMMARY',
                      style: TextStyle(
                        color: Color(0xFF175C2B),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Monthly Sales Revenue',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Product Sales (₱)',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF1F8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text('Chart Placeholder', style: TextStyle(color: Colors.black38)),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Jan', style: TextStyle(fontSize: 10)),
                              Text('Feb', style: TextStyle(fontSize: 10)),
                              Text('Mar', style: TextStyle(fontSize: 10)),
                              Text('Apr', style: TextStyle(fontSize: 10)),
                              Text('May', style: TextStyle(fontSize: 10)),
                              Text('Jun', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Monthly Shop Visitors
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'MONTHLY SHOP VISITORS',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAF1F8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text('Chart Placeholder', style: TextStyle(color: Colors.black38)),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Jan', style: TextStyle(fontSize: 10)),
                              Text('Feb', style: TextStyle(fontSize: 10)),
                              Text('Mar', style: TextStyle(fontSize: 10)),
                              Text('Apr', style: TextStyle(fontSize: 10)),
                              Text('May', style: TextStyle(fontSize: 10)),
                              Text('Jun', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // New Customers
                    _StatCard(
                      icon: Icons.people_outline,
                      label: 'NEW CUSTOMERS',
                      value: '12',
                      sub: '↑ 5.3% vs Last Month',
                      subColor: Color(0xFF175C2B),
                      isFullWidth: true,
                    ),
                    const SizedBox(height: 12),
                    // Top Selling Products
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TOP SELLING PRODUCTS',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFEAF1F8),
                              ),
                              child: const Center(
                                child: Text('Pie Chart', style: TextStyle(color: Colors.black38, fontSize: 12)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 16,
                            children: const [
                              _LegendDot(label: 'Cabbages 28%', color: Color(0xFF175C2B)),
                              _LegendDot(label: 'Potatoes 20%', color: Color(0xFF7BC67E)),
                              _LegendDot(label: 'Carrots 22%', color: Color(0xFFB5E48C)),
                              _LegendDot(label: 'Tomatoes 18%', color: Color(0xFF52B788)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Orders/Customers Tabs
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF1F8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => selectedTab = 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedTab == 0 ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Center(
                                    child: Text(
                                      'Orders',
                                      style: TextStyle(
                                        color: selectedTab == 0 ? Color(0xFF175C2B) : Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => selectedTab = 1),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Center(
                                  child: Text(
                                    'Customers',
                                    style: TextStyle(
                                      color: selectedTab == 1 ? Color(0xFF175C2B) : Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Transaction List or Customers List
                    if (selectedTab == 0)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    'TRANSACTIONS',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Icon(Icons.arrow_forward, color: Color(0xFF175C2B)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _TransactionItem(
                              name: 'Maria Santos',
                              id: '#12847',
                              status: 'Completed',
                              statusColor: Color(0xFF175C2B),
                              products: 'Cabbages 50kg',
                              price: '₱3,250',
                              time: '2h ago',
                            ),
                            _TransactionItem(
                              name: 'Berting Dako',
                              id: '#12846',
                              status: 'Processing',
                              statusColor: Color(0xFFB5E48C),
                              products: 'Carrots 40kg',
                              price: '₱2,890',
                              time: '4h ago',
                            ),
                            _TransactionItem(
                              name: 'Rosa Garcia',
                              id: '#12845',
                              status: 'Completed',
                              statusColor: Color(0xFF175C2B),
                              products: 'Potatoes 20kg, Tomatoes 10kg',
                              price: '₱5,100',
                              time: '6h ago',
                            ),
                          ],
                        ),
                      ),
                    if (selectedTab == 1)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    'CUSTOMERS',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Icon(Icons.arrow_forward, color: Color(0xFF175C2B)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Example customer list
                            _CustomerItem(
                              name: 'Maria Santos',
                              orders: 12,
                              spent: '₱15,000',
                            ),
                            _CustomerItem(
                              name: 'Berting Dako',
                              orders: 8,
                              spent: '₱8,500',
                            ),
                            _CustomerItem(
                              name: 'Rosa Garcia',
                              orders: 5,
                              spent: '₱5,100',
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Helper Widgets ---

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String sub;
  final Color? subColor;
  final bool isFullWidth;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    this.sub = '',
    this.subColor,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      width: isFullWidth ? double.infinity : (MediaQuery.of(context).size.width / 2) - 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF175C2B), size: 20),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF175C2B),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          if (sub.isNotEmpty)
            Row(
              children: [
                Text(
                  sub,
                  style: TextStyle(
                    color: subColor ?? Colors.black54,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
    return isFullWidth ? card : SizedBox(width: (MediaQuery.of(context).size.width / 2) - 20, child: card);
  }
}

class _LegendDot extends StatelessWidget {
  final String label;
  final Color color;

  const _LegendDot({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.black87),
        ),
      ],
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final String name;
  final String id;
  final String status;
  final Color statusColor;
  final String products;
  final String price;
  final String time;

  const _TransactionItem({
    required this.name,
    required this.id,
    required this.status,
    required this.statusColor,
    required this.products,
    required this.price,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(width: 8),
                    Text(id, style: const TextStyle(fontSize: 10, color: Colors.black54)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(products, style: const TextStyle(fontSize: 11, color: Colors.black54)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(time, style: const TextStyle(fontSize: 10, color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }
}

class _CustomerItem extends StatelessWidget {
  final String name;
  final int orders;
  final String spent;

  const _CustomerItem({
    required this.name,
    required this.orders,
    required this.spent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
          Text('$orders orders', style: const TextStyle(fontSize: 11, color: Colors.black54)),
          const SizedBox(width: 8),
          Text(spent, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}