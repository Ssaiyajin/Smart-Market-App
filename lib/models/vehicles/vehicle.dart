import 'package:smarket_app/models/enums/likert_scale.dart';

abstract class Vehicle {
  late final String id;
  String manufacturer;
  String description;
  LikertScale condition;
  List<String> imageUrls = <String>[];

  Vehicle(this.id, this.manufacturer, this.description, this.condition,
      this.imageUrls);
}