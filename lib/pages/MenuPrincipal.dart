import "package:flutter/material.dart";

class MyHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _MyHomepage();
  }
}

class _MyHomepage extends State<MyHomePage>{
  //int currentPageIndex = 0;
  @override
  Widget build(BuildContext context){
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xFF1A1C60),
        appBar: AppBar(
          title: Text(
            "Smart Budget",
            style: TextStyle(color: Colors.white), // Text color is set to white
          ),
          backgroundColor: Color(0xFF1A1C60),
        ),
      body: Center(
        child: Text("Welcome to Smart Budget App"),
        ),
      )
    );
  }

}