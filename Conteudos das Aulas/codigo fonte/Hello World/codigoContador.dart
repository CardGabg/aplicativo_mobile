import 'package:flutter/material.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int numero = 0;

  void incrementar() {
    setState(() {
      numero++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Contador"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.plus_one),
          onPressed: () {
            incrementar();
          },
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Contagem:"),
              Text("$numero"),
            ],
          ),
        ),
      ),
    );
  }
}

