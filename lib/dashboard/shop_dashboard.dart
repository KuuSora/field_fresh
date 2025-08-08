import 'dart:io';
import 'package:flutter/material.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_drawer.dart';
import '../cart/request_info_screen.dart';
import 'widgets/shop_top_bar.dart';
import 'widgets/shop_tab_bar.dart';
import 'widgets/product_grid.dart';
import 'widgets/requests_list.dart';
import 'dialogs/subscribe_dialog.dart';
import 'dialogs/subscription_perks_dialog.dart';
import 'dialogs/add_to_cart_dialog.dart';
import 'dialogs/add_request_dialog.dart';
import 'dialogs/request_success_dialog.dart';

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