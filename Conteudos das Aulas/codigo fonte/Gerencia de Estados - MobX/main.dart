import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'controller.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = ControllerCount();
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    print("rebuild");
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
              Observer(
                builder: (_) => Text(
                  '${_controller.contador}',
                  style: TextStyle(fontSize: 20),
                )
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.blue,
                      child: Text("Incrementar"),
                      onPressed: () {
                        _controller.incremetarContador();
                      }),
                  RaisedButton(
                      color: Colors.yellow,
                      child: Text("Decrementar"),
                      onPressed: () {
                        _controller.decrementarContador();
                      }),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            _controller.reiniciarContador();
          },
        ),
      ),
    );
  }
}
