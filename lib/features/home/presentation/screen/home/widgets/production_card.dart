import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hangangramyeon/features/home/models/response/production_response.dart';

class ProductCard extends StatelessWidget {
  final ProductItem product;
  final VoidCallback onTap;
  final int index;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final double imageHeight = 140 + (index % 3) * 24;

    final card = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Product Image (variable height to create masonry effect)
          SizedBox(
            height: imageHeight,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: product.images.isNotEmpty
                  ? Hero(
                tag: product.id,
                child: Image.network(
                  "http://hangangramyeon.vn${product.images.first}",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
                    );
                  },
                ),
              )
                  : Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
              ),
            ),
          ),
          // Product Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    product.categoryName.toString(),
                    style: const TextStyle(fontSize: 10, color: Color(0xFF1976D2), fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.name.toString(),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatPrice(product.salePrice),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2196F3)),
                    ),
                    // if (product.remainingQuantity != null)
                    //   Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    //     decoration: BoxDecoration(
                    //       color: product.remainingQuantity! > 0 ? Colors.green[100] : Colors.red[100],
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //     child: Text(
                    //       '${product.remainingQuantity}',
                    //       style: TextStyle(
                    //         fontSize: 10,
                    //         color: product.remainingQuantity! > 0 ? Colors.green[700] : Colors.red[700],
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    )
    // Entrance animation per item (staggered by index)
        .animate(delay: Duration(milliseconds: 40 * (index % 10)))
        .fadeIn(duration: 350.ms, curve: Curves.easeOut)
        .slide(begin: const Offset(0, 0.06), end: Offset.zero, duration: 350.ms, curve: Curves.easeOut);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: card,
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}K';
    }
    return '${price.toStringAsFixed(0)}K';
  }
}
