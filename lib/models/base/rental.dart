import 'package:smarket_app/models/base/offer.dart';
import 'package:smarket_app/models/base/user.dart';

import '../enums/rental_state.dart';

class Rental {
  // the offer associated with the rental
  late final Offer offer;
  late final User borrower;
  late final DateTime beginDate;
  late final DateTime returnDate;
  late final RentalState state;

  Rental(
      this.offer, this.borrower, this.beginDate, this.returnDate, this.state);

  Rental.fromJson(Map<String, dynamic> json) {
    offer = Offer.fromJson(json['offer']);
    borrower = User.fromJson(json['borrower']);
    beginDate = DateTime.parse(json['rentalStartDate']);
    returnDate = DateTime.parse(json['rentalEndDate']);
    state = parseRentalState(json['state']);
  }
}