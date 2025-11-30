import 'package:smarket_app/models/base/user.dart';
import 'package:smarket_app/models/vehicles/vehicle.dart';

import '../vehicles/bike.dart';

class Offer {
  String? id;
  late final Vehicle vehicle;
  late final User lender;
  late final DateTime startDate;
  late final DateTime endDate;

  // TODO: refactor to Address class => city, street, postalCode, ...
  String? location;

  Offer(this.id, this.vehicle, this.lender, this.location, this.startDate,
      this.endDate);

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicle = Bike.fromJson(json['vehicle']);
    lender = User.fromJson(json['lender']);
    startDate = DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']);
    location = json['location'];
  }
}
