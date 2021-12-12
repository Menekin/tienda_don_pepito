import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_don_pepito/model/product.dart';

class ProductsListView extends StatefulWidget {

  final List<Product> LstPr;

  ProductsListView(this.LstPr);

  @override
  _ProductsListViewState createState() => _ProductsListViewState();

}


class _ProductsListViewState extends State<ProductsListView> {
  //final stDAO = StoreDAO();
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
      trailing: Icon(
        Icons.ac_unit_outlined,
        size: 20,
        color: Colors.amber,
      ),
      onTap: () {



      },
    );
  }
}