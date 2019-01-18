import 'package:flutter/material.dart';

enum EmptyCardSuit {
  spades,
  hearts,
  diamonds,
  clubs,
}

class EmptyCard extends StatefulWidget {
  final EmptyCardSuit cardSuit;

  EmptyCard({
    @required this.cardSuit,
  });

  @override
  _EmptyCardState createState() => _EmptyCardState();
}

class _EmptyCardState extends State<EmptyCard> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        height: 60.0,
        width: 40,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: Container(
                  height: 20.0,
                  child: _suitToImage(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Image _suitToImage() {
    switch (widget.cardSuit) {
      case EmptyCardSuit.hearts:
        return Image.asset('images/hearts.png');
      case EmptyCardSuit.diamonds:
        return Image.asset('images/diamonds.png');
      case EmptyCardSuit.clubs:
        return Image.asset('images/clubs.png');
      case EmptyCardSuit.spades:
        return Image.asset('images/spades.png');
      default:
        return null;
    }
  }
}
