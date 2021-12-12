import 'package:flutter/material.dart';
import 'package:tienda_don_pepito/persistence/stores_dao.dart';
import 'package:tienda_don_pepito/view/home_view.dart';

//AIzaSyC4bxb1m26DkwxwiSni946__3CaXScfMe8

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  StoresDAO.addStoresFromServer().then((value){
    runApp(HomeView());
  });
}
