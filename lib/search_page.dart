import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets/app_colors.dart';
import 'widgets/product_card.dart';
import 'providers/cart_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _trendingSearches = [
    "Multigrain Atta",
    "Cold Pressed Groundnut Oil",
    "High Protein Mix",
    "Stone-ground Wheat",
    "Organic Ghee",
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search for flours, oils, or grains...",
            hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () => _searchController.clear(),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Trending Searches",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _trendingSearches.map((search) {
                  return ActionChip(
                    label: Text(
                      search,
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.grey[200]!),
                    ),
                    onPressed: () {
                      _searchController.text = search;
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Recent Results",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ProductCard(
              title: "Premium Multigrain Atta",
              subtitle: "Stone-ground | 9 Grains | High Fiber",
              price: "₹450",
              imageUrl: "https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=2072&auto=format&fit=crop",
              tag: "Bestseller",
              rating: "4.8",
              variant: ProductCardVariant.horizontal,
              onAdd: () {
                cart.addItem(
                  id: 'search_res_1',
                  title: 'Premium Multigrain Atta',
                  subtitle: 'Stone-ground | 5 Kg',
                  price: '₹450',
                  imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=2072&auto=format&fit=crop',
                );
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart!')));
              },
            ),
            ProductCard(
              title: "Cold Pressed Groundnut Oil",
              subtitle: "Pure | Chemical-free | Wood-pressed",
              price: "₹280",
              imageUrl: "https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?q=80&w=2036&auto=format&fit=crop",
              oldPrice: "₹320",
              discount: "12% OFF",
              variant: ProductCardVariant.horizontal,
              onAdd: () {
                cart.addItem(
                  id: 'search_res_2',
                  title: 'Cold Pressed Groundnut Oil',
                  subtitle: '1 Litre',
                  price: '₹280',
                  imageUrl: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?q=80&w=2036&auto=format&fit=crop',
                );
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart!')));
              },
            ),
            ProductCard(
              title: "Organic Finger Millet (Ragi)",
              subtitle: "Gluten-free | Rich in Calcium",
              price: "₹120",
              imageUrl: "https://images.unsplash.com/photo-1586201375761-83865001e31c?q=80&w=2070&auto=format&fit=crop",
              variant: ProductCardVariant.horizontal,
              onAdd: () {
                cart.addItem(
                  id: 'search_res_3',
                  title: 'Organic Finger Millet (Ragi)',
                  subtitle: '1 Kg',
                  price: '₹120',
                  imageUrl: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?q=80&w=2070&auto=format&fit=crop',
                );
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart!')));
              },
            ),
          ],
        ),
      ),
    );
  }
}
