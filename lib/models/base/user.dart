import 'package:smarket_app/models/base/address.dart';
import 'package:smarket_app/models/enums/likert_scale.dart';

import '../vehicles/bike.dart';
import '../vehicles/vehicle.dart';

class User {
  late final String id;
  late final String name;
  late List<Vehicle> vehicles;
  String? phoneNumber;
  String? emailAddress;
  int numberOfVouchers = 3;
  LikertScale? averageRating;
  int? studentNumber;
  Address? address;

  User(this.id,
      this.name,
      this.phoneNumber,
      this.emailAddress,
      this.numberOfVouchers,
      this.averageRating,
      this.studentNumber,
      this.address,
      this.vehicles,);

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    vehicles = (json['vehicles'] as List).map((e) => Bike.fromJson(e)).toList();
  }

  isEligibleToBorrow() => numberOfVouchers > 0;
}
