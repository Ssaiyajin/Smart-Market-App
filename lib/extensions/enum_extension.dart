import 'package:flutter/foundation.dart';

extension ParseToString on Enum {
  String get string {
    return describeEnum(this);
  }
}
