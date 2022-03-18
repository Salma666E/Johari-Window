import 'package:flutter/material.dart';
import 'package:johari_window/constants/style.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:slimy_card/slimy_card.dart';

class MyCardAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card();
  }
}

class Card extends StatefulWidget {
  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: false,
      stream: slimyCard.stream,
      builder: ((BuildContext context, AsyncSnapshot snapshot) {
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: 100),
            SlimyCard(
              color:primarySwatchLight,
              topCardHeight: 290.0,
              bottomCardHeight: 300.0,
              topCardWidget: topCardWidget((snapshot.data)
                  ? 'assets/images/about1.png'
                  : 'assets/images/about2.png'),
              bottomCardWidget: bottomCardWidget(),
            ),
          ],
        );
      }),
    );
  }

  Widget topCardWidget(String imagePath) {
    return Column(
      children: [
        Stack(
          children: <Widget>[
            ListTile(
              trailing: const Icon(
                Icons.close,
                color: white,
                size: 28,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    height: 70,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage(imagePath), fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
         Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              translator.translate("about1"),
              style: const TextStyle(
                  color: white, fontSize: 13, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomCardWidget() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        translator.translate("about2")+'\n\n'+translator.translate("about2_1")+'\n\n'+translator.translate("about2_2")+'\n\n'+translator.translate("about2_3")+'\n\n'+translator.translate("about2_4"),
        style: const TextStyle(
          color: white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
