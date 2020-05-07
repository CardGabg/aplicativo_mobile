import 'package:appbibliotecaadvoc/datas/product_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Classe que armazenará um produto no carrinho
class CartProduct {

  String cid; // ID da categoria

  String category;
  String pid; // ID do produto

  int quantity;

  ProductData productData; // para armazenar os produtos do carrinho

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document){ // Construtor que receberá todos os produtos do carrinho
    cid = document.documentID;
    category = document.data["category"];
    pid = document.data["pid"];
    quantity = document.data["quantity"];
  }

  Map<String, dynamic> toMap(){ // adicionando no banco de dados
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "product": productData.toResumedMap()
    };
  }

}