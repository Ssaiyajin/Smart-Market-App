import 'package:flutter/material.dart';
import 'package:smarket_app/extensions/date_time_extension.dart';
import 'package:smarket_app/style/branding_colors.dart';

import '../models/base/offer.dart';
import '../models/base/rental.dart';
import '../screens/add_offer_page.dart';
import '../services/notification_service.dart';
import '../services/offer_service.dart';
import 'offer_item.dart';

class OfferList extends StatefulWidget {
  const OfferList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OfferListState();
}

class _OfferListState extends State<OfferList> {
  List<Offer> offers = [];
  late Future<List<Offer>> offersFuture;

  @override
  void initState() {
    super.initState();
    offersFuture = OfferService.getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<List<Offer>>(
            future: offersFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return noItemsWidget();
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      offersFuture = OfferService.getOffers();
                    });
                    await Future.delayed(const Duration(seconds: 2));
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      Offer offer = snapshot.data![i];
                      return OfferItem(offer: offer);
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: BrandingColors.dangerColor,
                      duration: Duration(seconds: 2),
                      content: Text('Offers could not be fetched.'),
                    ),
                  );
                });
                return noItemsWidget();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        Positioned(
          bottom: 10,
          right: 10,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push<Offer>(
                MaterialPageRoute(
                  builder: (context) => const AddOfferPage(),
                ),
              )
                  .then((Offer? offer) {
                if (offer != null) {
                  setState(() {
                    offers.add(offer);
                    // FIXME: somehow adding the offer to the list does not update the UI => we have to update whole list
                    offersFuture = OfferService.getOffers();
                  });
                  // wait for first rental request to be created
                  NotificationService.pollFirstRentalRequestByOfferId(offer.id!)
                      .then((Rental rental) {
                    // as soon as new rental request is found, a notification banner is shown
                    ScaffoldMessenger.of(context)
                      ..removeCurrentMaterialBanner()
                      ..showMaterialBanner(rentalRequestBanner(context, offer));
                  });
                }
              });
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget noItemsWidget() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('No offers available 😞'),
            IconButton(
              tooltip: 'Refresh',
              onPressed: () {
                setState(() {
                  offersFuture = OfferService.getOffers();
                });
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
      );

  MaterialBanner rentalRequestBanner(BuildContext context, Offer offer) =>
      MaterialBanner(
        elevation: 5,
        backgroundColor: BrandingColors.primaryColor,
        padding: const EdgeInsets.all(16),
        leading: const Icon(Icons.info, color: Colors.white),
        content: Text('You got a new Rental Request!\n'
            'Offer Details: ${offer.vehicle.manufacturer},\n'
            'from ${offer.startDate.toLocalDate()} to ${offer.endDate.toLocalDate()}'),
        contentTextStyle: const TextStyle(color: Colors.white),
        actions: [
          TextButton(
            onPressed: () => {
              // TODO show rental request (rental accept/decline screen)
            },
            child: const Text(
              'Show',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
              onPressed:
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner,
              child: const Text(
                'Dismiss',
                style: TextStyle(color: Colors.white),
              ))
        ],
      );
}
