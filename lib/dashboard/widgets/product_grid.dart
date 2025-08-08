import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  final List<Map<String, String>> products;
  final void Function(Map<String, String> product) onAddToCart;
  final void Function(Map<String, String> product)? onProductTap;
  final void Function()? onCartIconTap; // <-- add this

  const ProductGrid({
    super.key,
    required this.products,
    required this.onAddToCart,
    this.onProductTap,
    this.onCartIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: onProductTap != null ? () => onProductTap!(product) : null,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFEAF1F8),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      product['image'] ?? '',
                      fit: BoxFit.contain,
                      height: 80,
                      width: 80,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image, size: 60, color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    product['name'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF175C2B),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    product['price'] ?? '',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 8),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF175C2B),
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.shopping_cart, color: Colors.white, size: 18),
                        onPressed: onCartIconTap, // <-- go to cart screen
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
