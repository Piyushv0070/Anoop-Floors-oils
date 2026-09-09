import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class NutrientTag extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color? backgroundColor;
  final Color? textColor;

  const NutrientTag({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey)),
          Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(unit, style: GoogleFonts.poppins(fontSize: 8, color: textColor ?? AppColors.textGrey)),
        ],
      ),
    );
  }
}
