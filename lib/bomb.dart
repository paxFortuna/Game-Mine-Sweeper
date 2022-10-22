import 'package:flutter/material.dart';

class MyBomb extends StatelessWidget {
  final child;
  bool revealed;
  final function;

  MyBomb({Key? key, this.child, required this.revealed, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        color: Colors.grey[800],
        child: Center(child: Text(child.toString())),
      ),
    );
  }
}
