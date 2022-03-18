import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:johari_window/constants/style.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'WelcomeScreen.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool showSpinner = true;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        showSpinner = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: translator.translate('titleApp'),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: themeLight,
      home: Scaffold(
        body: SafeArea(
          child: Center(
              child: showSpinner == false
                  ? Welcome()
                  : const SpinKitFadingCircle(
                      color: black,
                      size: 120.0,
                    )),
        ),
      ),
      localizationsDelegates: translator.delegates,
      locale: translator.locale,
      supportedLocales: translator.locals(),
    );
  }
}
