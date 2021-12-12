import 'package:tienda_don_pepito/model/store.dart';
import 'package:tienda_don_pepito/persistence/server_connection.dart';
import 'dart:convert' as JSON;

class StoresDAO{
  static final List<Store> stores = [];

  static Future<void> addStoresFromServer() async{
    var srvConn = ServerConnection();
    await srvConn.select('Stores').then((storesData) {
      var json = JSON.jsonDecode(storesData);
      List records = json["data"];
      records.forEach((element) {
        stores.add(Store.fromJson(element));
      });
    });
  }
}