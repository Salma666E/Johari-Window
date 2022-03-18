import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:johari_window/widgets/utilts.dart';
import 'package:johari_window/widgets/widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../ad_helper.dart';
import 'Home.dart';

class Welcome extends StatefulWidget {
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late BannerAd _bannerAd2;
  bool isLoaded2 = false;
  late InterstitialAd _interstitialAd;
  bool interstited = false;
  @override
  void initState() {
    super.initState();
    _bannerAd2 = bannerCustom(AdManager.bannerAdUnitId2, (_) {
      setState(() {
        isLoaded2 = true;
      });
    });
    _bannerAd2.load();
    InterstitialAd.load(
        adUnitId: AdManager.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            setState(() {
              interstited = true;
              _interstitialAd = ad;
            });
            _interstitialAd.fullScreenContentCallback =
                FullScreenContentCallback(
              onAdShowedFullScreenContent: (InterstitialAd ad) =>
                  print('%ad onAdShowedFullScreenContent.'),
              onAdDismissedFullScreenContent: (InterstitialAd ad) {
                print('$ad onAdDismissedFullScreenContent.');
                ad.dispose();
                try {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                } catch (e) {
                  print('error: $e');
                }
              },
              onAdFailedToShowFullScreenContent:
                  (InterstitialAd ad, AdError error) {
                print('$ad onAdFailedToShowFullScreenContent: $error');
                ad.dispose();
                try {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                } catch (e) {
                  print('error: $e');
                }
              },
              onAdImpression: (InterstitialAd ad) =>
                  print('$ad impression occurred.'),
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  void dispose() {
    _bannerAd2.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          onBackPressed(context, translator.translate("ُExitApp"), () {
        SystemNavigator.pop();
        exit(0);
      }) as Future<bool>,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: isLoaded2
              ? Container(
                  height: 55.0,
                  color: Colors.grey[900],
                  child: checkForAd(isLoaded2, _bannerAd2, context),
                )
              : const SizedBox(
                  height: 55,
                ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 18.0, bottom: 8.0, right: 10.0, left: 32.0),
                  child: Text(
                    translator.translate('welcome'),
                    style: const TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(translator.translate('SetLanguage'),
                      style: const TextStyle(
                        color: Colors.black,
                      )),
                  trailing: DropdownButton(
                    onChanged: (value) {
                      translator.setNewLanguage(
                        context,
                        newLanguage:
                            value == 'ar' && translator.currentLanguage == 'ar'
                                ? 'ar'
                                : value == 'ar' &&
                                        translator.currentLanguage == 'en'
                                    ? 'ar'
                                    : 'en',
                        remember: true,
                        restart: true,
                      );
                    },
                    items: const [
                      DropdownMenuItem(child: Text('العربية'), value: 'ar'),
                      DropdownMenuItem(child: Text('English'), value: 'en'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
                width: double.infinity,
              ),
              ElevatedButton(
                child: Text(translator.translate('EnterTest')),
                onPressed: () async {
                  if (interstited) {
                    interstited = false;
                    await _interstitialAd.show();
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue[300]),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10.0)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 20))),
              ),
              const SizedBox(
                height: 30,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
