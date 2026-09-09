import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/ingredient.dart';
import 'widgets/app_colors.dart';
import 'widgets/anoop_app_bar.dart';
import 'widgets/ingredient_card.dart';
import 'widgets/category_chip.dart';
import 'flour_crafting_page.dart';
import 'data/product_data.dart';
import 'widgets/anoop_drawer.dart';

class IngredientSelectionPage extends StatefulWidget {
  const IngredientSelectionPage({super.key});

  @override
  State<IngredientSelectionPage> createState() => _IngredientSelectionPageState();
}

class _IngredientSelectionPageState extends State<IngredientSelectionPage> {
  final List<Ingredient> _allIngredients = ProductData.allIngredients;

  String _searchQuery = '';
  String _selectedCategory = 'All';

  List<Ingredient> get _filteredIngredients {
    return _allIngredients.where((ingredient) {
      final matchesSearch = ingredient.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || ingredient.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  int get _selectedCount => _allIngredients.where((i) => i.isSelected).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AnoopAppBar(title: 'Select Ingredients'),
      endDrawer: const AnoopDrawer(),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryFilters(),
          Expanded(
            child: _filteredIngredients.isEmpty
                ? _buildEmptyState()
                : _buildIngredientsGrid(),
          ),
        ],
      ),
      bottomNavigationBar: _buildStickyFooter(),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Search grains, millets or boosters...',
          hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          prefixIcon: const Icon(Icons.search, color: AppColors.primaryGreen),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    final categories = ['All', 'Base Grains', 'Millets', 'Supergrains', 'Boosters'];
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryChip(
            label: category,
            isSelected: _selectedCategory == category,
            onTap: () => setState(() => _selectedCategory = category),
          );
        },
      ),
    );
  }

  Widget _buildIngredientsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredIngredients.length,
      itemBuilder: (context, index) {
        final ingredient = _filteredIngredients[index];
        return IngredientCard(
          ingredient: ingredient,
          onTap: () {
            setState(() {
              ingredient.isSelected = !ingredient.isSelected;
            });
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No ingredients found',
            style: GoogleFonts.poppins(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$_selectedCount Items Selected',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Customize your blend',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: _selectedCount > 0 ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FlourCraftingPage()),
                  );
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Review Formula',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
