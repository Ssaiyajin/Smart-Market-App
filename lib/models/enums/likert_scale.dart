import 'dart:ui';

import '../../style/branding_colors.dart';

enum LikertScale { veryBad, bad, medium, good, veryGood }

extension LikertScaleExtension on LikertScale {
  static final Map<LikertScale, Color> _colorsMap = {
    LikertScale.veryGood: BrandingColors.successColor,
    LikertScale.good: BrandingColors.lightGreen,
    LikertScale.medium: BrandingColors.lightYellow,
    LikertScale.bad: BrandingColors.lightRed,
    LikertScale.veryBad: BrandingColors.dangerColor,
  };

  Color? get color {
    return _colorsMap[this];
  }

  String get humanReadableString {
    switch (this) {
      case LikertScale.veryBad:
        return "Very Bad";

      case LikertScale.bad:
        return "Bad";

      case LikertScale.medium:
        return "Medium";

      case LikertScale.good:
        return "Good";

      case LikertScale.veryGood:
        return "Very Good";
    }
  }
}

LikertScale parseLikertScale(String toParse) {
  String value = toParse.toLowerCase();

  switch (value) {
    case 'verybad':
      return LikertScale.veryBad;
    case 'bad':
      return LikertScale.bad;
    case 'medium':
      return LikertScale.medium;
    case 'good':
      return LikertScale.good;
    case 'verygood':
      return LikertScale.veryGood;
    default:
      throw Exception('$toParse is not a valid LikertScale value');
  }
}