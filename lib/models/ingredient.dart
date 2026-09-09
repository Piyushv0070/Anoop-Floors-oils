class Ingredient {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String price;
  final String description;
  final List<String> tags;
  final double protein; // per 100g
  final double fiber;   // per 100g
  final int gi;         // Glycemic Index
  final int calories;   // kcal per 100g
  bool isSelected;

  Ingredient({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    this.description = '',
    this.tags = const [],
    this.protein = 10.0,
    this.fiber = 5.0,
    this.gi = 55,
    this.calories = 340,
    this.isSelected = false,
  });

  double get pricePerKg {
    final regex = RegExp(r'₹(\d+)');
    final match = regex.firstMatch(price);
    if (match != null) {
      return double.parse(match.group(1)!);
    }
    return 0.0;
  }
}
