import 'package:flutter/material.dart';
import 'package:tienda_don_pepito/model/store.dart';
import 'package:tienda_don_pepito/persistence/products_dao.dart';
import 'package:tienda_don_pepito/persistence/stores_dao.dart';
import 'package:tienda_don_pepito/view/products_view.dart';

class StoresListView extends StatefulWidget {
  @override
  _StoresListViewState createState() => _StoresListViewState();
}

class _StoresListViewState extends State<StoresListView> {
  //final stDAO = StoreDAO();
  final _stores = StoresDAO.stores;
  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.blueAccent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Negocios en el Barrio'),
      ),
      body: _buildStoreList(),
    );
  }

  Widget _buildStoreList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _stores.length,
        itemBuilder: (
          context,
          i,
        ) {
          return _buildRow(_stores[i]);
        });
  }

  Widget _buildRow(Store st) {
    return ListTile(
      title: Text(
        st.nombre,
        style: _biggerFont,
      ),
      subtitle: Text(
        st.direccion,
        style: TextStyle(fontSize: 12, color: Colors.blue),
      ),
      leading: Image.network(
          "https://drive.google.com/uc?export=view&id=" + st.logo),
      trailing: Icon(
        Icons.ac_unit_outlined,
        size: 20,
        color: Colors.amber,
      ),
      onLongPress: () {
        print(st.direccion);
      },
      onTap: () {
        var prDAO = ProductsDAO();
        prDAO.getProductsFromServer(st.id).then((listaProductos) => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductsListView(listaProductos, st)),
              ),
            });
      },
    );
  }
}
