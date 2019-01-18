import 'package:flutter/material.dart';
import 'package:solitaire_flutter/playing_card.dart';
import 'package:solitaire_flutter/transformed_card.dart';

typedef Null CardAcceptCallback(List<PlayingCard> card, int fromIndex);

class CardColumn extends StatefulWidget {
  final List<PlayingCard> cards;
  final CardAcceptCallback onCardsAdded;
  final int columnIndex;

  CardColumn(
      {@required this.cards,
      @required this.onCardsAdded,
      @required this.columnIndex});

  @override
  _CardColumnState createState() => _CardColumnState();
}

class _CardColumnState extends State<CardColumn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.topCenter,
      height: 13.0 * 15.0,
      width: 70.0,
      margin: EdgeInsets.all(2.0),
      child: DragTarget<Map>(
        builder: (context, listOne, listTwo) {
          return Stack(
            children: widget.cards.map((card) {
              int index = widget.cards.indexOf(card);
              return TransformedCard(
                playingCard: card,
                transformIndex: index,
                attachedCards: widget.cards.sublist(index, widget.cards.length),
                columnIndex: widget.columnIndex,
              );
            }).toList(),
          );
        },
        onWillAccept: (value) {
          // If empty, accept
          if (widget.cards.length == 0) {
            return true;
          }

          // Get dragged cards list
          List<PlayingCard> draggedCards = value["cards"];
          PlayingCard firstCard = draggedCards.first;
          if (firstCard.cardColor == CardColor.red) {
            if (widget.cards.last.cardColor == CardColor.red) {
              return false;
            }

            int lastColumnCardIndex = CardType.values.indexOf(widget.cards.last.cardType);
            int firstDraggedCardIndex = CardType.values.indexOf(firstCard.cardType);

            if(lastColumnCardIndex != firstDraggedCardIndex + 1) {
              return false;
            }

          } else {
            if (widget.cards.last.cardColor == CardColor.black) {
              return false;
            }

            int lastColumnCardIndex = CardType.values.indexOf(widget.cards.last.cardType);
            int firstDraggedCardIndex = CardType.values.indexOf(firstCard.cardType);

            if(lastColumnCardIndex != firstDraggedCardIndex + 1) {
              return false;
            }

          }
          return true;
        },
        onAccept: (value) {
          widget.onCardsAdded(
            value["cards"],
            value["fromIndex"],
          );
        },
      ),
    );
  }
}
