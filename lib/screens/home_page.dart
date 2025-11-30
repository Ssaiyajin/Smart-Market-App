import 'package:flutter/material.dart';
import 'package:smarket_app/mock/in_memory_db.dart';
import 'package:smarket_app/models/base/user.dart';
import 'package:smarket_app/widgets/offer_list.dart';
import 'package:smarket_app/widgets/page_title_wrapper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User _user = InMemoryDB.getUsers().elementAt(0);

  @override
  Widget build(BuildContext context) {
    return PageTitleWrapper(
      title: 'Welcome back, ${_user.name}!',
      child: const Expanded(
        child: OfferList(),
      ),
    );
  }
}
