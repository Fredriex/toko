import 'package:flutter/material.dart';
import 'package:sqlliteflutter2/controller/Barangservice.dart';
import 'package:sqlliteflutter2/controller/Supplierservice.dart';
import 'package:sqlliteflutter2/data/karyawandata.dart';
import 'package:sqlliteflutter2/view/Addbarang.dart';
import 'package:sqlliteflutter2/view/Editbarang.dart';
import 'package:sqlliteflutter2/view/Viewbarang.dart';
import 'package:sqlliteflutter2/model/Barang.dart';
import '../model/Supplier.dart';
import '../view/Addsupp.dart';
import '../view/editSupp.dart';
import '../view/viewSupp.dart';
import 'supplierdata.dart';


class suppplierdata extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Supplier> _supplierList = <Supplier>[];
  late final _supplierService = Supplierservice();

  getAllSupplier() async {
    var suppliers = await _supplierService.readAllSupp();
    _supplierList = <Supplier>[];
    suppliers.forEach((supplier) {
      setState(() {
        var supplierModel = supplier();
        supplierModel.kodeSupp = supplier['kodeSupp'];
        supplierModel.namaSupp = supplier['namaSupp'];
        supplierModel.telp = supplier['telp'];
        supplierModel.alamat = supplier['alamat'];
        _supplierList.add(supplierModel);
      });
    });
  }

  @override
  void initState() {
    getAllSupplier();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, kode) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Kamu Yakin Menghapus',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result = await _supplierService.deleteSupp(kode);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllSupplier();
                      _showSuccessSnackBar('Hapus Data Supplier Success');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Supplier'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _supplierList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => viewSupp(
                            supplier: _supplierList[index],
                          ))).then((data) {
                    if (data != null) {
                      getAllSupplier();
                      _showSuccessSnackBar('Tambah Data Supplier Success');
                    }
                  });
                },
                leading: const Icon(Icons.shopping_cart),
                iconColor: Colors.purple,
                title: Text(_supplierList[index].kodeSupp.toString() ?? ''),
                subtitle: Text(_supplierList[index].namaSupp ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => editSupp(
                                    supplier: _supplierList[index],
                                  ))).then((data) {
                            if (data != null) {
                              getAllSupplier();
                              _showSuccessSnackBar(
                                  'Data Supplier Updated Success');
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(context, _supplierList[index].kodeSupp);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Addsupp()))
              .then((data) {
            if (data != null) {
              getAllSupplier();
              _showSuccessSnackBar('Tambah Data Supplier Success');
            }
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("TOKO MAJU JAYA"),
              accountEmail: Text("SENTOSA ABADI"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  "T",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home), title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                Navigator.popUntil(context, ModalRoute.withName('main'));},
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet_rounded), title: Text("Barang"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>suppplierdata()),);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet_rounded), title: Text("Supplier"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>suppplierdata()),);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet_rounded), title: Text("Karyawan"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>karyawandata()),);
              },
            ),
          ],
        ),
      ),
    );
  }
}
