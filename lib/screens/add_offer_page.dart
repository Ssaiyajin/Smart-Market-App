import 'package:flutter/material.dart';
import 'package:smarket_app/widgets/forms/add_offer_form.dart';
import 'package:smarket_app/widgets/page_title_wrapper.dart';

class AddOfferPage extends StatelessWidget {
  const AddOfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: PageTitleWrapper(
          title: 'Add Offer',
          subtitle: 'Thanks for sharing mobility services with others!',
          child: AddOfferForm(),
        ),
      ),
    );
  }
}
