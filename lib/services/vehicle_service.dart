import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:smarket_app/extensions/enum_extension.dart';
import 'package:smarket_app/models/enums/bike_type.dart';
import 'package:smarket_app/models/enums/likert_scale.dart';
import 'package:smarket_app/models/vehicles/vehicle.dart';

import '../models/vehicles/bike.dart';

/// Encapsulates all state logic related to vehicles, e.g., creating, modifying, deleting, updating vehicles.
/// It should be the only class that has API / Mock DB access with respect to vehicles.
class VehicleService {
  static const String _baseUrl = 'smarket-server.herokuapp.com';

  static Future<Vehicle> createVehicle({
    required BikeType type,
    required LikertScale condition,
    required String manufacturer,
    required String description,
    List<String>? imageUrls,
    int? sizeInches,
  }) async {
    Uri uri = Uri.https(_baseUrl, 'vehicles');
    Map<String, dynamic> body = {
      'type': type.string,
      'manufacturer': manufacturer,
      'description': description,
      'condition': condition.string,
      if (imageUrls != null) 'imageUrls': imageUrls,
      if (sizeInches != null) 'size': sizeInches
    };
    log('Creating vehicle with data: $body');

    http.Response response = await http.post(uri, body: body);
    if (response.statusCode != 201) {
      log('${response.statusCode} ${response.body.toString()}');
      return Future.error('No vehicle created, see logs for more details');
    }

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    String vehicleId = jsonData['id'];
    log('${response.statusCode} $jsonData');
    return getVehicleById(vehicleId);
  }

  static Future<Vehicle> getVehicleById(String id) async {
    Uri uri = Uri.https(_baseUrl, 'vehicles/$id');
    log('Fetching vehicle with id $id from $uri');

    http.Response response = await http.get(uri);
    if (response.statusCode != 200) {
      log('${response.statusCode} ${response.body.toString()}');
      return Future.error(
          'No vehicle with id $id retrieved, see logs for more details');
    }

    final jsonData = jsonDecode(response.body);
    log('Retrieved vehicle $jsonData');
    return Bike.fromJson(jsonData);
  }
}
