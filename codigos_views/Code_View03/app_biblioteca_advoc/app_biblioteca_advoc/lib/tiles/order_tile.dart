import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {

  final String orderId;

  OrderTile(this.orderId);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>( // StreamBuilder serve para ter um acompanhamento com o banco de dados em tempo real
          stream: Firestore.instance.collection("pedidos").document(orderId).snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {

              int status = snapshot.data["status"];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Código do pedido: ${snapshot.data.documentID}\n",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0,),
                  Text("Descrição:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(_buildProductsText(snapshot.data)),
                  SizedBox(height: 4.0,),
                  Text("Data para devolução:\n",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Estado do Pedido:\n",
                    style: TextStyle(fontWeight: FontWeight.bold),

                  ),
                  Row( // Mostrando os estados do pedido
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle("1", "Preparação", status, 1),
                      Container( // Linha para separar os estados
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey[500],
                      ),
                      _buildCircle("2", "Entrega", status, 2),
                      Container( // Linha para separar os estados
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey[500],
                      ),
                      _buildCircle("3", "Devolução", status, 3),
                    ],
                  )
                ],
              );
            }
          },),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot){
    String text = "";
    for(LinkedHashMap p in snapshot.data["produtos"]){
      text += "${p["quantity"]}x ${p["product"] ["title"]} \n (${p["product"] ["authors"]})\n\n"; // duas quebras de linha para facilitar a visualização dos produtos

    }
    return text;
  }

  Widget _buildCircle(String title, String subtitle, int status, int thisStatus){ // Configuração dos estados do pedido
    Color backColor;
    Widget child;

    if(status < thisStatus){
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white),);
    } else if (status == thisStatus){ // Estado atual do pedido
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.white),),
          CircularProgressIndicator( // é a animação de circulo carregando no estado do pedido
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle)
      ],
    );
  }

}
