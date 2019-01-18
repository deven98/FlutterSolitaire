import 'package:flutter/material.dart';
import 'package:solitaire_flutter/playing_card.dart';
import 'package:solitaire_flutter/transformed_card.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Stores the cards on the seven columns
  List<PlayingCard> cardColumn1 = [];
  List<PlayingCard> cardColumn2 = [];
  List<PlayingCard> cardColumn3 = [];
  List<PlayingCard> cardColumn4 = [];
  List<PlayingCard> cardColumn5 = [];
  List<PlayingCard> cardColumn6 = [];
  List<PlayingCard> cardColumn7 = [];

  // Stores the card deck
  List<PlayingCard> cardDeckClosed = [];
  List<PlayingCard> cardDeckOpened = [];

  // Stores the card in the upper boxes
  List<PlayingCard> finalHeartsDeck = [];
  List<PlayingCard> finalDiamondsDeck = [];
  List<PlayingCard> finalSpadesDeck = [];
  List<PlayingCard> finalClubsDeck = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Solitaire"),
        elevation: 0.0,
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: TransformedCard(
          playingCard: PlayingCard(
            cardSuit: CardSuit.hearts,
            cardType: CardType.seven,
            faceUp: true,
          ),
        ),
      ),
    );
  }
}
