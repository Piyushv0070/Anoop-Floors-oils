import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets/app_colors.dart';
import 'widgets/anoop_app_bar.dart';
import 'widgets/category_chip.dart';
import 'widgets/product_card.dart';
import 'providers/cart_provider.dart';

import 'widgets/anoop_drawer.dart';
import 'all_products_page.dart';
import 'data/product_data.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onStartCustomMix;
  final VoidCallback onViewAllOils;
  const HomePage({
    super.key, 
    required this.onStartCustomMix,
    required this.onViewAllOils,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AnoopAppBar(titleTag: 'Home'),
      endDrawer: const AnoopDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomAttaBanner(),
            _buildCuratedFlours(context, cart),
            _buildWoodPressedOils(context, cart),
            _buildMillingMethod(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAttaBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.brown[100],
                child: const Center(child: Icon(Icons.grain, size: 48, color: Colors.white)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Design Your Custom Atta', style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('Calibrate your grains, fiber, and protein ratios.', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: onStartCustomMix,
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    child: const Text('Start Custom Mix →', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCuratedFlours(BuildContext context, CartProvider cart) {
    final products = ProductData.allIngredients.take(4).toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Curated Flour Blends', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllProductsPage(title: 'Curated Flour Blends'),
                    ),
                  );
                },
                child: Text('View all (${ProductData.allIngredients.length}) >', style: GoogleFonts.poppins(fontSize: 12, color: Colors.brown)),
              ),
            ],
          ),
        ),
        ...products.map((product) => ProductCard(
          title: product.name,
          subtitle: product.category,
          price: product.price,
          imageUrl: product.imageUrl,
          variant: ProductCardVariant.horizontal,
          onAdd: () {
            cart.addItem(
              id: product.id,
              title: product.name,
              subtitle: product.category,
              price: product.price,
              imageUrl: product.imageUrl,
            );
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.name} added to cart!')));
          },
        )).toList(),
      ],
    );
  }

  Widget _buildWoodPressedOils(BuildContext context, CartProvider cart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Wood Pressed Oils (Ghani)', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: onViewAllOils,
                child: Text('View all (8) >', style: GoogleFonts.poppins(fontSize: 12, color: Colors.brown)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              ProductCard(
                title: 'Groundnut Oil',
                subtitle: 'Wood Pressed • 1 Litre',
                price: '₹320',
                imageUrl: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=200',
                onAdd: () {
                  cart.addItem(
                    id: 'oil_1',
                    title: 'Groundnut Oil',
                    subtitle: '1 Litre',
                    price: '₹320',
                    imageUrl: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=200',
                  );
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart!')));
                },
              ),
              ProductCard(
                title: 'Black Mustard Oil',
                subtitle: 'Kachi Ghani • 1 Litre',
                price: '₹265',
                imageUrl: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=200',
                onAdd: () {
                  cart.addItem(
                    id: 'oil_2',
                    title: 'Black Mustard Oil',
                    subtitle: '1 Litre',
                    price: '₹265',
                    imageUrl: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=200',
                  );
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart!')));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMillingMethod() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFF0EAE2), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text('The Anoop Milling Method', style: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMethodItem(Icons.waves, 'Zero Heat'),
              _buildMethodItem(Icons.grain, '100% Bran'),
              _buildMethodItem(Icons.timer, 'Made Fresh'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMethodItem(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(backgroundColor: Colors.white, child: Icon(icon, color: Colors.brown)),
        const SizedBox(height: 8),
        Text(label, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
