import 'package:flutter/material.dart';
import 'package:smarket_app/widgets/forms/add_vehicle_form.dart';
import 'package:smarket_app/widgets/page_title_wrapper.dart';

class AddVehiclePage extends StatelessWidget {
  const AddVehiclePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PageTitleWrapper(
        title: 'Add Vehicle',
        subtitle: 'What are we looking at?',
        child: Expanded(child: AddVehicleForm()),
      ),
    );
  }
}
