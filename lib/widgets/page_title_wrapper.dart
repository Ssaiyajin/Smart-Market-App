import 'package:flutter/material.dart';

class PageTitleWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  final String? subtitle;

  const PageTitleWrapper(
      {Key? key, required this.title, required this.child, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              top: 40.0,
              bottom: (subtitle == null) ? 20.0 : 10.0,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          if (subtitle != null)
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Text(
                subtitle ?? '',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          child
        ],
      ),
    );
  }
}
