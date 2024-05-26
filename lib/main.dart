import 'package:flutter/material.dart';
import 'package:smart_budget_app/pages/navigator.dart';
void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Budget App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyNavigator(),
    );
  }
}