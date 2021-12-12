import 'package:flutter/material.dart';
import 'package:tienda_don_pepito/model/store.dart';
import 'package:tienda_don_pepito/persistence/database_manager.dart';
import 'package:tienda_don_pepito/view/stores_view.dart';

import 'customer_form.dart';

//Flutter tiene dos tipos de vistas.
//1. StatelessWidget: Tipo de vista o ventana que no cambia. Siempre va a ser la misma
//2. StatefullWidget: Tipo de vista o ventana que cambia su estado o componentes

class HomeView extends StatelessWidget {
  List<String> images = [
    "images/listado_tiendas.png",
    "images/generar_pedido.png",
    "images/registro_clientes.png",
    "images/buzon_sugerencias.png"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("App don pepito"),
          backgroundColor: Colors.red,
        ),
        body: Container(
            padding: EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
              ),
              itemBuilder: (context, index) => buildCell(context, index),
            )),
      ),
    );
  }

  Widget buildCell(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        _navigateTo(context, index);
      }, // handle your image tap here
      child: Image.asset(
        images[index],
        fit: BoxFit.cover, // this is the solution for border
        width: 110.0,
        height: 110.0,
      ),
    );
  }

  _navigateTo(context, int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StoresListView()),
      );
    }
    else if(index == 1){
      var t1 = Store("101", "Gato", "Cali", 1.0, 2.0, "7777777", "3105555555", "gato@gmail.com", "www.elgato.com", BusinessType.abarrotes,"xxx");
      var t2 = Store("201", "Loro", "Bogotá", 1.0, 2.0, "3333333", "3105555555", "loro@gmail.com", "www.elloro.com", BusinessType.video_juegos,"yyy");
      DataBaseManager.db.insertarNuevaTienda(t1);
      DataBaseManager.db.insertarNuevaTienda(t2);
      DataBaseManager.db.listaTiendas("select * FROM Tienda").then((value) => print(value));
    }
    else if(index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CustomerFormView()),
      );
    }
    return;
  }
}
