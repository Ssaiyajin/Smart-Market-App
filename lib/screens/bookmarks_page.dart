import 'package:flutter/material.dart';
import 'package:smarket_app/widgets/page_title_wrapper.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  @override
  Widget build(BuildContext context) {
    return const PageTitleWrapper(
      title: 'Bookmarks',
      subtitle: 'Revisit interesting offers',
      child: Expanded(child: Center(child: Text('No bookmarks yet...'))),
    );
  }
}
