import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smarket_app/models/enums/bike_type.dart';
import 'package:smarket_app/services/vehicle_service.dart';
import 'package:smarket_app/widgets/select_field.dart';

import '../../models/enums/likert_scale.dart';
import '../../models/vehicles/vehicle.dart';
import '../../style/branding_colors.dart';
import '../cancel_button.dart';
import '../mandatory_label.dart';

class AddVehicleForm extends StatefulWidget {
  const AddVehicleForm({super.key});

  @override
  State<StatefulWidget> createState() => _AddVehicleFormState();
}

class _AddVehicleFormState extends State<AddVehicleForm> {
  final _formKey = GlobalKey<FormState>();
  final List<LikertScale> _conditions = LikertScale.values;
  final List<BikeType> _bikeTypes = BikeType.values;
  late BikeType _selectedBikeType = _bikeTypes.first;
  late LikertScale _selectedCondition = _conditions.first;
  final manufacturerController = TextEditingController();
  final descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _imagesList = [];
  dynamic _pickImageError;

  void selectImages() async {
    log('Selecting images...');
    final List<XFile>? selectedImages =
        await _picker.pickMultiImage().catchError((e) {
      log('Could not select images: $e');
      _pickImageError = e;
    });
    if (selectedImages!.isNotEmpty) {
      setState(() {
        _imagesList.addAll(selectedImages);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SelectField<BikeType>(
              value: _selectedBikeType,
              labelText: 'Bike Type',
              mandatory: true,
              items: _bikeTypes.map<DropdownMenuItem<BikeType>>((BikeType v) {
                return DropdownMenuItem<BikeType>(
                  value: v,
                  child: Text(v.humanReadableString),
                );
              }).toList(),
              onChanged: (dynamic bikeType) {
                if (bikeType != null) {
                  setState(() {
                    _selectedBikeType = bikeType;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: manufacturerController,
              decoration: const InputDecoration(
                label: MandatoryLabel(labelText: 'Manufacturer'),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide a manufacturer';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SelectField<LikertScale>(
              value: _selectedCondition,
              mandatory: true,
              labelText: 'Condition',
              items: _conditions
                  .map<DropdownMenuItem<LikertScale>>((LikertScale c) {
                return DropdownMenuItem<LikertScale>(
                  value: c,
                  child: Text(c.humanReadableString),
                );
              }).toList(),
              onChanged: (dynamic condition) {
                if (condition != null) {
                  setState(() {
                    _selectedCondition = condition;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              maxLines: 3,
              controller: descriptionController,
              decoration: const InputDecoration(
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
                hintText: 'Description',
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton.icon(
                onPressed: () {
                  selectImages();
                },
                icon: const Icon(
                  Icons.camera_alt,
                  size: 20.0,
                ),
                label: const Text('Upload Image'),
              ),
            ),
            _previewSelectedImages(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: BrandingColors.successColor,
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Vehicle vehicle = await VehicleService.createVehicle(
                      manufacturer: manufacturerController.text,
                      description: descriptionController.text,
                      condition: _selectedCondition,
                      type: _selectedBikeType
                    // TODO: upload images picked by user
                  );

                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Vehicle created!'),
                    ),
                  );
                  Navigator.of(context).pop(vehicle);
                }
              },
              child: const Text('Save'),
            ),
            const CancelButton()
          ],
        ),
      ),
    );
  }

  Widget _previewSelectedImages() {
    if (_imagesList.isNotEmpty) {
      return Container(
        constraints: const BoxConstraints.tightFor(height: 150),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _imagesList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(File(_imagesList[index].path)),
              );
            }),
      );
    } else if (_pickImageError != null) {
      return const Text(
        'Could not pick images :(',
        style: TextStyle(color: BrandingColors.dangerColor),
      );
    } else {
      return const SizedBox(height: 16);
    }
  }
}
