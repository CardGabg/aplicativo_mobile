import 'package:flutter/material.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int contador = 0;

  void incremetarContador() {
    setState(() {
      contador++;
    });
  }

  void decrementarContador() {
    if (contador > 0) {
      setState(() {
        contador--;
      });
    }
  }

  void reiniciarContador() {
    setState(() {
      contador = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Contador"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 400,
                  margin: EdgeInsets.only(bottom: 30),
                  child: Image.network(
                      "https://blog.vandersonguidi.com.br/wp-content/uploads/2019/08/flutter.png")),
              Text(
                "Quantas vezes você clicou",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '$contador',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.blue,
                      child: Text("Incrementar"),
                      onPressed: () {
                        incremetarContador();
                      }),
                  RaisedButton(
                      color: Colors.yellow,
                      child: Text("Decrementar"),
                      onPressed: () {
                        decrementarContador();
                      }),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            reiniciarContador();
          },
        ),
      ),
    );
  }
}
