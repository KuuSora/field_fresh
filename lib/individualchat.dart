import 'package:flutter/material.dart';
// import 'chats.dart';

class IndividualChatScreen extends StatefulWidget {
  final String sender;
  const IndividualChatScreen({super.key, required this.sender});

  @override
  State<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {
      'isMe': true,
      'text': 'I have bought your item.',
      'time': '8:37 AM',
      'date': 'Today',
    },
    {
      'isMe': false,
      'text':
          'Thanks for buying our cabbage. How would like your order to be delivered? We offer payment through GCash, GCashOD, and COD. Please send your receipt if you paid via GCash.',
      'time': '8:49 AM',
      'date': 'Today',
    },
  ];

  String getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final ampm = now.hour >= 12 ? 'AM' : 'PM';
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute $ampm';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF1F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF175C2B)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.sender,
          style: const TextStyle(
            color: Color(0xFF175C2B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFDDE2E8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                messages.isNotEmpty ? messages[0]['date'] : 'Today',
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFEAF1F8),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  if (msg['isMe']) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF175C2B),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              msg['text'],
                              style: const TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          msg['time'],
                          style: const TextStyle(color: Colors.black54, fontSize: 11),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              msg['text'],
                              style: const TextStyle(color: Colors.black87, fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          msg['time'],
                          style: const TextStyle(color: Colors.black54, fontSize: 11),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          // Message input bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Type your message here',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.black38),
                        ),
                        onSubmitted: (value) => _sendMessage(),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Color(0xFF175C2B)),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.image, color: Colors.black38),
                      onPressed: () {
                        // TODO: Attach image
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.videocam, color: Colors.black38),
                      onPressed: () {
                        // TODO: Attach video
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.store, color: Colors.black38),
                      onPressed: () {
                        // TODO: Open shop
                      },
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

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      messages.add({
        'isMe': true,
        'text': text,
        'time': getCurrentTime(),
        'date': 'Today',
      });
      _controller.clear();
    });
  }
}