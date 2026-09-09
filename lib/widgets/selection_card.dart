import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class SelectionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(8),
          height: 140,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryGreen : AppColors.cardWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? AppColors.primaryGreen : Colors.grey[200]!),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? Colors.white : Colors.brown, size: 24),
              const SizedBox(height: 8),
              Text(title, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black)),
              const SizedBox(height: 4),
              Text(description, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 8, color: isSelected ? Colors.white70 : AppColors.textGrey)),
            ],
          ),
        ),
      ),
    );
  }
}
