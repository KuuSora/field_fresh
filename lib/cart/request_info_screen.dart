import 'package:flutter/material.dart';
import '../profile/profile_drawer.dart';

class RequestInfoScreen extends StatefulWidget {
  final Map<String, dynamic> request;
  final UserType userType;
  final List<Map<String, dynamic>> comments;
  final void Function(String text)? onSendComment;

  const RequestInfoScreen({
    super.key,
    required this.request,
    required this.userType,
    required this.comments,
    this.onSendComment,
  });

  @override
  State<RequestInfoScreen> createState() => _RequestInfoScreenState();
}

class _RequestInfoScreenState extends State<RequestInfoScreen> {
  bool showFullDescription = false;
  static const int maxLinesCollapsed = 4;
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = widget.request;
    final String description = request['description'] ?? '';
    final imageFile = request['image'];
    final DateTime posted = request['posted'] ?? DateTime.now();
    final String timeAgo = _getTimeAgo(posted);

    // Support multiple products
    final List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(request['products'] ?? []);
    final String title = items.map((e) => '${e['quantity']} ${e['unit']} ${e['name']}').join(', ');

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back arrow only
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF175C2B)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Request Info Card
            Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Color(0xFFEAF1F8),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title and time ago
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            timeAgo,
                            style: const TextStyle(color: Colors.black54, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'By Luz Viminda',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // --- Product Image (not stretched) ---
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: imageFile != null
                            ? Image.file(
                                imageFile,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/fieldfresh_logo.png',
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(height: 12),
                      // --- Description Box with See More/Hide All ---
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final textSpan = TextSpan(
                            text: description,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          );
                          final textPainter = TextPainter(
                            text: textSpan,
                            maxLines: maxLinesCollapsed,
                            textDirection: TextDirection.ltr,
                          )..layout(maxWidth: constraints.maxWidth - 24);

                          final isOverflowing = textPainter.didExceedMaxLines;

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  description,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: showFullDescription ? null : maxLinesCollapsed,
                                  overflow: showFullDescription ? TextOverflow.visible : TextOverflow.ellipsis,
                                ),
                                if (isOverflowing)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showFullDescription = !showFullDescription;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        showFullDescription ? 'See less' : 'See more',
                                        style: const TextStyle(
                                          color: Color(0xFF175C2B),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      // Progress bars for each product
                      ...items.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _RequestProgressBar(
                              label: '${item['quantity']} ${item['unit']} ${item['name']}',
                              progress: item['progress'] ?? 0.0,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Comments section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Comments',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: widget.comments.isEmpty
                  ? Center(
                      child: Text(
                        'No comments yet',
                        style: TextStyle(color: Colors.black38, fontSize: 15),
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.comments.length,
                      itemBuilder: (context, idx) {
                        final c = widget.comments[idx];
                        return ListTile(
                          leading: Icon(
                            c['userType'] == UserType.farmer
                                ? Icons.agriculture
                                : Icons.person,
                            color: c['userType'] == UserType.farmer
                                ? Colors.orange
                                : Colors.blueGrey,
                          ),
                          title: Text(
                            c['text'],
                            style: TextStyle(fontSize: 15),
                          ),
                          subtitle: Text(
                            (c['timestamp'] as DateTime).toLocal().toString().substring(0, 16),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        );
                      },
                    ),
            ),
            // Only show comment input for Farmer user
            if (widget.userType == UserType.farmer)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'Write a comment...',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: Color(0xFF175C2B)),
                      onPressed: () {
                        final text = commentController.text.trim();
                        if (text.isNotEmpty && widget.onSendComment != null) {
                          widget.onSendComment!(text);
                          commentController.clear();
                          setState(() {}); // To refresh the UI if needed
                        }
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime posted) {
    final diff = DateTime.now().difference(posted);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    return '${diff.inDays} days ago';
  }
}

class _RequestProgressBar extends StatelessWidget {
  final String label;
  final double progress;
  const _RequestProgressBar({required this.label, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(label, style: const TextStyle(fontSize: 14)),
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFF175C2B), width: 2),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 24,
                decoration: BoxDecoration(
                  color: Color(0xFF175C2B),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Text('${(progress * 100).toInt()}%',
                    style: const TextStyle(
                      color: Color(0xFF175C2B),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
