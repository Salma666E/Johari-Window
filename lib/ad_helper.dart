import 'dart:io';

class AdManager {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8554258589106363/9638897310';
    } else {
      return "Unsupported platform";
    }
  }

  static String get bannerAdUnitId2 {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8554258589106363/8377786532';
    } else {
      return "Unsupported platform";
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8554258589106363/9499296510';
    } else {
      return "Unsupported platform";
    }
  }
}
