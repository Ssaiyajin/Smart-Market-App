import 'package:flutter/material.dart';

class MandatoryLabel extends StatelessWidget {
  final String labelText;

  const MandatoryLabel({Key? key, required this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          WidgetSpan(
            child: Text(labelText),
          ),
          WidgetSpan(
            child: Text(
              ' *',
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
