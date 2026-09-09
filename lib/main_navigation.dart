import 'package:flutter/material.dart';
import 'home_page.dart';
import 'flour_crafting_page.dart';
import 'cold_pressed_oils_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';
import 'ingredient_selection_page.dart';
import 'widgets/app_colors.dart';

import 'profile_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  void _onNavigate(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _startCustomMixFlow() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const IngredientSelectionPage()),
    );
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(
        onStartCustomMix: _startCustomMixFlow,
        onViewAllOils: () => _onNavigate(2),
      ),
      const FlourCraftingPage(),
      const ColdPressedOilsPage(),
      const CartPage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.textGrey,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.grain), label: 'Flour Mix'),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop_outlined), label: 'Oils'),
          BottomNavigationBarItem(
            icon: Badge(label: Text('2'), child: Icon(Icons.shopping_cart_outlined)),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }
}
