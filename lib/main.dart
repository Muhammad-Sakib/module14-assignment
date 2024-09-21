import 'package:flutter/material.dart';
import 'package:module14_assignment/screens/product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD App',
      home: ProductScreen(),
    );
  }
}
