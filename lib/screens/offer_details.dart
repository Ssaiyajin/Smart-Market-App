import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smarket_app/extensions/date_time_extension.dart';
import 'package:smarket_app/mock/in_memory_db.dart';
import 'package:smarket_app/services/offer_service.dart';
import 'package:smarket_app/services/rental_service.dart';
import 'package:smarket_app/widgets/cancel_button.dart';
import 'package:smarket_app/widgets/cards/column_card.dart';
import 'package:smarket_app/widgets/cards/row_card.dart';
import 'package:smarket_app/widgets/chips/likert_scale_chip.dart';
import 'package:smarket_app/widgets/image_carousel.dart';
import 'package:smarket_app/widgets/page_title_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/base/offer.dart';
import '../models/base/rental.dart';
import '../models/base/user.dart';
import '../models/vehicles/bike.dart';
import '../style/branding_colors.dart';
import '../widgets/chips/bike_type_chip.dart';

class OfferDetailsPage extends StatefulWidget {
  final String offerId;

  const OfferDetailsPage({Key? key, required this.offerId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
  late final Future<Offer> offerFuture;
  late Offer offer;
  late final Bike? bike =
      offer.vehicle.runtimeType == Bike ? offer.vehicle as Bike : null;
  final User _currentUser =
      InMemoryDB.getUsers().elementAt(0); // TODO: replace with correct user

  @override
  void initState() {
    offerFuture = OfferService.getOfferById(widget.offerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Offer>(
      future: offerFuture,
      builder: (BuildContext context, AsyncSnapshot<Offer> snapshot) {
        if (snapshot.hasData) {
          offer = snapshot.data!;

          return Scaffold(
            body: PageTitleWrapper(
              title: "Offer Details",
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          offer.vehicle.manufacturer,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(width: 18),
                        BikeTypeChip(type: bike!.type!)
                      ],
                    ),
                    const SizedBox(height: 16),
                    // TODO: use vehicle images from DB
                    ImageCarousel(
                        imageUrls: InMemoryDB.getVehicles()[1].imageUrls),
                    const SizedBox(height: 8),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            child: ColumnCard(
                              start: Text(
                                "Condition",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              end: LikertScaleChip(
                                value: bike!.condition,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final Uri url = Platform.isIOS
                                    ? Uri.parse(Uri.encodeFull(
                                        'http://maps.apple.com/?q=${offer.location}'))
                                    : Uri.parse(Uri.encodeFull(
                                        'http://maps.google.com/?q=${offer.location}'));
                                if (!await launchUrl(url)) {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: RowCard(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                end: Container(
                                  alignment: Alignment.centerLeft,
                                  constraints: BoxConstraints.loose(
                                      const Size.fromWidth(80)),
                                  child: Text(
                                    offer.location!,
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                start: Icon(
                                  Icons.map_outlined,
                                  color: Theme.of(context).primaryColor,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ColumnCard(
                      start: Text(
                        "What the lender says about their bike",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      end: Text(offer.vehicle.description),
                    ),
                    const SizedBox(height: 8),
                    RowCard(
                      start: Text(
                        "Start of availability",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      end: Text(
                        offer.startDate.toLocalDate(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    RowCard(
                      start: Text(
                        "End of availability",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      end: Text(
                        offer.endDate.toLocalDate(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: BrandingColors.primaryColor,
                        minimumSize: const Size.fromHeight(40),
                      ),
                      onPressed: () async {
                        Rental rental = await RentalService.createRentalRequest(
                          offerId: offer.id!,
                          borrowerId: _currentUser.id,
                          startDate: offer.startDate,
                          endDate: offer.endDate,
                        );

                        // show snack bar and return to home screen
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text('Rental requested!'),
                          ),
                        );
                        Navigator.of(context).pop(rental);
                      },
                      child: const Text('Request Rental'),
                    ),
                    const CancelButton(label: 'Back'),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return noItemWidget();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget noItemWidget() => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('Offer not available 😞'),
                SizedBox(height: 16),
                CancelButton(label: 'Back')
              ],
            ),
          ),
        ),
      );
}
