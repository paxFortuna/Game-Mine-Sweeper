import 'package:flutter/material.dart';
import 'package:game_mine_sweeper/bomb.dart';
import 'package:game_mine_sweeper/number_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variables
  int numberOfSquares = 9 * 9;
  int numberInEachRow = 9;

  // [number of bombs around, revealed=true/false]
  var squareStatus = [];

  // bomb locations
  final List<int> bombLocation = [
    4,
    5,
    6,
    41,
    42,
    43,
    61,
  ];

  bool bombsRevealed = false;

  @override
  void initState() {
    super.initState();

    // initially, each square has 0 bombs around, and is not revealed
    for (int i = 0; i < numberOfSquares; i++) {
      squareStatus.add([0, false]);
    }
  }

  void restartGame() {
    setState(() {
      bombsRevealed = false;
      for (int i = 0; i < numberOfSquares; i++) {
        squareStatus[i][1] = false;
      }
    });
  }

  void revealBoxNumbers(int index) {
    // reveal current box if it is a number : 1, 2, 3 etc
    if (squareStatus[index][0] != 0) {
      setState(() {
        squareStatus[index][1] = true;
      });
      // if current box is 0
    } else if (squareStatus[index][0] == 0) {
      // reveal current box, and the 8 surrounding boxes, unless you're on a wall
      setState(() {
        // reveal current box
        squareStatus[index][1] = true;

        //reveal left box (unless we are currently on the left wall)
        if (index % numberInEachRow != 0) {
          //if next box isn't revealed yet and it is a 0, then recurse
          if (squareStatus[index - 1][0] == 0 &&
              squareStatus[index - 1][1] == false) {
            revealBoxNumbers(index - 1);
          }
          // reveal left box
          squareStatus[index - 1][1] = true;
        }

        // reveal top left box (unless we are currently on the top row or left wall
        if (index % numberInEachRow != 0 && index >= numberInEachRow) {
          //if next box isn't revealed yet and is a 0, then recurse
          if (squareStatus[index - 1 - numberInEachRow][0] == 0 &&
              squareStatus[index - 1 - numberInEachRow][1] == false) {
            revealBoxNumbers(index - 1 - numberInEachRow);
          }

          squareStatus[index - 1 - numberInEachRow][1] = true;
        }

        // reveal top box (unless we are on the top row)
        if (index >= numberInEachRow) {
          // if next box is not revealed yet and is a 0, then recurse
          if (squareStatus[index - numberInEachRow][0] == 0 &&
              squareStatus[index - numberInEachRow][1] == false) {
            revealBoxNumbers(index - numberInEachRow);
          }

          squareStatus[index - numberInEachRow][1] = true;
        }

        // reveal top right box (unless we are currently on the top row or right wall
        if (index % numberInEachRow != numberInEachRow - 1 &&
            index >= numberInEachRow) {
          //if next box isn't revealed yet and is a 0, then recurse
          if (squareStatus[index + 1 - numberInEachRow][0] == 0 &&
              squareStatus[index + 1 - numberInEachRow][1] == false) {
            revealBoxNumbers(index + 1 - numberInEachRow);
          }

          squareStatus[index + 1 - numberInEachRow][1] = true;
        }

        // reveal right box (unless we are on the right wall)
        if (index % numberInEachRow != numberInEachRow - 1) {
          // if next box is not revealed yet and is a 0, then recurse
          if (squareStatus[index + 1][0] == 0 &&
              squareStatus[index + 1][1] == false) {
            revealBoxNumbers(index + 1);
          }
          squareStatus[index + 1][1] = true;
        }

        // reveal bottom right box (unless we are currently on the bottom row)
        if (index < numberOfSquares - numberInEachRow &&
            index % numberInEachRow != numberInEachRow - 1) {
          //if next box isn't revealed yet and is a 0, then recurse
          if (squareStatus[index + 1 + numberInEachRow][0] == 0 &&
              squareStatus[index + 1 + numberInEachRow][1] == false) {
            revealBoxNumbers(index + 1 + numberInEachRow);
          }

          squareStatus[index + 1 + numberInEachRow][1] = true;
        }

        // reveal bottom box (unless we are on the bottom row)
        if (index <= numberOfSquares - numberInEachRow) {
          // if next box is not revealed yet and is a 0, then recurse
          if (squareStatus[index + numberInEachRow][0] == 0 &&
              squareStatus[index + numberInEachRow][1] == false) {
            revealBoxNumbers(index + numberInEachRow);
          }
          squareStatus[index + numberInEachRow][1] = true;
        }

        // reveal bottom left box (unless we are currently on the bottom row or left wall
        if (index % numberInEachRow != 0 &&
            index < numberOfSquares - numberInEachRow) {
          //if next box isn't revealed yet and is a 0, then recurse
          if (squareStatus[index - 1 + numberInEachRow][0] == 0 &&
              squareStatus[index - 1 + numberInEachRow][1] == false) {
            revealBoxNumbers(index - 1 + numberInEachRow);
          }

          squareStatus[index - 1 + numberInEachRow][1] = true;
        }
      });
    }

    scanBombs();
  }

  void scanBombs() {
    for (int i = 0; i < numberOfSquares; i++) {
      // there are no bombs around initially
      int numberOfBombAround = 0;

      /*
      check each square to see if it has bombs surrounding it,
      there are 8 surrounding boxes to check
       */

      // check square to the left, unless it is in the first column
      if (bombLocation.contains(i - 1) && i % numberInEachRow != 0) {
        numberOfBombAround++;
      }

      // check square to the top left, unless it is in the first column or first row
      if (bombLocation.contains(i - 1 - numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i >= numberInEachRow) {
        numberOfBombAround++;
      }

      // check square to the top, unless it is in the first column or first row
      if (bombLocation.contains(i - numberInEachRow) && i >= numberInEachRow) {
        numberOfBombAround++;
      }

      // check square to the top right, unless it is in the first row or last colum
      if (bombLocation.contains(i + 1 - numberInEachRow) &&
          i % numberInEachRow != numberInEachRow - 1 &&
          i >= numberInEachRow) {
        numberOfBombAround++;
      }

      // check square to the right, unless it is in the last column
      if (bombLocation.contains(i + 1) &&
          i % numberInEachRow != numberInEachRow - 1) {
        numberOfBombAround++;
      }

      // check square to the bottom right, unless it is in the last colum or last row
      if (bombLocation.contains(i + 1 + numberInEachRow) &&
          i % numberInEachRow != numberInEachRow - 1 &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombAround++;
      }

      // check square to the bottom, unless it is in the last row
      if (bombLocation.contains(i + numberInEachRow) &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombAround++;
      }

      // check square to the bottom left, unless it is in the last colum or last row
      if (bombLocation.contains(i - 1 + numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombAround++;
      }

      // add total number of bombs around to squart status
      setState(() {
        squareStatus[i][0] = numberOfBombAround;
      });
    }
  }

  void playerLost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            title: Text(
              'YOU LOST',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: [
              MaterialButton(
                color: Colors.grey[100],
                onPressed: () {
                  restartGame();
                  Navigator.pop(context);
                },
                child: Icon(Icons.refresh),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // game stats and menu
          Container(
            height: 150,
            //  color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //display number of bombs
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bombLocation.length.toString(),
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      'B O M B',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                // button to refresh the game
                Card(
                  color: Colors.grey.shade700,
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('0', style: TextStyle(fontSize: 40)),
                    Text('T I M E', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),

          // grid
          Expanded(
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numberInEachRow,
                ),
                itemCount: numberOfSquares,
                itemBuilder: (context, index) {
                  if (bombLocation.contains(index)) {
                    return MyBomb(
                      // revealed: squareStatus[index][1],
                      revealed: bombsRevealed,
                      function: () {
                        // player tapped the bomb, so player loses
                        setState(() {
                          bombsRevealed = true;
                        });
                        playerLost();
                      },
                    );
                  } else {
                    return MyNumberBox(
                        // child: index % numberInEachRow,
                        child: squareStatus[index][0],
                        revealed: squareStatus[index][1],
                        function: () {
                          // reveal current box
                          revealBoxNumbers(index);
                        });
                  }
                }),
          ),

          // branding
          const Padding(
            padding: EdgeInsets.all(40.0),
            child: Text('Created by Fortuna'),
          )
        ],
      ),
    );
  }
}
