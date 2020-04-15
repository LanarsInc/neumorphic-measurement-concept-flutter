import 'dart:io' as dart;

import 'package:flutter/foundation.dart';

class Platform {
  static bool get isWeb => kIsWeb;

  static bool get isAndroid => isWeb ? false : dart.Platform.isAndroid;

  static bool get isIOS => isWeb ? false : dart.Platform.isIOS;

  static bool get isMobile => isAndroid || isIOS;
}