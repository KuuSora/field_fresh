import 'package:flutter/material.dart';


import '../../profile/profile_drawer.dart' show UserType;

class RequestsList extends StatelessWidget {
  final List<Map<String, dynamic>> requests;
  final List<Map<String, dynamic>> comments;
  final UserType userType;
  final void Function(Map<String, dynamic> req) onRequestTap;
  final VoidCallback onAddRequest;

  const RequestsList({
    super.key,
    required this.requests,
    required this.comments,
    required this.userType,
    required this.onRequestTap,
    required this.onAddRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final req = requests[index];
              final DateTime posted = req['posted'] ?? DateTime.now();
              final Duration diff = DateTime.now().difference(posted);
              String timeAgo;
              if (diff.inMinutes < 1) {
                timeAgo = 'Just now';
              } else if (diff.inMinutes < 60) {
                timeAgo = '${diff.inMinutes} min ago';
              } else if (diff.inHours < 24) {
                timeAgo = '${diff.inHours} hr ago';
              } else {
                timeAgo = '${diff.inDays} days ago';
              }
              final bool isNew = diff.inMinutes < 5;

              return GestureDetector(
                onTap: () => onRequestTap(req),
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF1F8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (isNew)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF175C2B),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'New',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                            const Spacer(),
                            Text(
                              timeAgo,
                              style: const TextStyle(color: Colors.black54, fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (req['image'] != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              req['image'],
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        if (req['image'] != null) const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final prod in (req['products'] ?? []))
                              Text(
                                '${prod['quantity']} ${prod['unit']} ${prod['name']}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                          ],
                        ),
                        if (req['date'] != null && req['time'] != null)
                          Text(
                            '${req['date']} ${req['time']}',
                            style: const TextStyle(color: Colors.black54, fontSize: 13),
                          ),
                        if (req['description'] != null && req['description'].isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              req['description'],
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (userType != UserType.farmer)
          Positioned(
            right: 24,
            bottom: 24,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF175C2B),
              onPressed: onAddRequest,
              child: const Icon(Icons.add, color: Colors.white, size: 32),
            ),
          ),
      ],
    );
  }
}
