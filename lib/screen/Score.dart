import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:johari_window/screen/WelcomeScreen.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../ad_helper.dart';
import '/constants/style.dart';
import '/constants/lists.dart';
import '/widgets/utilts.dart';
import '/widgets/widget.dart';

class Score extends StatefulWidget {
  @override
  _ScoreState createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  final List<int> indexsF = <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int F = 0;
  int D = 0;
  late InterstitialAd _interstitialAd;
  bool interstited = false;
  @override
  void initState() {
    super.initState();
    calculateAndShowResult();
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
                    MaterialPageRoute(builder: (context) => Welcome()),
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
                    MaterialPageRoute(builder: (context) => Welcome()),
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
  Widget build(BuildContext context) {
    final Color myColor = black;
    final Color myColorAbout = primarySwatchLight;
    return WillPopScope(
      onWillPop: () =>
          onBackPressed(context, translator.translate("ُExitApp"), () {
        SystemNavigator.pop();
        exit(0);
      }) as Future<bool>,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              translator.translate('Explain'),
              style: TextStyle(color: myColorAbout),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Image.asset(
                            translator.currentLanguage == 'ar'
                                ? 'assets/images/info2.jpg'
                                : 'assets/images/background.jpg',
                            width: 200,
                            height: 230,
                          ),
                          actions: [
                            FlatButton(
                              child: Text(
                                translator.translate('OK'),
                                style: TextStyle(color: myColorAbout),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.priority_high,
                  size: 28,
                ),
              ),
            ],
          ),
          floatingActionButton: customTextBtn(
              translator.translate('StartAgain'), context, () async {
            if (interstited) {
              interstited = false;
              await _interstitialAd.show();
            }
          }),
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: myColor,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Stack(
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: indexsF.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == F) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      '$index',
                                      style: numberDraw,
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: VerticalDivider(
                                      thickness: 4,
                                      // width: 250,
                                      color: myColor,
                                    ),
                                  )),
                                ],
                              );
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '$index',
                                style: numberDraw,
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(10, (index) {
                              if ((index + 1) == D) {
                                return Center(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: Text(
                                          '${index + 1}',
                                          style: numberDraw,
                                        ),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Divider(
                                          color: myColor,
                                          thickness: 4,
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              }
                              return Text(
                                '${index + 1}',
                                style: numberDraw,
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              //End Result
            ],
          ),
        ),
      ),
    );
  }

  calculateAndShowResult() {
    List quizHome = translator.currentLanguage == 'ar' ? quizArabic : quiz;
    for (var item = 1; item <= quizHome.length; item++) {
      if (item == 1 || item == 5 || item == 7 || item == 9 || item == 12) {
        if (quizHome[item - 1]["ans"] == 1 || quizHome[item - 1]["ans"] == 2) {
          quizHome[item - 1]["score"] = 'F';
          F++;
        }
      } else if (item == 3 ||
          item == 4 ||
          item == 10 ||
          item == 17 ||
          item == 19) {
        if (quizHome[item - 1]["ans"] == -1 ||
            quizHome[item - 1]["ans"] == -2) {
          quizHome[item - 1]["score"] = 'F';
          F++;
        }
      } else if (item == 8 ||
          item == 11 ||
          item == 14 ||
          item == 16 ||
          item == 18) {
        if (quizHome[item - 1]["ans"] == 1 || quizHome[item - 1]["ans"] == 2) {
          quizHome[item - 1]["score"] = 'D';
          D++;
        }
      } else if (item == 2 ||
          item == 6 ||
          item == 13 ||
          item == 15 ||
          item == 20) {
        if (quizHome[item - 1]["ans"] == -1 ||
            quizHome[item - 1]["ans"] == -2) {
          quizHome[item - 1]["score"] = 'D';
          D++;
        }
      }
    }
    setState(() {
      print("F: " + F.toString());
      print("D: " + D.toString());
    });
  }
}
