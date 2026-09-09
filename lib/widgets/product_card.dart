import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

enum ProductCardVariant { vertical, horizontal }

class ProductCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String? oldPrice;
  final String? discount;
  final String imageUrl;
  final String? tag;
  final String? rating;
  final List<String>? labels;
  final ProductCardVariant variant;
  final VoidCallback onAdd;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    this.oldPrice,
    this.discount,
    required this.imageUrl,
    this.tag,
    this.rating,
    this.labels,
    this.variant = ProductCardVariant.vertical,
    required this.onAdd,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: variant == ProductCardVariant.vertical
          ? _buildVerticalCard()
          : _buildHorizontalCard(),
    );
  }

  Widget _buildVerticalCard() {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl, 
                  height: 120, 
                  width: double.infinity, 
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 120,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
                  ),
                ),
              ),
              if (tag != null)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.orangeLight, borderRadius: BorderRadius.circular(4)),
                    child: Text(tag!, style: GoogleFonts.poppins(fontSize: 8, color: AppColors.orangeAccent, fontWeight: FontWeight.bold)),
                  ),
                ),
              if (rating != null)
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(Icons.star, size: 10, color: Colors.orange),
                        Text(rating!, style: GoogleFonts.poppins(fontSize: 8, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12)),
                Text(subtitle, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(price, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
                    const Spacer(),
                    GestureDetector(
                      onTap: onAdd,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(4)),
                        child: const Icon(Icons.add, size: 16),
                      ),
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

  Widget _buildHorizontalCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl, 
              width: 100, 
              height: 100, 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 100,
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (tag != null)
                   Padding(
                     padding: const EdgeInsets.only(bottom: 4.0),
                     child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.orangeLight, borderRadius: BorderRadius.circular(4)),
                      child: Text(tag!, style: GoogleFonts.poppins(fontSize: 8, color: AppColors.orangeAccent, fontWeight: FontWeight.bold)),
                                       ),
                   ),
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(subtitle, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(price, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                    if (oldPrice != null)
                      Text(oldPrice!, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey, decoration: TextDecoration.lineThrough)),
                    if (discount != null)
                      Text(discount!, style: GoogleFonts.poppins(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border, size: 20)),
              ElevatedButton(
                onPressed: onAdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.shopping_basket_outlined, size: 14, color: Colors.white),
                    SizedBox(width: 4),
                    Text('Add', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
