import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {

  String category;
  String id;

  String title;
  String authors;
  String publisher;
  double price;
  List image;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["titulo"];
    authors = snapshot.data["autores"];
    publisher = snapshot.data["editora"];
    price = snapshot.data["preco"] + 0.0;
    image = snapshot.data["imagem"];
  }

  Map<String, dynamic> toResumedMap(){
    return {
      "title": title,
      "authors": authors
    };
  }
}