import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:johari_window/constants/style.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

bannerCustom(String id, handlerAdLoaded) {
  return BannerAd(
      adUnitId: id,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: handlerAdLoaded,
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ));
}

Future<dynamic>? onBackPressed(BuildContext ctx, String text, hundler) {
  Color? color =primarySwatchLight;
  return showDialog(
    context: ctx,
    builder: (context) => AlertDialog(
      title: Text(text),
      actions: [
        TextButton(
            child: Text(translator.translate("No"),
                style: TextStyle(color: color, fontWeight: FontWeight.w700)),
            onPressed: () => Navigator.pop(context, false)),
        TextButton(
            child: Text(translator.translate("Yes"),
                style: TextStyle(color: color, fontWeight: FontWeight.w700)),
            onPressed: hundler)
      ],
    ),
  );
}
