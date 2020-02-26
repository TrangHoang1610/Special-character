import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:special_character/constaints/constaints.dart';

var random = Random();

class AdmobAds {
  static createInterstitialAd(int persent, Function function) {
    var rd = random.nextInt(100);
    if (rd < persent) {
      InterstitialAd(
        adUnitId: ADMOB_INTERSTITIAL_ID,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.closed ||
              event == MobileAdEvent.failedToLoad) {
            function();
          }
        },
      )
        ..load()
        ..show();
    } else {
      function();
    }
  }
}
