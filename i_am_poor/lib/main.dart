import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('I Am Poor'),
          backgroundColor: Colors.white60,
        ),
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Text("house"),
        ),
      ),
    ),
  );
}
