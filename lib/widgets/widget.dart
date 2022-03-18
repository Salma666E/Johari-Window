import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:johari_window/constants/style.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

Widget checkForAd(bool loaded, BannerAd _banner, ctx) {
  Color myColor =primarySwatchLight;
  if (loaded == true) {
    return Container(
      child: AdWidget(
        ad: _banner,
      ),
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
    );
  } else {
    return Center(
      child: ListTile(
        title: Text(
          translator.translate('LoadingAd'),
          style: TextStyle(color: myColor, fontSize: 20),
        ),
        trailing: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(myColor),
        ),
      ),
    );
  }
}

Widget customTextBtn(String txt, ctx, handler) {
  Color myColor =primarySwatchLight;
  return TextButton(
    child: Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(
        txt,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: myColor),
      ),
    ),
    onPressed: handler,
  );
}

Widget homeQ(String q, myColor) {
  return Expanded(
    flex: 2,
    child: SingleChildScrollView(
      child: Text(
        q,
        style: TextStyle(color: myColor, fontSize: 18),
      ),
    ),
  );
}
