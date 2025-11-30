import 'dart:io';

import 'package:smarket_app/services/rental_service.dart';

import '../models/base/rental.dart';

class NotificationService {
  static Future<Rental> pollFirstRentalRequestByOfferId(String offerId) async {
    while (true) {
      List<Rental> rentals =
          await RentalService.getRentalRequestsByOfferId(offerId);

      if (rentals.isNotEmpty) {
        // new rental request was made (exit loop: for demonstration purposes we just show a notification for the first rental request)
        return rentals.first;
      } else {
        // wait for a second and then continue with requests
        sleep(const Duration(seconds: 1));
      }
    }
  }
}
