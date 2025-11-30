import 'package:flutter/material.dart';
import 'package:smarket_app/style/branding_colors.dart';

import '../../models/enums/bike_type.dart';

class BikeTypeChip extends StatelessWidget {
  final BikeType type;

  const BikeTypeChip({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.tightFor(height: 30),
      child: Transform.scale(
        scale: 0.9,
        child: Chip(
          label: Text(
            type.humanReadableString,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: BrandingColors.secondaryColor,
        ),
      ),
    );
  }
}
