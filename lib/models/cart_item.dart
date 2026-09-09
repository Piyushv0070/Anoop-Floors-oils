class CartItem {
  final String id;
  final String title;
  final String subtitle;
  final String price;
  final String imageUrl;
  final List<String>? ingredientBreakdown;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    this.ingredientBreakdown,
    this.quantity = 1,
  });

  double get priceValue {
    // Extract numerical value from price string like "₹320" or "₹145 / 1 kg"
    final regex = RegExp(r'₹(\d+)');
    final match = regex.firstMatch(price);
    if (match != null) {
      return double.parse(match.group(1)!);
    }
    return 0.0;
  }
}
