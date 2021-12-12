import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tienda_don_pepito/persistence/stores_dao.dart';
import 'package:tienda_don_pepito/view/home_view.dart';

//AIzaSyC4bxb1m26DkwxwiSni946__3CaXScfMe8

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  StoresDAO.addStoresFromServer().then((value){
    runApp(HomeView());
  });
}
