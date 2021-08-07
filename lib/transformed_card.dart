import 'package:flutter/material.dart';
import 'package:solitaire_flutter/card_column.dart';
import 'package:solitaire_flutter/playing_card.dart';

typedef Null CardDoubleTapCallback(PlayingCard cardClicked);

// TransformedCard makes the card draggable and translates it according to
// position in the stack.
class TransformedCard extends StatefulWidget {
  final PlayingCard playingCard;
  final double transformDistance;
  final int transformIndex;
  final int? columnIndex;
  final List<PlayingCard> attachedCards;
  final CardDoubleTapCallback? onCardDoubleTap;

  TransformedCard({
    required this.playingCard,
    this.transformDistance = 18.0,
    this.transformIndex = 0,
    this.columnIndex,
    required this.attachedCards,
    this.onCardDoubleTap,
  });

  @override
  _TransformedCardState createState() => _TransformedCardState();
}

class _TransformedCardState extends State<TransformedCard> {
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          0.0,
          widget.transformIndex * widget.transformDistance,
          0.0,
        ),
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
        : GestureDetector(
            onDoubleTap: () {
              if (widget.onCardDoubleTap != null) {
                widget.onCardDoubleTap!(widget.playingCard);
              }
            },
            child: Draggable<Map>(
              child: _buildFaceUpCard(),
              feedback: CardColumn(
                cards: widget.attachedCards,
                columnIndex: 1,
                onCardsAdded: (card, position) {},
                onCardDoubleTap: (cardClicked) {},
              ),
              childWhenDragging: _buildFaceUpCard(),
              data: {
                "cards": widget.attachedCards,
                "fromIndex": widget.columnIndex,
              },
            ),
          );
  }

  Widget _buildFaceUpCard() {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        height: 60.0,
        width: 40,
        child: Stack(
          children: <Widget>[
            Center(
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
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _cardTypeToString(),
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 0, 0, 0),
                    child: Container(
                      height: 12.0,
                      child: _suitToImage(),
                    ),
                  )
                ],
              ),
            ),
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
      default:
        return "K";
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
      default:
        return Image.asset('images/spades.png');
    }
  }
}
