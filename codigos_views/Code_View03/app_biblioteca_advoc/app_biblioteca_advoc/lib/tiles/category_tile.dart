import 'package:appbibliotecaadvoc/screens/category_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        child: Icon(Icons.book, size: 32.0, color: Theme.of(context).primaryColor,),
      ),
      title: Text(snapshot.data["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){ // Ao clicar nessa categoria, ele irá para a tela Category Screen
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CategoryScreen(snapshot))
        );
      },
    );
  }
}
