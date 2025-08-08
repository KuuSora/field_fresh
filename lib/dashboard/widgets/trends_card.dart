import 'package:flutter/material.dart';

class TrendsCard extends StatelessWidget {
  final VoidCallback onReadMore;

  const TrendsCard({super.key, required this.onReadMore});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trends Header
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 4),
            child: Row(
              children: [
                Icon(Icons.bar_chart, color: Colors.green[800], size: 20),
                const SizedBox(width: 6),
                const Text(
                  'TRENDS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF222222),
                  ),
                ),
              ],
            ),
          ),
          // Trends Content
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(fontSize: 16, color: Colors.red)),
                    Expanded(
                      child: Text(
                        'Dragon fruit harvest starts in June and ends up in September',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(fontSize: 16, color: Colors.red)),
                    Expanded(
                      child: Text(
                        'DID YOU KNOW? Potatoes can be harvest as little as 2 months in warmer climates. However, in cooler climates, potatoes may take 4 months or more to reach maturity.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(fontSize: 16, color: Colors.green)),
                    Expanded(
                      child: Text(
                        'Garlic price increase tomorrow: from ₱100/kg to ₱125/kg',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    Expanded(
                      child: Text(
                        'Regions V and VI are currently low in sugarcane harvests',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Read More Button
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF388E3C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                  minimumSize: const Size(0, 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                onPressed: onReadMore,
                child: const Text(
                  'READ MORE',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}