import 'package:tienda_don_pepito/model/product.dart';
import 'package:tienda_don_pepito/persistence/server_connection.dart';

class ProductsDAO{

  Future<List<Product>> getProductsFromServer(String idtienda) async{
    var srvConn = ServerConnection();

    final List<Product> products = [];
    await srvConn.getProducts(idtienda).then((productsData) {
      List records = productsData.split("|");
      records.forEach((element) {
        products.add(Product.fromString(idtienda+";"+element));
      });
    });
    return products;
  }
}