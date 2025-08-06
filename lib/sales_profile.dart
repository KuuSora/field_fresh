import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesProfile extends StatefulWidget {
  @override
  _SalesProfileState createState() => _SalesProfileState();
}

class _SalesProfileState extends State<SalesProfile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/profile_image.png'),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Juan Dela Cruz'),
                Text('Seller', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const NotificationDialog(),
              );
            },
          ),
          IconButton(icon: Icon(Icons.message), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'TOTAL SALES',
                      '₱12,345',
                      '5.3% vs Last Month',
                      Icons.trending_up,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'ALL PRODUCTS',
                      '67',
                      '',
                      null,
                      showArrow: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'TOTAL SHOP VISITORS',
                      '89',
                      '5.3% vs Last Month',
                      Icons.trending_up,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'ORDERS',
                      '1011',
                      '5.3% vs Last Month',
                      Icons.trending_up,
                      showArrow: true,
                    ),
                  ),
                ],
              ),
            ),
            _buildSalesChart(),
            _buildPieChart(),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              margin: EdgeInsets.all(16),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Orders'),
                  Tab(text: 'Customers'),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOrdersList(),
                  _buildCustomersList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtext, IconData? trendIcon, {bool showArrow = false}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
              if (showArrow) Icon(Icons.arrow_forward, color: Colors.green),
            ],
          ),
          SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          if (subtext.isNotEmpty)
            Row(
              children: [
                if (trendIcon != null)
                  Icon(trendIcon, size: 16, color: Colors.green),
                Text(subtext, style: TextStyle(fontSize: 12, color: Colors.green)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSalesChart() {
    return Container(
      padding: EdgeInsets.all(16),
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                  return Text(months[value.toInt() % months.length]);
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 3),
                FlSpot(1, 4),
                FlSpot(2, 3.5),
                FlSpot(3, 5),
                FlSpot(4, 4),
                FlSpot(5, 6),
              ],
              isCurved: true,
              color: Colors.green,
              barWidth: 2,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(value: 28, color: Colors.green[900], title: '28%'),
                  PieChartSectionData(value: 22, color: Colors.green[700], title: '22%'),
                  PieChartSectionData(value: 20, color: Colors.green[500], title: '20%'),
                  PieChartSectionData(value: 18, color: Colors.green[300], title: '18%'),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLegendItem('Cabbages 28%', Colors.green[900]!),
              _buildLegendItem('Carrots 22%', Colors.green[700]!),
              _buildLegendItem('Potatoes 20%', Colors.green[500]!),
              _buildLegendItem('Tomatoes 18%', Colors.green[300]!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          color: color,
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  Widget _buildOrdersList() {
    return ListView(
      children: [
        _buildOrderItem('Maria Santos', '#12347', 'Completed', 'Cabbages 50kg', '₱3,250', '2h ago'),
        _buildOrderItem('Berting Dako', '#12346', 'Processing', 'Carrots 40kg', '₱2,890', '4h ago'),
        _buildOrderItem('Rosa Garcia', '#12345', 'Completed', 'Potatoes 20kg\nTomatoes\n10kg', '₱5,100', '6h ago'),
      ],
    );
  }

  Widget _buildOrderItem(String name, String orderNo, String status, String items, String amount, String time) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Text(orderNo, style: TextStyle(color: Colors.grey)),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: status == 'Completed' ? Colors.green : Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(items),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(time, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomersList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MONTHLY SHOP VISITORS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                              if (value >= 0 && value < months.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(months[value.toInt()], style: TextStyle(fontSize: 10, color: Colors.black54)),
                                );
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
                            FlSpot(5, 3.8),
                          ],
                          isCurved: true,
                          color: Colors.green[900],
                          barWidth: 2,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.green[900]!.withOpacity(0.12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green[900],
                      child: Icon(Icons.person, color: Colors.white, size: 20),
                      radius: 16,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'NEW CUSTOMERS',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        Text(
                          '12',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.arrow_upward, color: Colors.green, size: 16),
                            Text(
                              '5.3%',
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                        const Text(
                          'vs Last Month',
                          style: TextStyle(fontSize: 11, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 340,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Notifications',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(),
            _notifSection('Today', [
              _notifItem('Order ID #12345678 has been paid by Marie Juana', '1 hour ago', true),
              _notifItem('Your request offer has been accepted by Elaine Tuon', '6 hours ago', true),
            ]),
            _notifSection('Yesterday', [
              _notifItem('Your request offer has been accepted by Jack Stone', '1 day ago', true),
              _notifItem('Order ID #12345678 has been paid by Tonton B. Nayaan', '1 day ago', true),
            ]),
            _notifSection('Earlier', [
              _notifItem('Your new seller perks have expired. Your commission rate has increased to 3.5%.', '5 days ago', false),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _notifSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ),
        ...items,
      ],
    );
  }

  Widget _notifItem(String text, String time, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.grey[100] : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            isActive ? Icons.circle : Icons.info_outline,
            color: isActive ? Colors.green : Colors.grey,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}