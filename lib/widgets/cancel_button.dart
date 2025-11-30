import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  final String? label;

  const CancelButton({Key? key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(label ?? 'Cancel'),
      ),
    );
  }
}
