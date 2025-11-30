import 'package:smarket_app/extensions/enum_extension.dart';
import 'package:smarket_app/extensions/string_extension.dart';

enum BikeType { mountain, cargo, folding, city, road, bmx, tandem, kid, eBike }

extension BikeTypeExtension on BikeType {
  String get humanReadableString {
    return string.capitalize();
  }
}

BikeType parseBikeType(String toParse) {
  return BikeType.values.byName(toParse.toLowerCase());
}
