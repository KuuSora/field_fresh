import 'package:flutter/material.dart';
import '../profile.dart';
import '../cart.dart';
import '../chats.dart';
import 'logout_dialog.dart';
import '../sales_profile.dart';

enum UserType { basic, premium, farmer }

class ProfileDrawer extends StatelessWidget {
  final UserType userType;
  final ValueChanged<UserType> onUserTypeChanged;
  final String userName;
  final String userPhone; // <-- Add this line

  const ProfileDrawer({
    super.key,
    required this.userType,
    required this.onUserTypeChanged,
    required this.userName,
    required this.userPhone, // <-- Add this line
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Back arrow
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF175C2B)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              // Profile avatar and dropdown
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person, size: 48, color: Colors.grey),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          Text(
                            userName, // <-- Use the userName here
                            style: const TextStyle(
                              color: Color(0xFF175C2B),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          DropdownButton<UserType>(
                            value: userType,
                            underline: Container(),
                            icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
                            items: const [
                              DropdownMenuItem(
                                value: UserType.basic,
                                child: Text('Basic User', style: TextStyle(color: Colors.black54, fontSize: 14)),
                              ),
                              DropdownMenuItem(
                                value: UserType.premium,
                                child: Text('Premium User', style: TextStyle(color: Colors.black54, fontSize: 14)),
                              ),
                              DropdownMenuItem(
                                value: UserType.farmer,
                                child: Text('Seller/Farmer', style: TextStyle(color: Colors.black54, fontSize: 14)),
                              ),
                            ],
                            onChanged: (type) {
                              if (type != null) onUserTypeChanged(type);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Menu items
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.black),
                      title: const Text('My Profile'),
                      onTap: () {
                        Navigator.of(context).pop();
                        if (userType == UserType.farmer) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SalesProfileScreen(userPhone: userPhone), // <-- Pass userPhone
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileScreen()),
                          );
                        }
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      leading: const Icon(Icons.shopping_cart, color: Colors.black),
                      title: const Text('My Cart'),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CartScreen()),
                        );
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    // --- Only show for Seller/Farmer ---         
                    ListTile(
                      leading: const Icon(Icons.chat, color: Colors.black),
                      title: const Text('Chats'),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ChatsScreen()),
                        );
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings, color: Colors.black),
                      title: const Text('Settings'),
                      onTap: () {},
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Center(
                  child: SizedBox(
                    width: 140,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF175C2B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const LogoutDialog(),
                        );
                      },
                      child: const Text(
                        'LOG OUT',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
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

// You can now import and use ProfileDrawer in any page:
// import 'widgets/profile_drawer.dart';