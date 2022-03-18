import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:johari_window/constants/style.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '/constants/lists.dart';
import '/widgets/utilts.dart';
import '/widgets/widget.dart';
import '../ad_helper.dart';
import 'Score.dart';
import 'about_custom.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Timer _timerForAd, _timerForAd2;
  int i = 0;
  List enter = [false, false, false, false, false];
  int selectNum = 5;
  late BannerAd _bannerAd;
  bool isLoaded = false;
  late BannerAd _bannerAd2;
  bool isLoaded2 = false;
  late InterstitialAd _interstitialAd;
  bool interstited = false;
  late TextStyle prevAns;
  late Color myColor;
  late Color myColorInt;
  List quizHome = translator.currentLanguage == 'ar' ? quizArabic : quiz;
  @override
  void initState() {
    super.initState();
    _bannerAd = bannerCustom(AdManager.bannerAdUnitId, (_) {
      setState(() {
        isLoaded = true;
      });
    });
    _bannerAd.load();

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
                    MaterialPageRoute(builder: (context) => Score()),
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
                    MaterialPageRoute(builder: (context) => Score()),
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
    _bannerAd2 = bannerCustom(AdManager.bannerAdUnitId2, (_) {
      setState(() {
        isLoaded2 = true;
      });
    });
    _bannerAd2.load();
    // Add these lines to launch timer on start of the app
    _timerForAd = Timer.periodic(const Duration(seconds: 20), (result) {
      setState(() {
        isLoaded = false;
      });
      _bannerAd = bannerCustom(AdManager.bannerAdUnitId, (_) {
        setState(() {
          isLoaded = true;
        });
      });
      _bannerAd.load();
    });
    // Add these lines to launch timer on start of the app
    _timerForAd2 = Timer.periodic(const Duration(seconds: 20), (result) {
      setState(() {
        isLoaded2 = false;
      });
      _bannerAd2 = bannerCustom(AdManager.bannerAdUnitId2, (_) {
        setState(() {
          isLoaded2 = true;
        });
      });
      _bannerAd2.load();
    });
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _bannerAd2.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myColor = black;
    myColorInt = primarySwatchLight;
    prevAns =
        TextStyle(color: myColorInt, fontSize: 15, fontWeight: FontWeight.w900);
    Widget inWell(String txt, int _num, handler) => InkWell(
          onTap: handler,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              txt,
              style: selectNum == _num ? selectedAns : prevAns,
            ),
          ),
        );
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: isLoaded
            ? Container(
                height: 55.0,
                color: Colors.grey[900],
                child: checkForAd(isLoaded, _bannerAd, context),
              )
            : const SizedBox(
                height: 55,
              ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(translator.translate('Johari_win') + '${i + 1}'),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => Material(
                      type: MaterialType.transparency,
                      child: MyCardAbout(),
                    ),
                  );
                },
                icon: const Icon(Icons.info_outline)),
          ],
        ),
        body: WillPopScope(
          onWillPop: () =>
              onBackPressed(context, translator.translate("ُExitApp"), () {
            SystemNavigator.pop();
            exit(0);
          }) as Future<bool>,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 15.0, right: 5.0),
            child: quizHome.isNotEmpty
                ? Column(
                    children: [
                      isLoaded2
                          ? Container(
                              height: 55.0,
                              color: Colors.grey[900],
                              child: checkForAd(isLoaded2, _bannerAd2, context),
                            )
                          : const SizedBox(
                              height: 55,
                            ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            homeQ(quizHome[i]["ansLeft"].toString(), myColor),
                            Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    inWell(translator.translate("2"), 2, () {
                                      quizHome[i]["ans"] = 2;
                                      setState(() {
                                        selectNum = 2;
                                      });
                                    }),
                                    inWell(translator.translate("1"), 1, () {
                                      quizHome[i]["ans"] = 1;
                                      setState(() {
                                        selectNum = 1;
                                      });
                                    }),
                                    inWell(translator.translate("0"), 0, () {
                                      quizHome[i]["ans"] = 0;
                                      setState(() {
                                        selectNum = 0;
                                      });
                                    }),
                                    inWell(translator.translate("1Salep"), -1,
                                        () {
                                      quizHome[i]["ans"] = -1;
                                      setState(() {
                                        selectNum = -1;
                                      });
                                    }),
                                    inWell(translator.translate("2Salep"), -2,
                                        () {
                                      quizHome[i]["ans"] = -2;
                                      setState(() {
                                        selectNum = -2;
                                      });
                                    }),
                                  ],
                                )),
                            homeQ(quizHome[i]["ansRight"].toString(), myColor),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (i > 0)
                              FloatingActionButton(
                                child: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  setState(() {
                                    i--;
                                    selectNum = 5;
                                  });
                                },
                              ),
                            const Spacer(),
                            if (i == 19)
                              customTextBtn(
                                  translator.translate('Result'), context,
                                  () async {
                                if (interstited) {
                                  interstited = false;
                                  await _interstitialAd.show();
                                }
                              }),
                            if (i < 19)
                              FloatingActionButton(
                                child: const Icon(Icons.arrow_forward),
                                onPressed: () {
                                  setState(() {
                                    i++;
                                    selectNum = 5;
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: translator.translate('Loading'),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
