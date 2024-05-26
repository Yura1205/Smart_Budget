import "package:flutter/material.dart";

class Movimientos extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _Movimientos();
  }
}

class _Movimientos extends State<Movimientos>{
  @override
  Widget build(BuildContext context){
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xFF1A1C60),
      appBar: AppBar(
        title: Text("Movimientos"),
      ),
      body: Center(
        child: Text("Movimientos"),
      ),
    ));
  }

}