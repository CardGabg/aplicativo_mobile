//import 'dart:async';
//
//import 'package:bloc_pattern/bloc_pattern.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:rxdart/rxdart.dart';
//
//class BookBloc extends BlocBase {
//
//  List<Book> books;
//
//  final StreamController _booksController = StreamController();
//  Stream get outBooks => _booksController.stream;
//  @override
//  void dispose() {
//    _booksController.close();
//  }
//}