import 'package:flutter/material.dart';

class MyBomb extends StatelessWidget {
  // final child;
  bool revealed;
  final function;

  MyBomb({Key? key, required this.revealed, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: revealed ? Colors.grey[800] : Colors.grey[400],
        ),
      ),
    );
  }
}
