import 'dart:math';

import 'package:flutter/material.dart';

import 'playing_card.dart';
import 'transformed_card.dart';

typedef Null CardAcceptCallback(List<PlayingCard> card, int fromIndex);
typedef Null CardDoubleTapCallback(PlayingCard cardClicked);

// This is a stack of overlayed cards (implemented using a stack)
class CardColumn extends StatefulWidget {

  // List of cards in the stack
  final List<PlayingCard> cards;

  // Callback when card is added to the stack
  final CardAcceptCallback onCardsAdded;

  final CardDoubleTapCallback onCardDoubleTap;

  // The index of the list in the game
  final int columnIndex;

  CardColumn({
    required this.cards,
    required this.onCardsAdded,
    required this.onCardDoubleTap,
    required this.columnIndex,
  });

  @override
  _CardColumnState createState() => _CardColumnState();
}

class _CardColumnState extends State<CardColumn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80 + (18.0 * max(widget.cards.length - 1, 7)),
      width: 40.0,
      margin: EdgeInsets.all(4.0),
      child: DragTarget<Map>(
        builder: (context, listOne, listTwo) {
          return Stack(
            alignment: Alignment.topCenter,
            children: widget.cards.map<Widget>((card) {
              int index = widget.cards.indexOf(card);
              return TransformedCard(
                playingCard: card,
                transformIndex: index,
                attachedCards: widget.cards.sublist(index, widget.cards.length),
                columnIndex: widget.columnIndex,
                onCardDoubleTap: widget.onCardDoubleTap,
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
          List<PlayingCard> draggedCards = value!["cards"];
          PlayingCard firstCard = draggedCards.first;
          if (firstCard.cardColor == CardColor.red) {
            if (widget.cards.last.cardColor == CardColor.red) {
              return false;
            }

            int lastColumnCardIndex =
                CardType.values.indexOf(widget.cards.last.cardType);
            int firstDraggedCardIndex =
                CardType.values.indexOf(firstCard.cardType);

            if (lastColumnCardIndex != firstDraggedCardIndex + 1) {
              return false;
            }
          } else {
            if (widget.cards.last.cardColor == CardColor.black) {
              return false;
            }

            int lastColumnCardIndex =
                CardType.values.indexOf(widget.cards.last.cardType);
            int firstDraggedCardIndex =
                CardType.values.indexOf(firstCard.cardType);

            if (lastColumnCardIndex != firstDraggedCardIndex + 1) {
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
