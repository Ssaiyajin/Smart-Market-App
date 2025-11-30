import 'package:flutter/material.dart';

class ColumnCard extends StatelessWidget {
  final Widget start;
  final Widget? end;

  const ColumnCard({Key? key, required this.start, this.end}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            start,
            if (end != null) const SizedBox(height: 12),
            if (end != null) end!,
          ],
        ),
      ),
    );
  }
}
