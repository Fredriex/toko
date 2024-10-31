import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Koneksidatabase {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database =
        await openDatabase(path, version: 2, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql =
        "CREATE TABLE data (kode TEXT ,nama TEXT,satuan TEXT, hargabeli INTEGER, hargajual INTEGER, diskon DOUBLE);";
    await database.execute(sql);

    String sql2 =
        "CREATE TABLE supplier (kodeSupp TEXT ,namaSupp TEXT,telp TEXT, alamat TEXT);";
    await database.execute(sql2);
  }

}
