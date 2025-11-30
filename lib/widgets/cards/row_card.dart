import 'package:flutter/material.dart';

class RowCard extends StatelessWidget {
  final Widget start;
  final Widget? end;
  final MainAxisAlignment? mainAxisAlignment;

  const RowCard(
      {Key? key, required this.start, this.end, this.mainAxisAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment:
              mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            start,
            if (end != null) const SizedBox(width: 8),
            if (end != null) end!,
          ],
        ),
      ),
    );
  }
}
