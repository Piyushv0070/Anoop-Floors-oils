import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets/app_colors.dart';
import 'widgets/anoop_app_bar.dart';
import 'widgets/nutrient_tag.dart';
import 'widgets/step_header.dart';
import 'widgets/grain_slider_card.dart';
import 'widgets/selection_card.dart';
import 'widgets/primary_button.dart';
import 'providers/cart_provider.dart';
import 'data/product_data.dart';
import 'models/ingredient.dart';

import 'widgets/anoop_drawer.dart';

class FlourCraftingPage extends StatefulWidget {
  const FlourCraftingPage({super.key});

  @override
  State<FlourCraftingPage> createState() => _FlourCraftingPageState();
}

class _FlourCraftingPageState extends State<FlourCraftingPage> {
  int selectedBaseGrainIndex = 0;
  
  final List<Ingredient> baseGrains = ProductData.allIngredients
      .where((i) => i.category == 'Base Grains').toList();

  double baseGrainWeight = 2500.0;
  double fingerMilletWeight = 1000.0;
  double sorghumWeight = 750.0;
  double maizeWeight = 500.0;
  double bajraWeight = 0.0;
  double barleyWeight = 0.0;
  double soybeanWeight = 0.0;
  double quinoaWeight = 0.0;
  double chanaWeight = 250.0;
  
  bool alsChecked = true;
  bool methiChecked = false;
  bool moringaChecked = false;
  bool superseedsChecked = false;
  
  String selectedWeight = '5 Kg';
  String selectedFineness = 'Medium Regular';

  Ingredient getIngredient(String id) => ProductData.allIngredients.firstWhere((i) => i.id == id);

  double get totalWeight {
    return baseGrainWeight + fingerMilletWeight + sorghumWeight + maizeWeight + 
           bajraWeight + barleyWeight + soybeanWeight + quinoaWeight + chanaWeight;
  }

  double get targetTotalWeight {
    if (selectedWeight == '1 Kg') return 1000.0;
    if (selectedWeight == '5 Kg') return 5000.0;
    if (selectedWeight == '10 Kg Bulk') return 10000.0;
    return totalWeight; 
  }

  double get totalPrice {
    double price = 0;
    price += (baseGrainWeight / 1000) * baseGrains[selectedBaseGrainIndex].pricePerKg;
    price += (fingerMilletWeight / 1000) * getIngredient('3').pricePerKg;
    price += (sorghumWeight / 1000) * getIngredient('4').pricePerKg;
    price += (maizeWeight / 1000) * getIngredient('maize').pricePerKg; 
    price += (bajraWeight / 1000) * getIngredient('5').pricePerKg;
    price += (barleyWeight / 1000) * getIngredient('12').pricePerKg;
    price += (soybeanWeight / 1000) * getIngredient('11').pricePerKg;
    price += (quinoaWeight / 1000) * getIngredient('6').pricePerKg;
    price += (chanaWeight / 1000) * getIngredient('10').pricePerKg; 
    
    if (alsChecked) price += 15;
    if (methiChecked) price += 12;
    if (moringaChecked) price += 18;
    if (superseedsChecked) price += 25;
    
    return price;
  }

  Map<String, double> get nutrients {
    double protein = 0;
    double fiber = 0;
    double gi = 0;
    double calories = 0;

    void addNutrients(Ingredient i, double weight) {
      if (weight <= 0) return;
      double factor = weight / 100;
      protein += i.protein * factor;
      fiber += i.fiber * factor;
      gi += i.gi * (weight / totalWeight);
      calories += i.calories * factor;
    }

    addNutrients(baseGrains[selectedBaseGrainIndex], baseGrainWeight);
    addNutrients(getIngredient('3'), fingerMilletWeight);
    addNutrients(getIngredient('4'), sorghumWeight);
    addNutrients(getIngredient('maize'), maizeWeight);
    addNutrients(getIngredient('5'), bajraWeight);
    addNutrients(getIngredient('12'), barleyWeight);
    addNutrients(getIngredient('11'), soybeanWeight);
    addNutrients(getIngredient('6'), quinoaWeight);
    addNutrients(getIngredient('10'), chanaWeight);

    return {
      'protein': protein / (totalWeight / 100),
      'fiber': fiber / (totalWeight / 100),
      'gi': gi,
      'calories': calories / (totalWeight / 100),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AnoopAppBar(titleTag: 'Custom Flour'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildWeightSelector(),
            _buildFormulaComposition(),
            _buildStep1BaseGrain(),
            _buildStep2Millets(),
            _buildStep3Boosters(),
            _buildStep4Fineness(),
            _buildRecipeNaming(),
            const SizedBox(height: 120),
          ],
        ),
      ),
      bottomSheet: _buildFooter(),
      endDrawer: const AnoopDrawer(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.grain, size: 16, color: Colors.brown),
              const SizedBox(width: 4),
              Text('Stone-Ground Artisanal Mill', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: AppColors.orangeLight, borderRadius: BorderRadius.circular(12)),
                child: Text('Live Studio', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.orangeAccent, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Flour Crafting Studio', style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xFF1B3022))),
          const SizedBox(height: 4),
          Text('Formulate your 100% personalized grain mix with natural stone-mill fineness.', style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700])),
        ],
      ),
    );
  }

  void _updatePresets(double targetTotalWeight) {
    setState(() {
      double ratio = targetTotalWeight / 5000;
      baseGrainWeight = 2500 * ratio;
      fingerMilletWeight = 1000 * ratio;
      sorghumWeight = 750 * ratio;
      maizeWeight = 500 * ratio;
      chanaWeight = 250 * ratio;
      bajraWeight = 0;
      barleyWeight = 0;
      soybeanWeight = 0;
      quinoaWeight = 0;
    });
  }

  Widget _buildWeightSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: ['1 Kg', '5 Kg', '10 Kg Bulk', 'Custom Amount'].map((weight) {
          bool isSelected = selectedWeight == weight;
          return GestureDetector(
            onTap: () {
              setState(() => selectedWeight = weight);
              if (weight == '1 Kg') _updatePresets(1000);
              else if (weight == '5 Kg') _updatePresets(5000);
              else if (weight == '10 Kg Bulk') _updatePresets(10000);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryGreen : AppColors.cardWhite,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? AppColors.primaryGreen : Colors.grey[300]!),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    weight,
                    style: GoogleFonts.poppins(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  if (weight.contains('5 Kg')) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(4)),
                      child: Text('Popular', style: GoogleFonts.poppins(fontSize: 8, color: Colors.white)),
                    )
                  ]
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFormulaComposition() {
    final stats = nutrients;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.cardWhite, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.pie_chart_outline, color: AppColors.textGrey),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FORMULA COMPOSITION', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey)),
                  Row(
                    children: [
                      Text('100%', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(4)),
                        child: Text('Balanced', style: GoogleFonts.poppins(fontSize: 10, color: Colors.green)),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Batch Yield', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey)),
                  Text('${(totalWeight / 1000).toStringAsFixed(2)} Kg', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Row(
              children: [
                Expanded(flex: (baseGrainWeight / totalWeight * 100).toInt(), child: Container(height: 8, color: Colors.orange[200])),
                Expanded(flex: (fingerMilletWeight / totalWeight * 100).toInt(), child: Container(height: 8, color: Colors.orange[400])),
                Expanded(flex: (sorghumWeight / totalWeight * 100).toInt(), child: Container(height: 8, color: Colors.green[200])),
                Expanded(flex: (maizeWeight / totalWeight * 100).toInt(), child: Container(height: 8, color: Colors.green[700])),
                Expanded(flex: (chanaWeight / totalWeight * 100).toInt(), child: Container(height: 8, color: Colors.red[900])),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NutrientTag(label: 'Protein', value: '${stats['protein']!.toStringAsFixed(1)}g', unit: '/100g'),
              NutrientTag(label: 'Fiber', value: '${stats['fiber']!.toStringAsFixed(1)}g', unit: '/100g'),
              NutrientTag(label: 'Est. GI', value: stats['gi']!.toInt().toString(), unit: stats['gi']! < 55 ? 'Low GI' : 'Med GI', backgroundColor: stats['gi']! < 55 ? Colors.green[50] : Colors.red[50], textColor: stats['gi']! < 55 ? Colors.green : Colors.red),
              NutrientTag(label: 'Calories', value: stats['calories']!.toInt().toString(), unit: 'kcal'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep1BaseGrain() {
    var selectedGrain = baseGrains[selectedBaseGrainIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StepHeader(stepNumber: 'Step 1', title: 'Base Grain', trailingText: 'Min 2.0 Kg recommended'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: baseGrains.asMap().entries.map((entry) {
              int idx = entry.key;
              var grain = entry.value;
              bool isSelected = selectedBaseGrainIndex == idx;
              return GestureDetector(
                onTap: () => setState(() => selectedBaseGrainIndex = idx),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryGreen : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isSelected ? AppColors.primaryGreen : Colors.grey[300]!),
                  ),
                  child: Text(
                    grain.name.split(' ')[0],
                    style: GoogleFonts.poppins(color: isSelected ? Colors.white : Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        GrainSliderCard(
          name: selectedGrain.name,
          description: selectedGrain.description,
          value: baseGrainWeight,
          min: targetTotalWeight * 0.1,
          max: targetTotalWeight * 0.9,
          imageUrl: selectedGrain.imageUrl,
          priceTag: selectedGrain.price,
          tags: selectedGrain.tags,
          onChanged: (v) => setState(() => baseGrainWeight = v),
          bottomWidget: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 16, color: Colors.brown),
                const SizedBox(width: 8),
                Expanded(child: Text('Selected base grain provides the primary structure and flavor profile of your mix.', style: GoogleFonts.poppins(fontSize: 10))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2Millets() {
    return Column(
      children: [
        const StepHeader(stepNumber: 'Step 2', title: 'Millets & Supergrains', subtitle: 'Rich in Micro-Nutrients', subtitleColor: Colors.red),
        GrainSliderCard(
          name: 'Finger Millet (Ragi)',
          tag: 'High Calcium',
          description: '344mg Calcium/100g. Promotes bone density and steady blood sugar.',
          value: fingerMilletWeight,
          min: 0,
          max: targetTotalWeight * 0.4,
          imageUrl: 'https://images.unsplash.com/photo-1536304993881-ff6e9e5ba939?w=400',
          priceTag: '₹${getIngredient('3').pricePerKg.toStringAsFixed(0)}/kg',
          onChanged: (v) => setState(() => fingerMilletWeight = v),
        ),
        GrainSliderCard(
          name: 'Sorghum (Jowar)',
          tag: 'Gluten-Free',
          description: 'Cooling digestive properties, high dietary polyphenols and antioxidants.',
          value: sorghumWeight,
          min: 0,
          max: targetTotalWeight * 0.4,
          imageUrl: 'https://images.unsplash.com/photo-1599940778173-e276d4acb2bb?w=400',
          priceTag: '₹${getIngredient('4').pricePerKg.toStringAsFixed(0)}/kg',
          onChanged: (v) => setState(() => sorghumWeight = v),
        ),
        GrainSliderCard(
          name: 'Maize (Makka)',
          tag: 'Iron Rich',
          description: 'Rich in iron, vitamins, and minerals for balanced energy.',
          value: maizeWeight,
          min: 0,
          max: targetTotalWeight * 0.4,
          imageUrl: 'https://images.unsplash.com/photo-1599940778173-e276d4acb2bb?w=400',
          priceTag: '₹${getIngredient('maize').pricePerKg.toStringAsFixed(0)}/kg',
          onChanged: (v) => setState(() => maizeWeight = v),
        ),
        GrainSliderCard(
          name: 'Bajra (Pearl Millet)',
          tag: 'Complex Carbs',
          description: 'Packed with complex carbohydrates, iron, and B-complex vitamins.',
          value: bajraWeight,
          min: 0,
          max: targetTotalWeight * 0.4,
          imageUrl: 'https://images.unsplash.com/photo-1589927986089-35812388d1f4?w=400',
          priceTag: '₹${getIngredient('5').pricePerKg.toStringAsFixed(0)}/kg',
          onChanged: (v) => setState(() => bajraWeight = v),
        ),
        GrainSliderCard(
          name: 'Barley (Jau) & Oats',
          tag: 'Low GI',
          description: 'Excellent for lowering GI and supplying soluble beta-glucan fiber.',
          value: barleyWeight,
          min: 0,
          max: targetTotalWeight * 0.4,
          imageUrl: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400',
          priceTag: '₹${getIngredient('12').pricePerKg.toStringAsFixed(0)}/kg',
          onChanged: (v) => setState(() => barleyWeight = v),
        ),
        GrainSliderCard(
          name: 'Soybean',
          tag: 'Protein Booster',
          description: 'Powerful plant-based protein booster that balances the carbohydrate load.',
          value: soybeanWeight,
          min: 0,
          max: targetTotalWeight * 0.4,
          imageUrl: 'https://images.unsplash.com/photo-1515942400420-2b98fed1f515?w=400',
          priceTag: '₹${getIngredient('11').pricePerKg.toStringAsFixed(0)}/kg',
          onChanged: (v) => setState(() => soybeanWeight = v),
        ),
        GrainSliderCard(
          name: 'Quinoa',
          tag: 'Amino Profile',
          description: 'Provides a complete amino acid profile alongside high mineral content.',
          value: quinoaWeight,
          min: 0,
          max: targetTotalWeight * 0.4,
          imageUrl: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400',
          priceTag: '₹${getIngredient('6').pricePerKg.toStringAsFixed(0)}/kg',
          onChanged: (v) => setState(() => quinoaWeight = v),
        ),
        _buildAddGrainItem('Rolled Oats', 'Soluble heart-healthy fiber. Gives rotis tender and pliable softness.'),
      ],
    );
  }

  Widget _buildAddGrainItem(String name, String desc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.cardWhite, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(width: 60, height: 60, decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.grain, color: AppColors.textGrey)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text(desc, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey)),
              ],
            ),
          ),
          TextButton(onPressed: () {}, child: Text('+ Add', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildStep3Boosters() {
    return Column(
      children: [
        const StepHeader(stepNumber: 'Step 3', title: 'Functional Health Boosters', subtitle: 'Botanical Boost', subtitleColor: Colors.orange),
        GrainSliderCard(
          name: 'Sprouted Kala Chana',
          tag: 'Protein',
          description: 'Bio-available plant protein & naturally lowered glycemic load.',
          value: chanaWeight,
          min: 0,
          max: targetTotalWeight * 0.2,
          imageUrl: 'https://images.unsplash.com/photo-1515942400420-2b98fed1f515?w=100',
          priceTag: '₹${getIngredient('10').pricePerKg.toStringAsFixed(0)}/kg',
          onChanged: (v) => setState(() => chanaWeight = v),
        ),
        _buildBoosterToggle('Flaxseed Meal (Alsi) Omega-3 ALA', 'Gently stone-crushed cold (+₹15/batch)', '+₹15', alsChecked, (v) => setState(() => alsChecked = v!)),
        _buildBoosterToggle('Fenugreek (Methi) Seeds Sugar Control', 'Traditional pancreatic wellness enhancer (+₹12/batch)', '+₹12', methiChecked, (v) => setState(() => methiChecked = v!)),
        _buildBoosterToggle('Moringa Powder', 'Extra micronutrients & antioxidants (+₹18/batch)', '+₹18', moringaChecked, (v) => setState(() => moringaChecked = v!)),
        _buildBoosterToggle('Superseeds Mix', 'Omega-3 fatty acids & blood sugar regulation (+₹25/batch)', '+₹25', superseedsChecked, (v) => setState(() => superseedsChecked = v!)),
      ],
    );
  }

  Widget _buildBoosterToggle(String title, String desc, String price, bool value, Function(bool?) onChanged) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.cardWhite, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Checkbox(value: value, onChanged: onChanged),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12)),
                Text(desc, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey)),
              ],
            ),
          ),
          Text(price, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStep4Fineness() {
    return Column(
      children: [
        const StepHeader(stepNumber: 'Step 4', title: 'Stone-Grind Fineness', subtitle: 'Cool-Chakki Process', subtitleColor: AppColors.textGrey),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              SelectionCard(
                title: 'Coarse / Daliya',
                description: 'Rustic texture, hearty thick rotis',
                icon: Icons.grain,
                isSelected: selectedFineness == 'Coarse / Daliya',
                onTap: () => setState(() => selectedFineness = 'Coarse / Daliya'),
              ),
              SelectionCard(
                title: 'Medium Regular',
                description: 'Chakki ground, daily soft phulkas',
                icon: Icons.check_circle_outline,
                isSelected: selectedFineness == 'Medium Regular',
                onTap: () => setState(() => selectedFineness = 'Medium Regular'),
              ),
              SelectionCard(
                title: 'Extra Fine / Silk',
                description: 'Fluffy poori & delicate parathas',
                icon: Icons.blur_on,
                isSelected: selectedFineness == 'Extra Fine / Silk',
                onTap: () => setState(() => selectedFineness = 'Extra Fine / Silk'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeNaming() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.edit_note, size: 16),
              const SizedBox(width: 4),
              Text('Name Your Custom Recipe', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'My Family Daily Health Mix #1',
              suffixIcon: const Icon(Icons.grain, color: Colors.green),
              filled: true,
              fillColor: AppColors.cardWhite,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We print your custom batch recipe, milling date, and family blend name directly on the breathable burlap bag.',
            style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    double price = totalPrice;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: AppColors.cardWhite, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))]),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Batch Price: ₹${(price / (totalWeight / 1000)).toStringAsFixed(0)}/kg', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey)),
              Text('₹${price.toStringAsFixed(0)}', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
              Text('for ${(totalWeight / 1000).toStringAsFixed(2)} Kg', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textGrey)),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: PrimaryButton(
              text: 'Mill Fresh & Add',
              icon: Icons.grain,
              onPressed: () {
                List<String> breakdown = [];
                void addIfPresent(String name, double weight) {
                  if (weight > 0) {
                    breakdown.add('$name: ${weight >= 1000 ? (weight / 1000).toStringAsFixed(2) + ' Kg' : weight.toInt().toString() + ' g'}');
                  }
                }
                addIfPresent(baseGrains[selectedBaseGrainIndex].name, baseGrainWeight);
                addIfPresent('Finger Millet (Ragi)', fingerMilletWeight);
                addIfPresent('Sorghum (Jowar)', sorghumWeight);
                addIfPresent('Maize (Makka)', maizeWeight);
                addIfPresent('Bajra (Pearl Millet)', bajraWeight);
                addIfPresent('Barley (Jau)', barleyWeight);
                addIfPresent('Soybean', soybeanWeight);
                addIfPresent('Quinoa', quinoaWeight);
                addIfPresent('Sprouted Kala Chana', chanaWeight);
                if (alsChecked) breakdown.add('Flaxseed Meal (Alsi)');
                if (methiChecked) breakdown.add('Fenugreek (Methi) Seeds');
                if (moringaChecked) breakdown.add('Moringa Powder');
                if (superseedsChecked) breakdown.add('Superseeds Mix');

                cart.addItem(
                  id: 'custom_blend_${DateTime.now().millisecondsSinceEpoch}',
                  title: 'My Custom ${baseGrains[selectedBaseGrainIndex].name.split(' ')[0]} Mix',
                  subtitle: '${(totalWeight / 1000).toStringAsFixed(2)} Kg • $selectedFineness',
                  price: '₹${price.toStringAsFixed(0)}',
                  imageUrl: baseGrains[selectedBaseGrainIndex].imageUrl,
                  ingredientBreakdown: breakdown,
                );
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Custom blend added to cart!')));
              },
            ),
          ),
        ],
      ),
    );
  }
}
