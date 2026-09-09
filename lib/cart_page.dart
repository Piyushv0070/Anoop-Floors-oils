import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets/app_colors.dart';
import 'widgets/anoop_app_bar.dart';
import 'widgets/primary_button.dart';
import 'widgets/anoop_drawer.dart';
import 'providers/cart_provider.dart';
import 'models/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const AnoopAppBar(titleTag: 'My Blends & Cart'),
          endDrawer: const AnoopDrawer(),
          body: cart.items.isEmpty 
            ? _buildEmptyCart(context)
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCartHeader(cart),
                    _buildCartItems(cart),
                    _buildSubscriptionSection(),
                    _buildPriceBreakdown(cart),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
          bottomSheet: cart.items.isEmpty ? null : _buildProceedFooter(cart),
        );
      },
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Switch to home or product page logic
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGreen),
            child: const Text('Go Shopping', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildCartHeader(CartProvider cart) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Blends & Fresh Milling Bag', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            children: [
              const Icon(Icons.circle, size: 8, color: Colors.orange),
              const SizedBox(width: 4),
              Text('Freshly ground to order • Zero commercial shelf life', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.grey[300]!)),
                  child: Center(child: Text('Active Cart (${cart.itemCount})', style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(25)),
                  child: Center(child: Text('Saved Recipes (3)', style: GoogleFonts.poppins())),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(CartProvider cart) {
    return Column(
      children: cart.items.values.map((item) => _buildCartItem(item, cart)).toList(),
    );
  }

  Widget _buildCartItem(CartItem item, CartProvider cart) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8), 
                child: Image.network(
                  item.imageUrl, 
                  width: 60, 
                  height: 60, 
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[100],
                    child: const Icon(Icons.shopping_bag_outlined, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(item.subtitle, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey)),
                    if (item.ingredientBreakdown != null) ...[
                      const SizedBox(height: 8),
                      ...item.ingredientBreakdown!.map((ing) => Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          '• $ing',
                          style: GoogleFonts.poppins(fontSize: 9, color: Colors.brown.shade400, fontStyle: FontStyle.italic),
                        ),
                      )).toList(),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: () => cart.removeItem(item.id),
                icon: const Icon(Icons.delete_outline, color: Colors.grey),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    IconButton(onPressed: () => cart.removeSingleItem(item.id), icon: const Icon(Icons.remove, size: 16)),
                    Text('${item.quantity}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    IconButton(onPressed: () => cart.addItem(id: item.id, title: item.title, subtitle: item.subtitle, price: item.price, imageUrl: item.imageUrl), icon: const Icon(Icons.add, size: 16)),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₹${(item.priceValue * item.quantity).toStringAsFixed(0)}', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF0EAE2), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.sync),
              const SizedBox(width: 8),
              Text('Subscribe & Save 10%', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              const Spacer(),
              Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: AppColors.primaryGreen, borderRadius: BorderRadius.circular(4)), child: const Text('Save ₹100', style: TextStyle(color: Colors.white, fontSize: 10))),
            ],
          ),
          const SizedBox(height: 12),
          _buildSubOption('One-time delivery', '₹1,000', false),
          _buildSubOption('Every 2 Weeks', '₹900/run', false),
          _buildSubOption('Monthly Fresh Milling', '₹900/run', true),
        ],
      ),
    );
  }

  Widget _buildSubOption(String title, String price, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: isSelected ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(8), border: Border.all(color: isSelected ? AppColors.primaryGreen : Colors.grey[300]!)),
      child: Row(
        children: [
          Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: isSelected ? AppColors.primaryGreen : Colors.grey),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: GoogleFonts.poppins(fontSize: 12))),
          Text(price, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdown(CartProvider cart) {
    double total = cart.totalAmount;
    double savings = total * 0.1; // Example 10%
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildPriceRow('Item Total', '₹${total.toStringAsFixed(0)}'),
          _buildPriceRow('Subscription Savings', '-₹${savings.toStringAsFixed(0)}', color: Colors.green),
          _buildPriceRow('Stone Grinding & Jute Pouch', 'FREE', color: Colors.green),
          _buildPriceRow('Delivery Charge', 'FREE', color: Colors.green),
          const Divider(),
          _buildPriceRow('Total Payable', '₹${(total - savings).toStringAsFixed(0)}', isBold: true),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: GoogleFonts.poppins(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: color)),
        ],
      ),
    );
  }

  Widget _buildProceedFooter(CartProvider cart) {
    double totalPayable = cart.totalAmount * 0.9; // Example 10% savings
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))]),
      child: PrimaryButton(
        text: 'Proceed to Fresh Milling & Delivery (₹${totalPayable.toStringAsFixed(0)})',
        icon: Icons.arrow_forward,
        onPressed: () {},
      ),
    );
  }
}
