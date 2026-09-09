import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets/app_colors.dart';
import 'widgets/product_card.dart';
import 'providers/cart_provider.dart';
import 'data/product_data.dart';
import 'models/ingredient.dart';
import 'product_details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Ingredient> _searchResults = [];
  bool _isSearching = false;

  final List<String> _trendingSearches = [
    "Wheat",
    "Oil",
    "Atta",
    "Millet",
    "Ragi",
  ];

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    final results = ProductData.allIngredients.where((item) {
      final nameLower = item.name.toLowerCase();
      final categoryLower = item.category.toLowerCase();
      final queryLower = query.toLowerCase();

      return nameLower.contains(queryLower) || categoryLower.contains(queryLower);
    }).toList();

    setState(() {
      _searchResults = results;
      _isSearching = true;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: "Search for flours, oils, or grains...",
            hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      _onSearchChanged('');
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.grey[100],
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
            if (!_isSearching) ...[
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
                        _onSearchChanged(search);
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Our Favorites",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildProductItem(ProductData.allIngredients[0], cart),
              _buildProductItem(ProductData.allIngredients[3], cart),
            ] else ...[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Search Results (${_searchResults.length})",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
              if (_searchResults.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Column(
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          "No items found matching your search",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ..._searchResults.map((item) => _buildProductItem(item, cart)).toList(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(Ingredient item, CartProvider cart) {
    return ProductCard(
      title: item.name,
      subtitle: "${item.category} | Freshly Milled",
      price: item.price,
      imageUrl: item.imageUrl,
      variant: ProductCardVariant.horizontal,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: item),
          ),
        );
      },
      onAdd: () {
        cart.addItem(
          id: item.id,
          title: item.name,
          subtitle: item.category,
          price: item.price,
          imageUrl: item.imageUrl,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${item.name} added to cart!"),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }
}
