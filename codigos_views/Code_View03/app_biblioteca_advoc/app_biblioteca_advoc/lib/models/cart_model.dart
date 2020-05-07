import 'package:appbibliotecaadvoc/datas/cart_product.dart';
import 'package:appbibliotecaadvoc/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {

  UserModel user;

  List<CartProduct> products = []; // lista de produtos

  bool isLoading = false;

  CartModel(this.user){
    if(user.isLoggedIn()) // Só vai carregar os itens se estiver logado
    _loadCartItems();
  }

  // Permitindo acesso do CartModel de qualquer lugar
  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) { // função para adicionar um novo produto no carrinho
    products.add(cartProduct);
    Firestore.instance.collection("usuarios").document(user.firebaseUser.uid) // Acessando o ID do usuário no banco
        .collection("carrinho").add(cartProduct.toMap()) // Adicionando produto ao carrinho do usuário
        .then((doc){ // Depois de adicionar o produto ao carrinho, vamos pegar a referencia(doc) e salvar no ID do carrinho
          cartProduct.cid = doc.documentID; // ID do carrinho recebendo o documento dessa transação
    });
    
    notifyListeners();
    
  }

  void removeCartItem(CartProduct cartProduct){ // função para remover um produto do carrinho
    Firestore.instance.collection("usuarios").document(user.firebaseUser.uid) // Acessando o ID do usuário no banco
    .collection("carrinho").document(cartProduct.cid).delete(); // Acessando a coleção carrinho e removendo um produto que está naquele carrinho

    products.remove(cartProduct);

    notifyListeners();
  }

  // Como queremos avisar o usuário em forma de texto que o pedido foi realizado, então a função tem que retornar um Future<String> ao invés de void
  Future<String> finishOrder() async { // Função para finalizar pedidos
    if(products.length == 0) return null; // Verificando se a lista de produtos está vazia

    isLoading = true;
    notifyListeners();

    DocumentReference refOrder = await Firestore.instance.collection("pedidos").add( // Obtendo uma referencia como ID do pedido e depois adicionando os dados do pedido na coleção Pedidos
        {
          "clienteId": user.firebaseUser.uid,
          "produtos": products.map((cartProduct)=>cartProduct.toMap()).toList(),
          "status": 1
        }
    );

    await Firestore.instance.collection("usuarios").document(user.firebaseUser.uid) // Acessando a coleção de usuários
        .collection("pedidos").document(refOrder.documentID).setData({ // Criando a coleção de pedidos e o ID desse pedido será o mesmo ID de pedido salvo no refOrder
      "pedidoID": refOrder.documentID
    });

    QuerySnapshot query = await Firestore.instance.collection("usuarios")
        .document(user.firebaseUser.uid).collection("carrinho").getDocuments(); // Pegando todos os produtos no carrinho

    for(DocumentSnapshot doc in query.documents){ // Pegando cada um dos documentos do carrinho e deletando a referencia dele
      doc.reference.delete();
    }

    products.clear(); // Limpando a lista de produtos

    isLoading = false;
    notifyListeners();

    return refOrder.documentID; // Retornando o ID do pedido para mostrar ao usuário quando o pedido for finalizado
  }

  void _loadCartItems() async { // Função para carregar os itens do carrinho

    QuerySnapshot query = await Firestore.instance.collection("usuarios").document(user.firebaseUser.uid) // Salvando em um query o que se está acessando no ID do usuário no banco
        .collection("carrinho").getDocuments(); // Pegando todos os documentos do carrinho

    products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList(); // Transformando cada documento pego no firebase em um CartProduct e retornando uma lista

    notifyListeners();
  }
}