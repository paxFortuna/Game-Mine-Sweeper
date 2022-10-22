import 'package:flutter/material.dart';

class MyNumberBox extends StatelessWidget {
  final child;
  bool revealed;
  final function;

  MyNumberBox({Key? key, this.child, required this.revealed, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
        onTap: function,
        child: Container(
          color: revealed ? Colors.grey[300] : Colors.grey[400],
          child: Center(child: Text(child.toString())),
        ),
      ),
    );
  }
}
