import 'package:flutter/material.dart';
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
  var squareStatus =[];

  // bomb locations
  final List<int> bombLocation = [
    4, 40, 61,
  ];

  @override
  void initState() {
    super.initState();

    // initially, each square has 0 bombs around, and is not revealed
    for (int i = 0; i<numberOfSquares; i++){
      squareStatus.add([0, false]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                    child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 40,
                    ),
                    color: Colors.grey.shade700,
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
                  return MyNumberBox(
                    child: index,
                  );
                },
              ),
            ),

            // branding
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text('Created by Fortuna'),
            )
          ],
        ),
      ),
    );
  }
}
