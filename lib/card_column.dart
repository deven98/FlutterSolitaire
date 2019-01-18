import 'package:flutter/material.dart';
import 'package:solitaire_flutter/playing_card.dart';
import 'package:solitaire_flutter/transformed_card.dart';

typedef Null CardAcceptCallback(PlayingCard card, int fromIndex);

class CardColumn extends StatefulWidget {

  final List<PlayingCard> cards;
  final CardAcceptCallback onCardAdded;
  final int columnIndex;


  CardColumn({@required this.cards,@required this.onCardAdded,@required this.columnIndex});

  @override
  _CardColumnState createState() => _CardColumnState();
}

class _CardColumnState extends State<CardColumn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.0 * 15.0,
      width:  70.0,
      child: DragTarget(builder: (context, listOne, listTwo) {
        return Stack(
          children: widget.cards.map((card) {
            return TransformedCard(
              playingCard: card,
              transformIndex: widget.cards.indexOf(card),
            );
          }).toList(),
        );
      }),
    );
  }
}

