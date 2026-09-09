import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets/app_colors.dart';
import 'widgets/anoop_app_bar.dart';
import 'widgets/product_card.dart';
import 'widgets/anoop_drawer.dart';
import 'providers/cart_provider.dart';
import 'data/product_data.dart';
import 'product_details_page.dart';

class AllProductsPage extends StatelessWidget {
  final String title;
  const AllProductsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final products = ProductData.allIngredients;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AnoopAppBar(title: title),
      endDrawer: const AnoopDrawer(),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            title: product.name,
            subtitle: product.category,
            price: product.price,
            imageUrl: product.imageUrl,
            variant: ProductCardVariant.vertical,
            onAdd: () {
              cart.addItem(
                id: product.id,
                title: product.name,
                subtitle: product.category,
                price: product.price,
                imageUrl: product.imageUrl,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.name} added to cart!'))
              );
            },
          );
        },
      ),
    );
  }
}
