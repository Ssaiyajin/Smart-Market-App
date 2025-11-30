import 'package:flutter/material.dart';
import 'package:smarket_app/extensions/date_time_extension.dart';
import 'package:smarket_app/screens/offer_details.dart';
import 'package:smarket_app/widgets/chips/bike_type_chip.dart';

import '../models/base/offer.dart';
import '../models/vehicles/bike.dart';

class OfferItem extends StatelessWidget {
  final Offer offer;

  const OfferItem({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = offer.vehicle.manufacturer;
    String subtitle =
        "${offer.startDate.toLocalDate()} - ${offer.endDate.toLocalDate()}\n"
        "${offer.lender.name}\n"
        "${offer.location!}";

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              OfferDetailsPage(offerId: offer.id!),
        ),
      ),
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: const Icon(Icons.directions_bike), // TODO: use image
                  title: Text(title),
                  subtitle: Text(subtitle),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 6, right: 6),
                  child: BikeTypeChip(type: (offer.vehicle as Bike).type!),
                ),
                const SizedBox(height: 18),
                IconButton(
                  onPressed: () {
                    /* TODO: implement bookmarks */
                  },
                  icon: const Icon(Icons.bookmark_outline),
                  color: Theme.of(context).primaryColor,
                  tooltip: 'Bookmark',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
