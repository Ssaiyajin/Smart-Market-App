import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:smarket_app/extensions/enum_extension.dart';
import 'package:smarket_app/models/enums/rental_state.dart';

import '../models/base/rental.dart';

class RentalService {
  static const String _baseUrl = 'smarket-server.herokuapp.com';

  static Future<Rental> createRentalRequest({
    required String offerId,
    required String borrowerId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    Map<String, dynamic> body = {
      "offerId": offerId,
      "borrowerId": borrowerId,
      "rentalStartDate": startDate.toString(),
      "rentalEndDate": endDate.toString(),
      "state": RentalState.requested.string
    };

    log('Creating rental request with data: $body');
    http.Response response =
        await http.post(Uri.https(_baseUrl, 'rental/request'), body: body);

    if (response.statusCode != 201) {
      log('${response.statusCode} ${response.body.toString()}');
      return Future.error(
          'No rental request created, see logs for more details');
    }

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    log('${response.statusCode} $jsonData');
    return Rental.fromJson(jsonData['rental']);
  }

  static Future<List<Rental>> getRentalRequestsByOfferId(String offerId) async {
    Uri uri = Uri.https(
        _baseUrl, 'rental', {'state': 'requested', 'offerId': offerId});
    log('Fetching rentals from $uri');
    http.Response response = await http.get(uri);
    if (response.statusCode != 200) {
      log('${response.statusCode} ${response.body.toString()}');
      return Future.error('No rentals retrieved, see logs for more details');
    }

    List<dynamic> jsonData = jsonDecode(response.body);
    log('Retrieved rentals: $jsonData');
    return jsonData.map((rentalJson) => Rental.fromJson(rentalJson)).toList();
  }
}
