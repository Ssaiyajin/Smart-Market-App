import 'package:flutter/material.dart';
import 'package:smarket_app/models/enums/likert_scale.dart';

class LikertScaleChip extends StatelessWidget {
  final LikertScale value;

  const LikertScaleChip({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.tightFor(height: 30),
      child: Transform.scale(
        scale: 0.9,
        child: Chip(
          label: Text(value.humanReadableString),
          backgroundColor: value.color,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
