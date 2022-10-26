import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteHelpr {
  static late Database db;

  static Future<Database> createDatabase() async {
    String path = join(await getDatabasesPath(), 'productsDB');
    print('Create DB');
    db = await openDatabase(path, version: 1, onCreate: (db, verion) {
      db.execute(
          'CREATE TABLE products(id INTEGER PRIMARY KEY , name TEXT, price INTEGER, amount INTEGER )');
    });

    return db;
  }

//insert products
  static Future<int> insertProducts(
      int id, int itemId, String name, int price, int amount) async {
    return await db.insert('products', {
      'id': id,
      'name': name,
      'price': price,
      'amount': amount,
    });
  }

//Check If Add
  static Future<List<Map<String, dynamic>>> isAddedToCart(int id) async {
    return await db.query('products', where: 'id = ?', whereArgs: [id]);
  }

//count Table
  static Future<int?> getCountofTable() async {
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM products'));
  }

//get all products
  static Future<List<Map<String, dynamic>>> getAllProducts() async {
    return await db.query('products');
  }

//update
  static Future<int> updateAmount(int id, int amount) async {
    return await db.update('products', {'amount': amount},
        where: 'id = ?', whereArgs: [id]);
    // return await db.rawUpdate('UPDATE products SET amount = ? WHERE id = ?', ['$amount', '$id']);
  }

  //delete Item products
  static Future<int> deleteItemProduct(int id) async {
    return await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  //delet all products
  static Future<int> deleteAllProducts() async {
    return await db.delete('products');
  }

  // Count Total
  static Future getCountPriceProducts() async {
    // return await db.rawQuery("SELECT SUM(price*amount) FROM products");
    var result = await db.rawQuery("SELECT SUM(price*amount) FROM products");
    Object? value = result[0]["SUM(price*amount)"];
    return value.toString();
  }

//   static Future getAmount(int id) async {
//     int c = 0;
//     List<Map> result =
//         await db.rawQuery("SELECT amount FROM products WHERE id = ?", ['$id']);
//     // print(result);
//     for (var element in result) {
//       c = element['amount'];
//       //  print(element);
//     }

//     return c;
//   }

}
