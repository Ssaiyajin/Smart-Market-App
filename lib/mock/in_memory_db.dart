import 'package:smarket_app/models/base/user.dart';
import 'package:smarket_app/models/vehicles/vehicle.dart';

import '../models/base/offer.dart';
import '../models/enums/bike_type.dart';
import '../models/enums/likert_scale.dart';
import '../models/vehicles/bike.dart';

// For dummy images, see https://picsum.photos/
class InMemoryDB {
  static final _dummyOffers = [
    Offer(
      '0',
      getVehicles().elementAt(2),
      getUsers().elementAt(0),
      'An der Weberei 5, 96049 Bamberg',
      DateTime.now(),
      DateTime.now().add(const Duration(days: 2)),
    ),
    Offer(
      '1',
      getVehicles().elementAt(1),
      getUsers().elementAt(1),
      'Street 1 96050 Bamberg',
      DateTime.now(),
      DateTime.now().add(const Duration(days: 5)),
    ),
    Offer(
      '2',
      getVehicles().elementAt(0),
      getUsers().elementAt(0),
      'Street 1 96052 Bamberg',
      DateTime.now(),
      DateTime.now().add(const Duration(days: 10)),
    ),
  ];

  static final List<User> _dummyUsers = [
    User(
      '62da5d2fa76390f33406524d',
      'Daniela',
      '+49123456789',
      'daniela.niklas@uni-bamberg.de',
      2,
      null,
      null,
      null,
      [getVehicles().elementAt(0), getVehicles().elementAt(2)],
    ),
    User(
      '62da5d2fa76390f33406524d',
      'Marcel',
      '+49123456789',
      'marcel.suenkel@uni-bamberg.de',
      2,
      null,
      null,
      null,
      [getVehicles().elementAt(1)],
    )
  ];

  static final List<Vehicle> _dummyVehicles = [
    Bike(
      '62de7bd117ee07047f901ad7',
      'Cube',
      'Awesome bike for daily commuting',
      LikertScale.veryGood,
      [
        'https://images.unsplash.com/photo-1485965120184-e220f721d03e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2970&q=80',
        'https://images.unsplash.com/photo-1505705694340-019e1e335916?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80',
        'https://images.unsplash.com/photo-1593764592116-bfb2a97c642a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2505&q=80',
      ],
      BikeType.mountain,
      23,
    ),
    Bike(
      '62de803b17ee07047f901b23',
      'Carqon',
      'Best for heavier transports',
      LikertScale.bad,
      [
        'https://images.unsplash.com/photo-1662368292391-b23ab70d49ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80',
        'https://images.unsplash.com/photo-1568090485827-6db6ed5c9d4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2970&q=80',
        'https://images.unsplash.com/photo-1556538628-451736d0e2c3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2176&q=80',
      ],
      BikeType.cargo,
      23,
    ),
    Bike(
      '62de992e197de429422de3be',
      'Focus',
      'A bit rusty... but it is battery powered',
      LikertScale.medium,
      [
        'https://picsum.photos/200?random=4',
        'https://picsum.photos/200?random=5',
        'https://picsum.photos/200?random=6',
      ],
      BikeType.eBike,
      23,
    )
  ];

  static List<Offer> getOffers() => _dummyOffers;

  static List<User> getUsers() => _dummyUsers;

  static List<Vehicle> getVehicles() => _dummyVehicles;
}
