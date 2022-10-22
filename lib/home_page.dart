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
    40,
    61,
  ];

  void revealBoxNumbers(int index) {
    setState(() {
      squareStatus[index][1] = true;
    });
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
          i % numberInEachRow != 0 && i >= numberInEachRow) {
            numberOfBombAround++;
      }

      // check square to the top, unless it is in the first column or first row
      if (bombLocation.contains(i - numberInEachRow) && i >= numberInEachRow) {
        numberOfBombAround++;
      }

      // check square to the top right, unless it is in the first row or last colum
      if (bombLocation.contains(i + 1 - numberInEachRow) &&
          i % numberInEachRow != numberInEachRow -1 && i >= numberInEachRow) {
        numberOfBombAround++;
      }

      // check square to the right, unless it is in the last column
      if (bombLocation.contains(i + 1) && i % numberInEachRow != numberInEachRow -1) {
        numberOfBombAround++;
      }

      // check square to the bottom right, unless it is in the last colum or last row
      if (bombLocation.contains(i + 1 + numberInEachRow) &&
          i % numberInEachRow != numberInEachRow -1 && i < numberOfSquares - numberInEachRow) {
        numberOfBombAround++;
      }

      // check square to the bottom, unless it is in the last row
      if (bombLocation.contains(i + numberInEachRow) &&
         i < numberOfSquares - numberInEachRow) {
        numberOfBombAround++;
      }

      // check square to the bottom left, unless it is in the last colum or last row
      if (bombLocation.contains(i - 1 + numberInEachRow) &&
          i % numberInEachRow != 0 && i < numberOfSquares - numberInEachRow) {
        numberOfBombAround++;
      }

      // add total number of bombs around to squart status
      setState(() {
        squareStatus[i][0] = numberOfBombAround;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // initially, each square has 0 bombs around, and is not revealed
    for (int i = 0; i < numberOfSquares; i++) {
      squareStatus.add([0, false]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
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
                    children: const [
                      Text(
                        '6',
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
                        revealed: squareStatus[index][1],
                        function: () {
                          // player tapped the bomb, so player loses
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
      ),
    );
  }
}
