import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variables
  int numberOfSquares = 9 * 9;
  int numberInEachRow = 9;

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
              color: Colors.grey,
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
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      color: Colors.blue,
                    ),
                  );
                },
              ),
            ),

            // branding
          ],
        ),
      ),
    );
  }
}
