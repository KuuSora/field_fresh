import 'package:flutter/material.dart';

class ProductListingScreen extends StatelessWidget {
  const ProductListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration
    final products = List.generate(6, (index) => {
      'name': 'Carrots',
      'image': 'assets/carrots.png',
      'unit': 'kg',
      'stocks': '123',
      'price': '₱123',
      'checked': index == 0,
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back arrow and title
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 12, bottom: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF175C2B), size: 28),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'PRODUCTS',
                    style: TextStyle(
                      color: Color(0xFF175C2B),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            // All Products Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.inventory_2_outlined, color: Color(0xFF175C2B), size: 28),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'ALL PRODUCTS',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '67',
                          style: TextStyle(
                            color: Color(0xFF175C2B),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                height: 38,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(color: Colors.black38, fontSize: 15),
                    prefixIcon: const Icon(Icons.search, color: Colors.black38),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
                    ),
                  ),
                ),
              ),
            ),
            // Add New Product Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF175C2B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    '+ Add New Product',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            // Table header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1F8),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Row(
                  children: const [
                    SizedBox(width: 32, child: Checkbox(value: false, onChanged: null)),
                    Expanded(
                      flex: 2,
                      child: Text('Product', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF175C2B))),
                    ),
                    Expanded(
                      child: Text('Photo', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF175C2B))),
                    ),
                    Expanded(
                      child: Text('Unit', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF175C2B))),
                    ),
                    Expanded(
                      child: Text('Stocks', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF175C2B))),
                    ),
                    Expanded(
                      child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF175C2B))),
                    ),
                  ],
                ),
              ),
            ),
            // Product list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(height: 2),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 32,
                          child: Checkbox(
                            value: product['checked'] as bool,
                            onChanged: (_) {},
                            activeColor: const Color(0xFF175C2B),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            product['name'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF175C2B),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            product['image'] as String,
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image, color: Colors.grey, size: 28),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            product['unit'] as String,
                            style: const TextStyle(fontSize: 15, color: Colors.black87),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            product['stocks'] as String,
                            style: const TextStyle(fontSize: 15, color: Colors.black87),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            product['price'] as String,
                            style: const TextStyle(fontSize: 15, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Pagination
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    '1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF175C2B),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_right, color: Color(0xFF175C2B)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}