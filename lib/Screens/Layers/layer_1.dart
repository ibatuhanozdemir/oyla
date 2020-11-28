import 'package:flutter/material.dart';

class Layer1 extends StatefulWidget {
  @override
  _Layer1State createState() => _Layer1State();
}

class _Layer1State extends State<Layer1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(),
    ));
  }
}
