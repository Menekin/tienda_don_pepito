import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tienda_don_pepito/model/product.dart';
import 'package:tienda_don_pepito/model/store.dart';

class DataBaseManager {
  static late Database _database;
  final String _dataBaseName = "AppNegociosBarrio.db";

  DataBaseManager._();
  static final DataBaseManager db = DataBaseManager._();
  var initialize = false;

  Future<Database> get database async {
    if (!initialize) {
      _database = await iniciarBaseDatos();
      initialize = true;
    }
    return _database;
  }

  //#region Instrucción SQL para crear la tabla tienda
  final String _CREATE_TABLE_TIENDA = "CREATE TABLE Tienda("
      "id INTEGER PRIMARY KEY,"
      "nombre TEXT,"
      "direccion TEXT,"
      "latitud REAL,"
      "longitud REAL,"
      "telefono_fijo TEXT,"
      "telefono_celular TEXT,"
      "email TEXT,"
      "pagina_web TEXT,"
      "tipo TEXT"
      ")";
  //#endregion

  //#region Instrucción SQL para crear la tabla pedido temporal
  final String _CREATE_TABLE_PEDIDOTEMP = "CREATE TABLE PedidoTemp("
      "id INTEGER,"
      "idtienda INTEGER,"
      "nombre TEXT,"
      "unidad TEXT,"
      "precio INTEGER,"
      "cantidad INTEGER"
      ")";
  //#endregion

  iniciarBaseDatos() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dataBaseName);
    return await openDatabase(path, version: 5, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(_CREATE_TABLE_TIENDA);
      await db.execute(_CREATE_TABLE_PEDIDOTEMP);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      if (oldVersion < newVersion) {
        await db.execute("DROP TABLE IF EXISTS Tienda");
        await db.execute(_CREATE_TABLE_TIENDA);
        await db.execute("DROP TABLE IF EXISTS PedidoTemp");
        await db.execute(_CREATE_TABLE_PEDIDOTEMP);
      }
    });
  }

  insertarNuevaTienda(Store td) async {
    final db = await database;
    var res = await db.insert("Tienda", td.toJson());
    return res;
  }

  insertarNuevoProductoTemp(Product pdt) async {
    final db = await database;
    var res = await db.insert("PedidoTemp", pdt.toJson());
    return res;
  }

  Future<List<Store>> listaTiendas(String query) async {
    final db = await database;
    var res = await db.rawQuery(query);
    List<Store> list = [];
    if (res.isNotEmpty) {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp) {
        list.add(Store.fromJson(t));
      }
    }
    return list;
  }

  Future<List<Product>> listaProductosPedidoTemp() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM PedidoTemp");
    List<Product> list = [];
    if (res.isNotEmpty) {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp) {
        list.add(Product.fromJson(t));
      }
    }
    return list;
  }
}
