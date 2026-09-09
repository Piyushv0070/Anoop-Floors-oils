import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class StepHeader extends StatelessWidget {
  final String stepNumber;
  final String title;
  final String? subtitle;
  final Color? subtitleColor;
  final String? trailingText;

  const StepHeader({
    super.key,
    required this.stepNumber,
    required this.title,
    this.subtitle,
    this.subtitleColor,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: AppColors.primaryGreen, shape: BoxShape.circle),
            child: Text(stepNumber, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                if (subtitle != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: (subtitleColor ?? Colors.grey).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(subtitle!, style: GoogleFonts.poppins(fontSize: 10, color: subtitleColor ?? Colors.grey)),
                  ),
              ],
            ),
          ),
          if (trailingText != null)
            Text(trailingText!, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey)),
        ],
      ),
    );
  }
}
