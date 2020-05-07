import 'package:appbibliotecaadvoc/models/user_model.dart';
import 'package:appbibliotecaadvoc/screens/login_screen.dart';
import 'package:appbibliotecaadvoc/tiles/order_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if(UserModel.of(context).isLoggedIn()){

      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>( // QuerySnapshot pois estamos pegando vários documentos
        future: Firestore.instance.collection("usuarios").document(uid).collection("pedidos").getDocuments(), // Pegando todos os pedidos feitos pelo usuário
        builder: (context, snapshot){
          if(!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return ListView(
              children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList(), // Pegando os pedidos do usuário e transformando em um OrderTile pra depois transformar em uma lista
            );
          }
        },
      );

    } else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.view_list, size: 80.0, color: Theme.of(context).primaryColor,),
            SizedBox(height: 16.0,), // Espeaçamento
            Text("Faça o login para acompanhar!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0,), // Espeaçamento
            Card(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: SizedBox(
                height: 50.0,
                child: RaisedButton(
                  child: Text("Entrar", style: TextStyle(fontSize: 18.0,),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen())
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
