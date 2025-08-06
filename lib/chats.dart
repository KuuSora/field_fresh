import 'package:flutter/material.dart';
import 'shop_dashboard.dart';
import 'individualchat.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  String filter = 'All';
  final List<Map<String, dynamic>> messages = [
    {
      'sender': 'Mang Kanor Greens',
      'message': 'Thanks for buying our cabbage. How would li.....',
      'unread': true,
    },
    {
      'sender': 'Nena Batumbakal',
      'message': 'Yes sir, the item is still available. Do you want......',
      'unread': false,
    },
    {
      'sender': 'Julius D. Sakalam',
      'message': 'We have received your payment. Item will be......',
      'unread': true,
    },
  ];

  List<Map<String, dynamic>> get filteredMessages {
    if (filter == 'All') return messages;
    if (filter == 'Unread') return messages.where((m) => m['unread']).toList();
    if (filter == 'New') return messages.where((m) => m['unread']).toList(); // You can customize "New"
    return messages;
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
            Navigator.of(context).pop(); // <-- Just exit the chat screen
          },
        ),
        title: const Text(
          'Chats',
          style: TextStyle(
            color: Color(0xFF175C2B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black26),
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.black38, fontSize: 16),
                filled: true,
                fillColor: const Color(0xFFEAF1F8),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: GestureDetector(
              onTap: () async {
                final selected = await showMenu<String>(
                  context: context,
                  position: const RelativeRect.fromLTRB(100, 120, 100, 0),
                  items: [
                    PopupMenuItem(value: 'All', child: _buildFilterOption('All')),
                    PopupMenuItem(value: 'New', child: _buildFilterOption('New')),
                    PopupMenuItem(value: 'Unread', child: _buildFilterOption('Unread')),
                  ],
                );
                if (selected != null) setState(() => filter = selected);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1F8),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildFilterOption(filter),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filteredMessages.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.black26),
              itemBuilder: (context, index) {
                final msg = filteredMessages[index];
                return ListTile(
                  title: Text(
                    msg['sender'],
                    style: const TextStyle(
                      color: Color(0xFF175C2B),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    msg['message'],
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: msg['unread']
                      ? Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        )
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IndividualChatScreen(sender: msg['sender']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: label,
          groupValue: filter,
          onChanged: (_) {},
          activeColor: Colors.black54,
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
