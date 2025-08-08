import 'package:flutter/material.dart';
import '../cart/cart_screen.dart';
import '../cart/produce_info_screen.dart';
import '../profile/profile_drawer.dart';
import '../cart/request_info_screen.dart';
import '../cart/product_listing_screen.dart';
import 'widgets/shop_top_bar.dart';
import 'widgets/shop_tab_bar.dart';
import 'widgets/product_grid.dart';
import 'widgets/requests_list.dart';
import 'dialogs/subscribe_dialog.dart';
import 'dialogs/add_to_cart_dialog.dart';
import 'dialogs/add_request_dialog.dart';
import 'dialogs/request_success_dialog.dart';
import 'widgets/dashboard_overview_row.dart';
import 'widgets/trends_card.dart';

import 'widgets/home_tab.dart';

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

class _ShopDashboardState extends State<ShopDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedTab = 0;
  late final PageController _pageController;
  UserType _userType = UserType.basic;

  late String userName;
  late String userPhone;


  late ShopTab selectedTab;

  final products = [
    {
      'name': 'Carrots',
      'image': 'assets/carrots.jpg',
      'price': '₱50',
    },
    {
      'name': 'Cabbage',
      'image': 'assets/cabbage.jpg',
      'price': '₱40',
    },
    {
      'name': 'Tomatoes',
      'image': 'assets/tomatoes.jpg',
      'price': '₱60',
    },
    {
      'name': 'Potatoes',
      'image': 'assets/potatoes.jpg',
      'price': '₱55',
    },
  ];

  List<Map<String, dynamic>> requests = [];
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedTab);
    userName = widget.userName;
    userPhone = widget.userPhone;
    selectedTab = _userType == UserType.farmer ? ShopTab.home : ShopTab.onSale;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
    
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
    // Determine which tabs to show
    final isFarmer = _userType == UserType.farmer;
    final availableTabs = isFarmer
        ? [ShopTab.home, ShopTab.onSale, ShopTab.requests]
        : [ShopTab.onSale, ShopTab.requests];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: ProfileDrawer(
        userType: _userType,
        onUserTypeChanged: (type) {
          setState(() {
            _userType = type;
            // Optionally reset tab to home or onSale
            selectedTab = type == UserType.farmer ? ShopTab.home : ShopTab.onSale;
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
            // Custom ShopTabBar
            ShopTabBar(
              selectedTab: selectedTab,
              onTabSelected: (tab) {
                setState(() {
                  selectedTab = tab;
                });
              },
              onFilter: () {
                // TODO: Implement filter logic
              },
              isPremium: _userType == UserType.farmer || _userType == UserType.premium,
              onPremiumTap: _showSubscribeDialog,
              showHome: _userType == UserType.farmer, // <-- only show HOME for farmer
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  // Only show tabs available for this user type
                  if (selectedTab == ShopTab.home && isFarmer) {
                    return HomeTab(
                      productCount: products.length,
                      onAddProduct: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProductListingScreen()),
                        );
                      },
                      onDashboardTap: () {
                        // Your dashboard tap logic
                      },
                      onReadMore: () {
                        // Your read more logic
                      },
                    );
                  } else if (selectedTab == ShopTab.onSale) {
                    return ProductGrid(
                      products: products,
                      onAddToCart: _showAddToCartDialog,
                      onProductTap: (product) {
                        // Show product info as a modal bottom sheet
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => ProduceInfoSheet(
                            name: product['name'] ?? '',
                            image: product['image'] ?? '',
                            shop: product['shop'] ?? '',
                            details: product['details'] ?? '',
                            price: product['price'] ?? '',
                            rating: double.tryParse(product['rating'] ?? '0') ?? 0,
                          ),
                        );
                      },
                      onCartIconTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CartScreen()),
                        );
                      },
                    );
                  } else if (selectedTab == ShopTab.requests) {
                    return RequestsList(
                      requests: requests,
                      comments: comments,
                      userType: _userType,
                      onAddRequest: _showAddRequestDialog,
                      onRequestTap: (request) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RequestInfoScreen(
                              request: request,
                              userType: _userType,
                              comments: comments,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    // Fallback (should not happen)
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}