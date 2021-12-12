import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_don_pepito/model/product.dart';
import 'package:tienda_don_pepito/persistence/server_connection.dart';

class OrderListView extends StatefulWidget {
  final List<Product> order;

  OrderListView(this.order);

  @override
  _OrderListViewState createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  final _biggerFont = const TextStyle(fontSize: 18.0, color: Colors.blueAccent);

  String datos = '';
  int idpedido = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
      ),
      body: _buildStoreList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            datos = '';
            idpedido = idpedido+1;

            widget.order.forEach((prd) {
              datos = idpedido.toString()+ datos +';'+'['+ prd.nombre+','+prd.precio.toString()+','+prd.cantidad.toString()+']';
            });
          });
          var srvcon = ServerConnection();
          srvcon.insert('Orders',datos).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Pedido confirmado')),
            );
          });
        },
        label: Text('Confirmar pedido'),
        icon: Icon(Icons.task_alt),
      ),
    );
  }

  Widget _buildStoreList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.order.length,
        itemBuilder: (
          context,
          i,
        ) {
          return _buildRow(widget.order[i]);
        });
  }

  Widget _buildRow(Product pdt) {
    return ListTile(
      isThreeLine: true,
      title: Text(
        pdt.nombre,
        style: _biggerFont,
      ),
      subtitle: Text(
        pdt.precio.toString(),
        style: TextStyle(fontSize: 20, color: Colors.blue),
      ),
    );
  }
}
