import 'package:flutter/material.dart';
import 'package:solitaire_flutter/playing_card.dart';

class TransformedCard extends StatefulWidget {
  final PlayingCard playingCard;
  final double transformDistance;
  final int transformIndex;

  TransformedCard(
      {@required this.playingCard,
      this.transformDistance = 15.0,
      this.transformIndex = 0});

  @override
  _TransformedCardState createState() => _TransformedCardState();
}

class _TransformedCardState extends State<TransformedCard> {
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(0.0, widget.transformIndex * widget.transformDistance, 0.0),
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    return !widget.playingCard.faceUp
        ? Container(
            height: 60.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              border: Border.all(color: Colors.black),
            ),
            height: 60.0,
            width: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: Text(
                      _cardTypeToString(),
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    height: 20.0,
                    child: _suitToImage(),
                  )
                ],
              ),
            ),
          );
  }

  String _cardTypeToString() {
    switch (widget.playingCard.cardType) {
      case CardType.one:
        return "1";
      case CardType.two:
        return "2";
      case CardType.three:
        return "3";
      case CardType.four:
        return "4";
      case CardType.five:
        return "5";
      case CardType.six:
        return "6";
      case CardType.seven:
        return "7";
      case CardType.eight:
        return "8";
      case CardType.nine:
        return "9";
      case CardType.ten:
        return "10";
      case CardType.jack:
        return "J";
      case CardType.queen:
        return "Q";
      case CardType.king:
        return "K";
      default:
        return "";
    }
  }

  Image _suitToImage() {
    switch (widget.playingCard.cardSuit) {
      case CardSuit.hearts:
        return Image.asset('images/hearts.png');
      case CardSuit.diamonds:
        return Image.asset('images/diamonds.png');
      case CardSuit.clubs:
        return Image.asset('images/clubs.png');
      case CardSuit.spades:
        return Image.asset('images/spades.png');
      default:
        return null;
    }
  }

}
