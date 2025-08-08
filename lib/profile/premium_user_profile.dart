import 'package:flutter/material.dart';

class PremiumUserProfileScreen extends StatelessWidget {
  final String userName;
  final String userPhone;

  const PremiumUserProfileScreen({
    super.key,
    required this.userName,
    required this.userPhone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Color(0xFF175C2B)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline, color: Color(0xFF175C2B)),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF175C2B)),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              // Profile avatar and name
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.orange, // Same as "Premium User" text
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 44,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 60, color: Colors.grey[400]),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF175C2B),
                ),
              ),
              const Text(
                'Premium User',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 16),
              // Transactions Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.receipt_long, color: Color(0xFF175C2B), size: 20),
                          SizedBox(width: 6),
                          Text(
                            'Transactions',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF175C2B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          _TransactionStatusBox(label: 'To Pay', value: '1'),
                          _TransactionStatusBox(label: 'To Ship', value: '23'),
                          _TransactionStatusBox(label: 'To Receive', value: '45'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Buy Again & Vouchers
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.qr_code, size: 18, color: Color(0xFF175C2B)),
                                SizedBox(width: 4),
                                Text('VOUCHERS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text('15', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Color(0xFF175C2B))),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.arrow_forward, color: Color(0xFF175C2B)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF175C2B),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('BUY AGAIN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _BuyAgainItem(),
                                const SizedBox(width: 8),
                                _BuyAgainItem(),
                                const SizedBox(width: 8),
                                _BuyAgainItem(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Feature Cards Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Exclusive Products (big square)
                    Flexible(
                      flex: 2,
                      child: AspectRatio(
                        aspectRatio: 1, // Square
                        child: _FeatureCard(
                          label: 'Exclusive Products',
                          icon: Icons.search,
                          borderColor: Colors.orange,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Top Grossing and Top Selling stacked
                    Flexible(
                      flex: 3,
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 2.8, // Rectangle, adjust as needed
                            child: _FeatureCard(
                              label: 'Top Grossing Products',
                              icon: Icons.arrow_forward,
                              borderColor: Colors.orange,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AspectRatio(
                            aspectRatio: 2.8, // Rectangle, adjust as needed
                            child: _FeatureCard(
                              label: 'Top Selling Shops',
                              icon: Icons.arrow_forward,
                              borderColor: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Bottom menu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: const [
                      _BottomMenuItem(
                        label: 'RECENTLY VIEWED',
                        icon: Icons.remove_red_eye_outlined,
                      ),
                      _BottomMenuItem(
                        label: 'EDIT PROFILE INFORMATION',
                        icon: Icons.edit_outlined,
                      ),
                      _BottomMenuItem(
                        label: 'HELP CENTER',
                        icon: Icons.help_outline,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionStatusBox extends StatelessWidget {
  final String label;
  final String value;
  const _TransactionStatusBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF175C2B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.white)),
        ],
      ),
    );
  }
}

class _BuyAgainItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 22,
      child: Image.asset('assets/fieldfresh_logo.png', width: 28, height: 28), // Replace with your product image
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color borderColor;
  const _FeatureCard({required this.label, required this.icon, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF175C2B), size: 18),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomMenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  const _BottomMenuItem({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF175C2B)),
      title: Text(label, style: const TextStyle(fontSize: 14, color: Colors.black87)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
      onTap: () {},
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
    );
  }
}