import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.priceValue * cartItem.quantity;
    });
    return total;
  }

  void addItem({
    required String id,
    required String title,
    required String subtitle,
    required String price,
    required String imageUrl,
    List<String>? ingredientBreakdown,
  }) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (existing) => CartItem(
          id: existing.id,
          title: existing.title,
          subtitle: existing.subtitle,
          price: existing.price,
          imageUrl: existing.imageUrl,
          ingredientBreakdown: existing.ingredientBreakdown,
          quantity: existing.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => CartItem(
          id: id,
          title: title,
          subtitle: subtitle,
          price: price,
          imageUrl: imageUrl,
          ingredientBreakdown: ingredientBreakdown,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) return;
    if (_items[id]!.quantity > 1) {
      _items.update(
        id,
        (existing) => CartItem(
          id: existing.id,
          title: existing.title,
          subtitle: existing.subtitle,
          price: existing.price,
          imageUrl: existing.imageUrl,
          quantity: existing.quantity - 1,
        ),
      );
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
