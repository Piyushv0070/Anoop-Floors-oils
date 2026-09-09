import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets/app_colors.dart';
import 'widgets/anoop_app_bar.dart';
import 'widgets/category_chip.dart';
import 'widgets/product_card.dart';
import 'widgets/info_banner.dart';
import 'widgets/anoop_drawer.dart';
import 'providers/cart_provider.dart';

class ColdPressedOilsPage extends StatelessWidget {
  const ColdPressedOilsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AnoopAppBar(titleTag: 'Cold Pressed Oils'),
      endDrawer: const AnoopDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHero(),
            _buildFilters(),
            _buildDifferenceCard(),
            _buildProductListing(context, cart),
            _buildTraceabilityBanner(),
          ],
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.orange[100], borderRadius: BorderRadius.circular(4)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.info_outline, size: 12, color: Colors.orange),
                const SizedBox(width: 4),
                Text('TRADITIONAL MARA CHEKKU', style: GoogleFonts.poppins(fontSize: 8, color: Colors.orange, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text('Wood-Pressed\nPure Oils', style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primaryGreen)),
          Text('Slowly crushed in seasoned vagai wood ghanis under 45°C...', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textGrey)),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          CategoryChip(label: 'All Oils (8)', isSelected: true, onTap: () {}),
          CategoryChip(label: 'Mustard', isSelected: false, onTap: () {}),
          CategoryChip(label: 'Groundnut', isSelected: false, onTap: () {}),
          CategoryChip(label: 'Sesame', isSelected: false, onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildDifferenceCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF0EAE2), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.science_outlined),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('The Lakdi Ghani Difference', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    Text('Unlike commercial expellers...', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey)),
                  ],
                ),
              ),
              Container(
                 padding: const EdgeInsets.all(4),
                 decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(4)),
                 child: Text('< 45°C', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductListing(BuildContext context, CartProvider cart) {
    return Column(
      children: [
        ProductCard(
          title: 'Raw Yellow Mustard Oil',
          subtitle: 'Cold-pressed in Vaagai wood ghani. Mild pungency...',
          price: '₹290',
          oldPrice: '₹330',
          discount: '12% OFF',
          tag: 'SIGNATURE HARVEST',
          rating: '4.9',
          imageUrl: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=200',
          variant: ProductCardVariant.horizontal,
          onAdd: () {
            cart.addItem(
              id: 'oil_2',
              title: 'Raw Yellow Mustard Oil',
              subtitle: '1 Litre',
              price: '₹290',
              imageUrl: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=200',
            );
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart!')));
          },
        ),
        ProductCard(
          title: 'Wood Pressed Peanut Oil',
          subtitle: 'Sweet nutty aroma, golden color, unbleached.',
          price: '₹320',
          tag: 'BEST SELLER',
          imageUrl: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=200',
          variant: ProductCardVariant.horizontal,
          onAdd: () {
            cart.addItem(
              id: 'oil_3',
              title: 'Wood Pressed Peanut Oil',
              subtitle: '1 Litre',
              price: '₹320',
              imageUrl: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=200',
            );
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart!')));
          },
        ),
      ],
    );
  }

  Widget _buildTraceabilityBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.primaryGreen, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.qr_code_scanner, color: Colors.white, size: 32),
          const SizedBox(height: 12),
          Text('Scan QR on Any Bottle', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Verify real-time lab parameters...', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 10)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[300], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('View Lab Report', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
