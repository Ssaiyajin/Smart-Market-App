import 'package:smarket_app/models/enums/bike_type.dart';
import 'package:smarket_app/models/vehicles/vehicle.dart';

import '../enums/likert_scale.dart';

class Bike extends Vehicle {
  BikeType? type;
  int? sizeInches;

  Bike(super.id, super.manufacturer, super.description, super.condition,
      super.imageUrls, this.type, this.sizeInches);

  Bike.fromJson(Map<String, dynamic> json)
      : super(
            json['id'],
            json['manufacturer'],
            json['description'],
            parseLikertScale(json['condition']),
            json['imageUrls'].cast<String>()) {
    type = parseBikeType(json['type']);
    sizeInches = json['size'];
  }
}
