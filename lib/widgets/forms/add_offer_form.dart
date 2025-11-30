import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:smarket_app/mock/in_memory_db.dart';
import 'package:smarket_app/screens/add_vehicle_page.dart';
import 'package:smarket_app/services/offer_service.dart';
import 'package:smarket_app/style/branding_colors.dart';
import 'package:smarket_app/widgets/cancel_button.dart';
import 'package:smarket_app/widgets/mandatory_label.dart';
import 'package:smarket_app/widgets/select_field.dart';

import '../../models/base/offer.dart';
import '../../models/vehicles/vehicle.dart';

class AddOfferForm extends StatefulWidget {
  const AddOfferForm({super.key});

  @override
  State<StatefulWidget> createState() => _AddOfferFormState();
}

class _AddOfferFormState extends State<AddOfferForm> {
  final _formKey = GlobalKey<FormState>();
  final _currentUser =
      InMemoryDB.getUsers().elementAt(0); // TODO: replace with correct user
  late Vehicle _selectedVehicle = _currentUser.vehicles.first;
  final TextEditingController _locationController = TextEditingController();
  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: SelectField<Vehicle>(
              value: _selectedVehicle,
              mandatory: true,
              labelText: 'Vehicle',
              items: _currentUser.vehicles
                  .map<DropdownMenuItem<Vehicle>>((Vehicle v) {
                return DropdownMenuItem<Vehicle>(
                  value: v,
                  child: Text('${v.manufacturer} (${v.description})'),
                );
              }).toList(),
              onChanged: (dynamic vehicle) {
                if (vehicle != null) {
                  setState(() {
                    _selectedVehicle = vehicle as Vehicle;
                  });
                }
              },
            ),
          ),
          Container(
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(builder: (_) => const AddVehiclePage()),
                )
                    .then((v) {
                  if (v != null) {
                    setState(() {
                      _currentUser.vehicles.add(v as Vehicle);
                      _selectedVehicle = v;
                    });
                  }
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Vehicle'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                label: MandatoryLabel(labelText: 'Location'),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
            ),
          ),
          const Text(
              'To ensure your privacy, you can use a region instead of a location.'),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: DateTimePicker(
              decoration: const InputDecoration(
                label: MandatoryLabel(labelText: 'Start of Availability'),
                border: OutlineInputBorder(),
              ),
              type: DateTimePickerType.date,
              dateMask: 'dd.MM.yyyy',
              initialValue: DateTime.now().toString(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2999),
              icon: const Icon(Icons.date_range),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a start date';
                }
                return null;
              },
              onChanged: (value) => _startDateTime = DateTime.parse(value),
            ),
          ),
          DateTimePicker(
            decoration: const InputDecoration(
              label: MandatoryLabel(labelText: 'End of Availability'),
              border: OutlineInputBorder(),
            ),
            type: DateTimePickerType.date,
            dateMask: 'dd.MM.yyyy',
            firstDate: DateTime.now(),
            lastDate: DateTime(2999),
            dateLabelText: 'End of Availability',
            icon: const Icon(Icons.date_range),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an end date';
              }
              return null;
            },
            onChanged: (value) => _endDateTime = DateTime.parse(value),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: BrandingColors.successColor,
              minimumSize: const Size.fromHeight(40),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                Offer offer = await OfferService.createOffer(
                  vehicleId: _selectedVehicle.id,
                  lenderId: _currentUser.id,
                  location: _locationController.text,
                  startDate: _startDateTime,
                  endDate: _endDateTime,
                );

                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text('Offer published!'),
                  ),
                );
                Navigator.of(context).pop(offer);
              }
            },
            child: const Text('Publish'),
          ),
          const CancelButton()
        ],
      ),
    );
  }
}
