import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesProfileScreen extends StatelessWidget {
  const SalesProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color green = const Color(0xFF175C2B);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: green),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.green[100],
              child: Icon(Icons.person, size: 40, color: Colors.grey[400]),
            ),
            const SizedBox(height: 6),
            Text(
              'Juan Dela Cruz',
              style: TextStyle(
                color: green,
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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Top 4 Stat Cards ---
              Row(
                children: [
                  _StatCard(
                    icon: Icons.attach_money,
                    label: 'TOTAL SALES',
                    value: '₱12,345',
                    subLabel: '5.3% vs Last Month',
                    subLabelColor: Colors.green,
                  ),
                  const SizedBox(width: 12),
                  _StatCard(
                    icon: Icons.shopping_bag,
                    label: 'ALL PRODUCTS',
                    value: '67',
                    arrow: true,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _StatCard(
                    icon: Icons.people,
                    label: 'TOTAL SHOP VISITORS',
                    value: '89',
                    subLabel: '5.3% vs Last Month',
                    subLabelColor: Colors.red,
                  ),
                  const SizedBox(width: 12),
                  _StatCard(
                    icon: Icons.receipt_long,
                    label: 'ORDERS',
                    value: '1011',
                    subLabel: '5.3% vs Last Month',
                    subLabelColor: Colors.green,
                    arrow: true,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'SALE SUMMARY',
                style: TextStyle(
                  color: green,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              // --- Monthly Sales Revenue Chart ---
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Monthly Sales Revenue',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const Text(
                      'Product Sales (₱)',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8),
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                                    if (value >= 0 && value < months.length) {
                                      return Text(months[value.toInt()], style: TextStyle(fontSize: 10, color: Colors.black54));
                                    }
                                    return const SizedBox.shrink();
                                  },
                                  interval: 1,
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            minX: 0,
                            maxX: 5,
                            minY: 0,
                            maxY: 7,
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 3),
                                  FlSpot(1, 3.5),
                                  FlSpot(2, 3.2),
                                  FlSpot(3, 4),
                                  FlSpot(4, 4.2),
                                  FlSpot(5, 5),
                                ],
                                isCurved: true,
                                color: green,
                                barWidth: 2.5,
                                dotData: FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: green.withOpacity(0.15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'TOP SELLING PRODUCTS',
                style: TextStyle(
                  color: green,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              // --- Pie Chart ---
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 110,
                      height: 110,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              color: green,
                              value: 28,
                              title: '',
                              radius: 22,
                            ),
                            PieChartSectionData(
                              color: Colors.green[700],
                              value: 22,
                              title: '',
                              radius: 20,
                            ),
                            PieChartSectionData(
                              color: Colors.green[400],
                              value: 20,
                              title: '',
                              radius: 18,
                            ),
                            PieChartSectionData(
                              color: Colors.green[200],
                              value: 18,
                              title: '',
                              radius: 16,
                            ),
                          ],
                          sectionsSpace: 2,
                          centerSpaceRadius: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _PieLegend(color: Color(0xFF175C2B), label: 'Cabbages 28%'),
                          _PieLegend(color: Color(0xFF388E3C), label: 'Carrots 22%'),
                          _PieLegend(color: Color(0xFF66BB6A), label: 'Potatoes 20%'),
                          _PieLegend(color: Color(0xFFA5D6A7), label: 'Tomatoes 18%'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // --- Orders/Customers Toggle ---
              Container(
                width: double.infinity,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1F8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Orders',
                            style: TextStyle(
                              color: green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Customers',
                          style: TextStyle(
                            color: green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'TRANSACTION LIST',
                style: TextStyle(
                  color: green,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              // --- Transaction List ---
              _TransactionTile(
                name: 'Maria Santos',
                status: 'Completed',
                statusColor: Colors.green,
                details: 'Cabbages 50kg',
                price: '₱3,250',
                time: '2h ago',
              ),
              _TransactionTile(
                name: 'Berting Dako',
                status: 'Processing',
                statusColor: Colors.blueGrey,
                details: 'Carrots 40kg',
                price: '₱2,890',
                time: '4h ago',
              ),
              _TransactionTile(
                name: 'Rosa Garcia',
                status: 'Completed',
                statusColor: Colors.green,
                details: 'Potatoes 20kg, Tomatoes 10kg',
                price: '₱5,100',
                time: '6h ago',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Stat Card Widget ---
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? subLabel;
  final Color? subLabelColor;
  final bool arrow;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    this.subLabel,
    this.subLabelColor,
    this.arrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF175C2B), size: 22),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xFF175C2B),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (subLabel != null)
                    Text(
                      subLabel!,
                      style: TextStyle(
                        color: subLabelColor ?? Colors.black54,
                        fontSize: 10,
                      ),
                    ),
                ],
              ),
            ),
            if (arrow)
              Icon(Icons.arrow_forward, color: Color(0xFF175C2B), size: 22),
          ],
        ),
      ),
    );
  }
}

// --- Pie Chart Legend Widget ---
class _PieLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _PieLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// --- Transaction Tile Widget ---
class _TransactionTile extends StatelessWidget {
  final String name;
  final String status;
  final Color statusColor;
  final String details;
  final String price;
  final String time;

  const _TransactionTile({
    required this.name,
    required this.status,
    required this.statusColor,
    required this.details,
    required this.price,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF175C2B),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8, top: 2, bottom: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      details,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Color(0xFF175C2B),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  color: Colors.black38,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}