import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:smarket_app/models/base/offer.dart';

/// Encapsulates all state logic related to offers, e.g., creating, modifying, deleting, updating offers.
/// It should be the only class that has API / Mock DB access with respect to offers.
class OfferService {
  static const String _baseUrl = 'smarket-server.herokuapp.com';
  static final Uri _offersUri = Uri.https(_baseUrl, 'offers');

  static Future<List<Offer>> getOffers() async {
    log('Fetching offers from $_offersUri');
    http.Response response = await http.get(_offersUri);
    if (response.statusCode != 200) {
      log('${response.statusCode} ${response.body.toString()}');
      return Future.error('No offers retrieved, see logs for more details');
    }

    List<dynamic> jsonData = jsonDecode(response.body);
    log('Retrieved offers: $jsonData');
    final offers =
        jsonData.map((offerJson) => Offer.fromJson(offerJson)).toList();
    offers.sort((a, b) {
      return b.startDate.compareTo(a.startDate);
    });
    return offers;
  }

  static Future<Offer> getOfferById(String id) async {
    Uri uri = Uri.https(_baseUrl, 'offers/$id');
    log('Fetching offer with id $id from $uri');

    http.Response response = await http.get(uri);
    if (response.statusCode != 200) {
      log('${response.statusCode} ${response.body.toString()}');
      return Future.error(
          'No offer with id $id retrieved, see logs for more details');
    }

    final jsonData = jsonDecode(response.body);
    log('Retrieved offer $jsonData');
    return Offer.fromJson(jsonData);
  }

  static Future<Offer> createOffer({
    required String vehicleId,
    required String lenderId,
    required DateTime startDate,
    required DateTime endDate,
    String? location,
    String? rentalId,
  }) async {
    Map<String, dynamic> body = {
      'vehicleId': vehicleId,
      'lenderId': lenderId,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
      'location': location
    };

    log('Creating offer with data: $body');
    http.Response response = await http.post(_offersUri, body: body);

    if (response.statusCode != 201) {
      log('${response.statusCode} ${response.body.toString()}');
      return Future.error('No offer created, see logs for more details');
    }

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    log('${response.statusCode} $jsonData');
    return Offer.fromJson(jsonData['offer']);
  }
}
