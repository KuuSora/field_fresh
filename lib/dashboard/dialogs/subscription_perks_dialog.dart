import 'package:flutter/material.dart';

class SubscriptionPerksDialog extends StatelessWidget {
  const SubscriptionPerksDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(32),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 16,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'BASIC',
                        style: TextStyle(
                          color: Color(0xFF175C2B),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(minHeight: 120),
                        decoration: BoxDecoration(
                          color: Color(0xFFEAF1F8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• Basic voucher discount', style: TextStyle(color: Colors.black87, fontSize: 15)),
                            SizedBox(height: 4),
                            Text('• Limited purchase only per produce', style: TextStyle(color: Colors.black87, fontSize: 15)),
                            SizedBox(height: 4),
                            Text('• Can use the search function', style: TextStyle(color: Colors.black87, fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'PREMIUM',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(minHeight: 120),
                        decoration: BoxDecoration(
                          color: Color(0xFFEAF1F8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• Advanced and exclusive vouchers', style: TextStyle(color: Colors.black87, fontSize: 15)),
                            SizedBox(height: 4),
                            Text('• Unlimited purchase of produce', style: TextStyle(color: Colors.black87, fontSize: 15)),
                            SizedBox(height: 4),
                            Text('• Make requests in advance to buy produce and receive notifications when requests are available', style: TextStyle(color:Colors.black87, fontSize: 15)),
                            SizedBox(height: 4),
                            Text('• Can use the search function to identify the top-rated and top-selling sellers and products', style: TextStyle(color: Colors.black87, fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  // TODO: Implement subscribe logic
                },
                child: const Text(
                  'SUBSCRIBE',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                // TODO: Apply as seller logic
              },
              child: const Text(
                'I want to apply as a seller',
                style: TextStyle(
                  color: Color(0xFF175C2B),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}