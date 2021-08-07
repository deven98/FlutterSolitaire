import 'dart:math';

import 'package:flutter/material.dart';

import 'card_column.dart';
import 'empty_card.dart';
import 'playing_card.dart';
import 'transformed_card.dart';

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
  void initState() {
    super.initState();
    _initialiseGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text("Flutter Solitaire"),
        elevation: 0.0,
        backgroundColor: Colors.green,
        actions: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
            splashColor: Colors.white,
            onTap: () {
              _handleStartNewGame();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildCardDeck(),
                _buildFinalDecks(),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: CardColumn(
                    cards: cardColumn1,
                    onCardsAdded: (cards, index) {
                      setState(() {
                        cardColumn1.addAll(cards);
                        int length = _getListFromIndex(index).length;
                        _getListFromIndex(index)
                            .removeRange(length - cards.length, length);
                        _refreshList(index);
                      });
                    },
                    onCardDoubleTap: (cardClicked) {
                      _onCardDoubleTap(cardClicked, 1);
                    },
                    columnIndex: 1,
                  ),
                ),
                Expanded(
                  child: CardColumn(
                    cards: cardColumn2,
                    onCardsAdded: (cards, index) {
                      setState(() {
                        cardColumn2.addAll(cards);
                        int length = _getListFromIndex(index).length;
                        _getListFromIndex(index)
                            .removeRange(length - cards.length, length);
                        _refreshList(index);
                      });
                    },
                    onCardDoubleTap: (cardClicked) {
                      _onCardDoubleTap(cardClicked, 2);
                    },
                    columnIndex: 2,
                  ),
                ),
                Expanded(
                  child: CardColumn(
                    cards: cardColumn3,
                    onCardsAdded: (cards, index) {
                      setState(() {
                        cardColumn3.addAll(cards);
                        int length = _getListFromIndex(index).length;
                        _getListFromIndex(index)
                            .removeRange(length - cards.length, length);
                        _refreshList(index);
                      });
                    },
                    onCardDoubleTap: (cardClicked) {
                      _onCardDoubleTap(cardClicked, 3);
                    },
                    columnIndex: 3,
                  ),
                ),
                Expanded(
                  child: CardColumn(
                    cards: cardColumn4,
                    onCardsAdded: (cards, index) {
                      setState(() {
                        cardColumn4.addAll(cards);
                        int length = _getListFromIndex(index).length;
                        _getListFromIndex(index)
                            .removeRange(length - cards.length, length);
                        _refreshList(index);
                      });
                    },
                    onCardDoubleTap: (cardClicked) {
                      _onCardDoubleTap(cardClicked, 4);
                    },
                    columnIndex: 4,
                  ),
                ),
                Expanded(
                  child: CardColumn(
                    cards: cardColumn5,
                    onCardsAdded: (cards, index) {
                      setState(() {
                        cardColumn5.addAll(cards);
                        int length = _getListFromIndex(index).length;
                        _getListFromIndex(index)
                            .removeRange(length - cards.length, length);
                        _refreshList(index);
                      });
                    },
                    onCardDoubleTap: (cardClicked) {
                      _onCardDoubleTap(cardClicked, 5);
                    },
                    columnIndex: 5,
                  ),
                ),
                Expanded(
                  child: CardColumn(
                    cards: cardColumn6,
                    onCardsAdded: (cards, index) {
                      setState(() {
                        cardColumn6.addAll(cards);
                        int length = _getListFromIndex(index).length;
                        _getListFromIndex(index)
                            .removeRange(length - cards.length, length);
                        _refreshList(index);
                      });
                    },
                    onCardDoubleTap: (cardClicked) {
                      _onCardDoubleTap(cardClicked, 6);
                    },
                    columnIndex: 6,
                  ),
                ),
                Expanded(
                  child: CardColumn(
                    cards: cardColumn7,
                    onCardsAdded: (cards, index) {
                      setState(() {
                        cardColumn7.addAll(cards);
                        int length = _getListFromIndex(index).length;
                        _getListFromIndex(index)
                            .removeRange(length - cards.length, length);
                        _refreshList(index);
                      });
                    },
                    onCardDoubleTap: (cardClicked) {
                      _onCardDoubleTap(cardClicked, 7);
                    },
                    columnIndex: 7,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the deck of cards left after building card columns
  Widget _buildCardDeck() {
    return Container(
      child: Row(
        children: <Widget>[
          InkWell(
            child: cardDeckClosed.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TransformedCard(
                      playingCard: cardDeckClosed.last,
                      attachedCards: [],
                    ),
                  )
                : Opacity(
                    opacity: 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TransformedCard(
                        playingCard: PlayingCard(
                          cardSuit: CardSuit.diamonds,
                          cardType: CardType.five,
                        ),
                        attachedCards: [],
                      ),
                    ),
                  ),
            onTap: () {
              setState(() {
                if (cardDeckClosed.isEmpty) {
                  cardDeckClosed.addAll(cardDeckOpened.map((card) {
                    return card
                      ..opened = false
                      ..faceUp = false;
                  }));
                  cardDeckOpened.clear();
                } else {
                  cardDeckOpened.add(
                    cardDeckClosed.removeLast()
                      ..faceUp = true
                      ..opened = true,
                  );
                }
              });
            },
          ),
          cardDeckOpened.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TransformedCard(
                    playingCard: cardDeckOpened.last,
                    attachedCards: [
                      cardDeckOpened.last,
                    ],
                    columnIndex: 0,
                    onCardDoubleTap: (cardClicked) {
                      _onCardDoubleTap(cardClicked, 0);
                    },
                  ),
                )
              : Opacity(
                  opacity: 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      height: 60.0,
                      width: 40.0,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  // Build the final decks of cards
  Widget _buildFinalDecks() {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: EmptyCardDeck(
              cardSuit: CardSuit.hearts,
              cardsAdded: finalHeartsDeck,
              onCardAdded: (cards, index) {
                finalHeartsDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);
              },
              columnIndex: 8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: EmptyCardDeck(
              cardSuit: CardSuit.diamonds,
              cardsAdded: finalDiamondsDeck,
              onCardAdded: (cards, index) {
                finalDiamondsDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);
              },
              columnIndex: 9,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: EmptyCardDeck(
              cardSuit: CardSuit.spades,
              cardsAdded: finalSpadesDeck,
              onCardAdded: (cards, index) {
                finalSpadesDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);
              },
              columnIndex: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: EmptyCardDeck(
              cardSuit: CardSuit.clubs,
              cardsAdded: finalClubsDeck,
              onCardAdded: (cards, index) {
                finalClubsDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);
              },
              columnIndex: 11,
            ),
          ),
        ],
      ),
    );
  }

  // Initialise a new game
  void _initialiseGame() {
    cardColumn1 = [];
    cardColumn2 = [];
    cardColumn3 = [];
    cardColumn4 = [];
    cardColumn5 = [];
    cardColumn6 = [];
    cardColumn7 = [];

    // Stores the card deck
    cardDeckClosed = [];
    cardDeckOpened = [];

    // Stores the card in the upper boxes
    finalHeartsDeck = [];
    finalDiamondsDeck = [];
    finalSpadesDeck = [];
    finalClubsDeck = [];

    List<PlayingCard> allCards = [];

    // Add all cards to deck
    CardSuit.values.forEach((suit) {
      CardType.values.forEach((type) {
        allCards.add(PlayingCard(
          cardType: type,
          cardSuit: suit,
          faceUp: false,
        ));
      });
    });

    Random random = Random();

    // Shuffle cards randomly
    for (int i = 0; i < 20000; i++) {
      int randomNumber = random.nextInt(allCards.length);
      PlayingCard card = allCards.removeAt(randomNumber);
      allCards.add(card);
    }

    // Add cards to columns and remaining to deck
    for (int i = 0; i < 28; i++) {
      int randomNumber = random.nextInt(allCards.length);
      PlayingCard card = allCards.removeAt(randomNumber);

      if (i == 0) {
        cardColumn1.add(
          card
            ..opened = true
            ..faceUp = true,
        );
      } else if (i > 0 && i < 3) {
        if (i == 2) {
          cardColumn2.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn2.add(card);
        }
      } else if (i > 2 && i < 6) {
        if (i == 5) {
          cardColumn3.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn3.add(card);
        }
      } else if (i > 5 && i < 10) {
        if (i == 9) {
          cardColumn4.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn4.add(card);
        }
      } else if (i > 9 && i < 15) {
        if (i == 14) {
          cardColumn5.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn5.add(card);
        }
      } else if (i > 14 && i < 21) {
        if (i == 20) {
          cardColumn6.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn6.add(card);
        }
      } else {
        if (i == 27) {
          cardColumn7.add(
            card
              ..opened = true
              ..faceUp = true,
          );
        } else {
          cardColumn7.add(card);
        }
      }
    }

    cardDeckClosed = allCards;
    cardDeckOpened.add(
      cardDeckClosed.removeLast()
        ..opened = true
        ..faceUp = true,
    );

    setState(() {});
  }

  void _refreshList(int index) {
    if (finalDiamondsDeck.length +
            finalHeartsDeck.length +
            finalClubsDeck.length +
            finalSpadesDeck.length ==
        52) {
      _handleGameWin();
    }
    setState(() {
      if (_getListFromIndex(index).length != 0) {
        _getListFromIndex(index)[_getListFromIndex(index).length - 1]
          ..opened = true
          ..faceUp = true;
      }
    });
  }

  // Handle a start new game condition
  void _handleStartNewGame() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Start new game?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _initialiseGame();
                Navigator.pop(context);
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  // Handle a win condition
  void _handleGameWin() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Congratulations!"),
          content: Text("You Win!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _initialiseGame();
                Navigator.pop(context);
              },
              child: Text("Play again"),
            ),
          ],
        );
      },
    );
  }

  List<PlayingCard> _getListFromIndex(int index) {
    switch (index) {
      case 0:
        return cardDeckOpened;
      case 1:
        return cardColumn1;
      case 2:
        return cardColumn2;
      case 3:
        return cardColumn3;
      case 4:
        return cardColumn4;
      case 5:
        return cardColumn5;
      case 6:
        return cardColumn6;
      case 7:
        return cardColumn7;
      case 8:
        return finalHeartsDeck;
      case 9:
        return finalDiamondsDeck;
      case 10:
        return finalSpadesDeck;
      default:
        return finalClubsDeck;
    }
  }

  void _onCardDoubleTap(PlayingCard cardClicked, int index) {
    List<PlayingCard> finalDeck;
    switch (cardClicked.cardSuit) {
      case CardSuit.hearts:
        finalDeck = finalHeartsDeck;
        break;
      case CardSuit.diamonds:
        finalDeck = finalDiamondsDeck;
        break;
      case CardSuit.spades:
        finalDeck = finalSpadesDeck;
        break;
      default:
        finalDeck = finalClubsDeck;
        break;
    }

    if (CardType.values.indexOf(cardClicked.cardType) == finalDeck.length &&
        cardClicked.faceUp && cardClicked.opened) {
      finalDeck.add(cardClicked);
      int length = _getListFromIndex(index).length;
      _getListFromIndex(index).removeRange(length - 1, length);
      _refreshList(index);
    }
  }
}
