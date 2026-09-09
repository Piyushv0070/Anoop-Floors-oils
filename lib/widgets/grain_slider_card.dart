import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class GrainSliderCard extends StatelessWidget {
  final String name;
  final String? tag;
  final String description;
  final double value;
  final double min;
  final double max;
  final String imageUrl;
  final String? priceTag;
  final Function(double) onChanged;
  final List<String>? tags;
  final Widget? bottomWidget;

  const GrainSliderCard({
    super.key,
    required this.name,
    this.tag,
    required this.description,
    required this.value,
    this.min = 0,
    this.max = 100,
    required this.imageUrl,
    this.priceTag,
    required this.onChanged,
    this.tags,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.cardWhite, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl, 
                  width: 60, 
                  height: 60, 
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[100],
                    child: const Icon(Icons.grain, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            name,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (tag != null) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(4)),
                            child: Text(tag!, style: GoogleFonts.poppins(fontSize: 8, color: Colors.red)),
                          ),
                        ],
                      ],
                    ),
                    Text(description, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey)),
                    if (tags != null) ...[
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        children: tags!.map((t) => _buildSmallTag(t)).toList(),
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (priceTag != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(4)),
                      child: Text(priceTag!, style: GoogleFonts.poppins(fontSize: 10, color: Colors.green)),
                    ),
                  Text(
                    value >= 1000 
                        ? '${(value / 1000).toStringAsFixed(2)} Kg' 
                        : '${value.toInt()} g', 
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)
                  ),
                ],
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: AppColors.primaryGreen,
            inactiveColor: Colors.grey[200],
            onChanged: onChanged,
          ),
          if (bottomWidget != null) bottomWidget!,
        ],
      ),
    );
  }

  Widget _buildSmallTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(4)),
      child: Text(text, style: GoogleFonts.poppins(fontSize: 8, color: AppColors.textGrey)),
    );
  }
}
