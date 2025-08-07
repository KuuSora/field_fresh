import 'dart:io';
import 'package:flutter/material.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_drawer.dart';
import '../cart/request_info_screen.dart';
import 'widgets/shop_top_bar.dart';
import 'widgets/shop_tab_bar.dart';
import 'widgets/product_grid.dart';
import 'widgets/requests_list.dart';

class ShopDashboard extends StatefulWidget {
  final String userPhone;
  final String userName;

  const ShopDashboard({
    super.key,
    required this.userPhone,
    required this.userName,
  });

  @override
  State<ShopDashboard> createState() => _ShopDashboardState();
}

class _ShopDashboardState extends State<ShopDashboard> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedTab = 0;
  late final PageController _pageController;
  UserType _userType = UserType.basic;

  late String userName;
  late String userPhone;

  final List<Map<String, String>> products = [
    {
      'name': 'Cabbage',
      'price': '₱80 per kilo',
      'image': 'assets/cabbage.png',
    },
    {
      'name': 'Carrots',
      'price': 'XX per kilo',
      'image': 'assets/carrots.png',
    },
    {
      'name': 'Tomatoes',
      'price': 'XX per kilo',
      'image': 'assets/tomatoes.png',
    },
    {
      'name': 'Potatoes',
      'price': 'XX per kilo',
      'image': 'assets/potatoes.png',
    },
    // Add more products as needed
  ];

  List<Map<String, dynamic>> requests = [];
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedTab);
    userName = widget.userName;
    userPhone = widget.userPhone;
  }

  void _addRequest(Map<String, dynamic> request) {
    setState(() {
      requests.add(request);
    });
  }

  void _goToRequestsTab() {
    setState(() {
      _selectedTab = 1;
      _pageController.jumpToPage(1);
    });
  }

  void _showAddToCartDialog(Map<String, String> product) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AddToCartDialog(
        name: product['name'] ?? '',
        shop: 'Mang Kanor Greens',
      ),
    );
  }

  void _showAddRequestDialog() {
    showDialog(
      context: context,
      builder: (context) => AddRequestDialog(
        onRequestAdded: (request) async {
          Navigator.of(context).pop();
          await showDialog(
            context: context,
            builder: (context) => RequestSuccessDialog(
              onGoToRequests: () {
                Navigator.of(context).pop();
                _goToRequestsTab();
              },
            ),
          );
          _addRequest({
            ...request,
            'posted': DateTime.now(),
          });
        },
      ),
    );
  }

  void _showSubscribeDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const SubscribeDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: ProfileDrawer(
        userType: _userType,
        onUserTypeChanged: (type) {
          setState(() {
            _userType = type;
          });
        },
        userName: userName,
        userPhone: userPhone,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ShopTopBar(
              scaffoldKey: _scaffoldKey,
              userName: userName,
              userPhone: userPhone,
              onCartPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              onSearch: (query) {
                // TODO: Implement search logic
              },
            ),
            ShopTabBar(
              selectedTab: _selectedTab == 0 ? ShopTab.onSale : ShopTab.requests,
              onTabSelected: (tab) {
                setState(() {
                  _selectedTab = tab == ShopTab.onSale ? 0 : 1;
                  _pageController.animateToPage(_selectedTab, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                });
              },
              onFilter: () {
                // TODO: Implement filter logic
              },
              isPremium: _userType != UserType.basic,
              onPremiumTap: _showSubscribeDialog,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PageView(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _selectedTab = index;
                    });
                  },
                  children: [
                    ProductGrid(
                      products: products,
                      onAddToCart: _showAddToCartDialog,
                    ),
                    RequestsList(
                      requests: requests,
                      comments: comments,
                      userType: _userType,
                      onRequestTap: (req) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestInfoScreen(
                              request: req,
                              userType: _userType,
                              comments: comments.where((c) => c['requestId'] == req['id']).toList(),
                              onSendComment: (String text) {
                                setState(() {
                                  comments.add({
                                    'requestId': req['id'],
                                    'userType': _userType,
                                    'text': text,
                                    'timestamp': DateTime.now(),
                                  });
                                });
                              },
                            ),
                          ),
                        );
                      },
                      onAddRequest: _showAddRequestDialog,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Subscribe Dialog Widget ---
class SubscribeDialog extends StatelessWidget {
  const SubscribeDialog({super.key});

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
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, color: Colors.red, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Premium Feature',
              style: TextStyle(
                color: Color(0xFF175C2B),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'You have selected a premium feature.\nSubscribe to use this feature.',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF175C2B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the first dialog
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => const SubscriptionPerksDialog(),
                  );
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
          ],
        ),
      ),
    );
  }
}

// --- Subscription Perks Dialog Widget ---
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
              children: [
                Expanded(
                  child: Column(
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
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF1F8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• Basic voucher discount', style: TextStyle(color: Colors.black87, fontSize: 15)),
                            Text('• Limited purchase only per produce', style: TextStyle(color: Colors.black87, fontSize: 15)),
                            Text('• Can use the search function', style: TextStyle(color: Colors.black87, fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
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
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF1F8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• Advanced and exclusive vouchers', style: TextStyle(color: Colors.black87, fontSize: 15)),
                            Text('• Unlimited purchase of produce', style: TextStyle(color: Colors.black87, fontSize: 15)),
                            Text('• Make requests in advance to buy produce and receive notifications when requests are available', style: TextStyle(color:Colors.black87, fontSize: 15)),
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

// --- AddToCartDialog Widget ---
class AddToCartDialog extends StatefulWidget {
  final String name;
  final String shop;

  const AddToCartDialog({
    super.key,
    required this.name,
    required this.shop,
  });

  @override
  State<AddToCartDialog> createState() => _AddToCartDialogState();
}

class _AddToCartDialogState extends State<AddToCartDialog> {
  int quantity = 1;

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
            const Text(
              'Add the following to your cart?',
              style: TextStyle(
                color: Color(0xFF175C2B),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          color: Color(0xFF175C2B),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.shop,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, color: Color(0xFF175C2B)),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF175C2B)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF175C2B),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Color(0xFF175C2B)),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF175C2B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  // TODO: Add to cart logic
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'ADD TO CART',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- AddRequestDialog Widget ---
// Updated to match your design, with attachments and callback
class AddRequestDialog extends StatefulWidget {
  final void Function(Map<String, dynamic>) onRequestAdded;
  const AddRequestDialog({super.key, required this.onRequestAdded});

  @override
  State<AddRequestDialog> createState() => _AddRequestDialogState();
}

class _AddRequestDialogState extends State<AddRequestDialog> {
  List<Map<String, dynamic>> products = [
    {'name': '', 'quantity': '', 'unit': 'kg', 'progress': 0.0},
  ];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController descriptionController = TextEditingController();
  File? imageFile;


  // TODO: Move image picking logic to AddRequestDialog widget file and import image_picker there.

  void _showUnitSelector(int index) async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFEAF1F8),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _unitRadio('bundle', index),
              _unitRadio('pcs', index),
              _unitRadio('kg', index),
            ],
          ),
        ),
      ),
    );
    if (selected != null) {
      setState(() {
        products[index]['unit'] = selected;
      });
    }
  }

  Widget _unitRadio(String value, int index) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: products[index]['unit'],
          onChanged: (val) {
            Navigator.of(context).pop(val);
          },
        ),
        Text(value),
      ],
    );
  }

  void _addProductField() {
    setState(() {
      products.add({'name': '', 'quantity': '', 'unit': 'kg', 'progress': 0.0});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(32),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFEAF1F8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'NEW REQUEST',
                style: TextStyle(
                  color: Color(0xFF175C2B),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              // Product fields
              ...products.asMap().entries.map((entry) {
                int idx = entry.key;
                var prod = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Product',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          ),
                          onChanged: (val) {
                            setState(() {
                              products[idx]['name'] = val;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 60,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Qty',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          ),
                          onChanged: (val) {
                            setState(() {
                              products[idx]['quantity'] = val;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _showUnitSelector(idx),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Color(0xFFEAF1F8),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            prod['unit'],
                            style: const TextStyle(
                              color: Color(0xFF175C2B),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              // Add another product button
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF2D2D2D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  ),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add another product', style: TextStyle(fontSize: 13)),
                  onPressed: _addProductField,
                ),
              ),
              const SizedBox(height: 8),
              // Time and Date
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) setState(() => selectedTime = time);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          selectedTime != null
                              ? selectedTime!.format(context)
                              : '12:34 PM',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) setState(() => selectedDate = date);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          selectedDate != null
                              ? '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}'
                              : 'August 25, 2025',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.calendar_today, color: Color(0xFF175C2B)),
                ],
              ),
              const SizedBox(height: 12),
              // Description
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                ),
              ),
              const SizedBox(height: 12),
              // Attachments
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Attachments', style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 4),
                    GestureDetector(
                      // onTap: _pickImage, // TODO: Move image picking logic to AddRequestDialog widget file
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: imageFile == null
                            ? const Icon(Icons.image, color: Color(0xFF175C2B))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(imageFile!, fit: BoxFit.cover),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF175C2B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    widget.onRequestAdded({
                      'products': products,
                      'date': selectedDate != null
                          ? '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}'
                          : 'August 25, 2025',
                      'time': selectedTime != null
                          ? selectedTime!.format(context)
                          : '12:34 PM',
                      'description': descriptionController.text,
                      'image': imageFile,
                    });
                  },
                  child: const Text(
                    'ADD',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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

// --- RequestSuccessDialog Widget ---
class RequestSuccessDialog extends StatelessWidget {
  final VoidCallback onGoToRequests;
  const RequestSuccessDialog({super.key, required this.onGoToRequests});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(32),
      child: Container(
        width: 260,
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
            const Icon(Icons.check_circle_outline, color: Color(0xFF175C2B), size: 48),
            const SizedBox(height: 16),
            const Text(
              'Request successful!',
              style: TextStyle(
                color: Color(0xFF175C2B),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onGoToRequests, // <-- FIX: add this line
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF175C2B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'GO TO REQUESTS',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}