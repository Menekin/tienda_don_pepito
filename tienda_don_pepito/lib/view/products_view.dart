import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_don_pepito/model/product.dart';
import 'package:tienda_don_pepito/model/store.dart';
import 'package:tienda_don_pepito/persistence/database_manager.dart';
import 'package:tienda_don_pepito/view/google_maps.dart';
import 'package:tienda_don_pepito/view/order_view.dart';

class ProductsListView extends StatefulWidget {
  final List<Product> LstPr;
  final Store tienda;
  ProductsListView(this.LstPr, this.tienda);

  @override
  _ProductsListViewState createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.blueAccent);

  void handleTap(int item) {
    switch (item) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GoogleMapsWidget(widget.tienda)),
        );
        break;
      case 1:
        DataBaseManager.db.listaProductosPedidoTemp().then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderListView(value)));
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) => handleTap(item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('Ver en google maps')),
              PopupMenuItem<int>(value: 1, child: Text('Carrito de compras')),
            ],
          ),
        ],
      ),
      body: _buildStoreList(),
    );
  }

  Widget _buildStoreList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.LstPr.length,
        itemBuilder: (
          context,
          i,
        ) {
          return _buildRow(widget.LstPr[i]);
        });
  }

  Widget _buildRow(Product pdt) {
    return ListTile(
      title: Text(
        pdt.nombre,
        style: _biggerFont,
      ),
      subtitle: Text(
        pdt.precio.toString(),
        style: TextStyle(fontSize: 20, color: Colors.blue),
      ),
      trailing: IconButton(
        icon: Icon(Icons.add_shopping_cart, color: Colors.black),
        onPressed: () {
          pdt.cantidad = 1;
          DataBaseManager.db.insertarNuevoProductoTemp(pdt);
          DataBaseManager.db.listaProductosPedidoTemp().then((value) {});
        },
      ),
    );
  }
}
