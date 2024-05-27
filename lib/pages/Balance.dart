import "package:flutter/material.dart";

class Balance extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _Balance();
  }
}

class _Balance extends State<Balance>{
  @override
  Widget build(BuildContext context){
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xFF1A1C60),
        appBar: AppBar(
          title: Text(
            "Balance",
            style: TextStyle(color: Colors.white), // Text color is set to white
          ),
          backgroundColor: Color(0xFF1A1C60),
        ),
      body: Center(
        child: Text("Balance"),
      ),
    ));
  }

}