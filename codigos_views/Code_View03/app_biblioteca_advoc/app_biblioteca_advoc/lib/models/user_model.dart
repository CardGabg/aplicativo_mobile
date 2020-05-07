import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class UserModel extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;



  // USUÁRIO ATUAL

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map(); // Conterá os dados do usuário atual

  bool isLoading = false;

  // Acessando o UserModel de forma mais fácil, sem precisar colocar dentro de um ScopedModelDescendant
  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  void signUp({@required Map<String, dynamic> userData, @required String pass,
    @required VoidCallback onSuccess, @required VoidCallback onFail }){ // VoidCallBack será uma função que vamos chamar de dentro da função signUp
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword( // Criação de usuário no Firebase
        email: userData["email"],
        password: pass
    ).then((user) async {
      firebaseUser = user;
      await _saveUserData(userData); // Salvando os dados do usuário no banco de dados
    }).catchError((e){ // Se não for possível criar o usuário, aparecerá este erro
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }


  void signIn({@required String email, @required String pass,
    @required VoidCallback onSuccess, @required VoidCallback onFail }) async {
    isLoading = true; // Está carregando
    notifyListeners(); // atualizando a tela

    _auth.signInWithEmailAndPassword(email: email, password: pass).then(
            (user) async {
              firebaseUser = user;
              await _loadCurrentUser();

              onSuccess();
              isLoading = false;
              notifyListeners();

            }).catchError((e){
              onFail();
              isLoading = false;
              notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPass(String email){
    _auth.sendPasswordResetEmail(email: email);

  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async { // Função que salvará primeiramente os dados do usuário na variável userData declarada anteriormente
    this.userData = userData;
    await Firestore.instance.collection("usuarios").document(firebaseUser.uid).setData(userData); // criando o usuário no firebase e guardando os dados na sua ID
  }

  Future<Null> _loadCurrentUser() async {
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if(firebaseUser != null){
      if(userData["name"] == null){
        DocumentSnapshot docUser = await Firestore.instance.collection("usuarios").document(firebaseUser.uid).get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }
}