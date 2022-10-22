import 'package:flutter/material.dart';

class MyNumberBox extends StatelessWidget {
  final child;
  const MyNumberBox({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        color: Colors.grey[400],
        child: Center(child: Text(child.toString())),
      ),
    );
  }
}
