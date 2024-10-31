import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlliteflutter2/model/Supplier.dart';

import '../controller/Barangservice.dart';
import '../model/Barang.dart';
import 'package:sqlliteflutter2/model/Supplier.dart';
import 'package:sqlliteflutter2/controller/Supplierservice.dart';

class editSupp extends StatefulWidget {
  final Supplier supplier;
  const editSupp({Key? key, required this.supplier}) : super(key: key);
  @override
  State<editSupp> createState() => _EditSuppState();
}

class _EditSuppState extends State<editSupp> {
  var _namaSuppController = TextEditingController();
  var _telpController = TextEditingController();
  var _alamatController = TextEditingController();


  bool _validateNamaSupp = false;
  bool _validateTelp = false;
  bool _validateAlamat = false;
  var _supplierService = Supplierservice();
  @override
  void initState() {
    setState(() {
      _namaSuppController.text = widget.supplier.namaSupp ?? '';
      _telpController.text = widget.supplier.telp ?? '';
      _alamatController.text = widget.supplier.alamat ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Edit Suupplier'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'EditBarang',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                        controller: _namaSuppController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter Nama',
                          labelText: 'Nama',
                          errorText: _validateNamaSupp
                              ? 'Nama Value Can\'t Be Empty'
                              : null,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                        controller: _telpController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter telepon',
                          labelText: 'Satuan',
                          errorText: _validateTelp
                              ? 'Telepon Value Can\'t Be Empty'
                              : null,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                        controller: _alamatController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter Alamat',
                          labelText: 'Harga Beli',
                          errorText: _validateAlamat
                              ? 'Alamat Value Can\'t Be Empty'
                              : null,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.teal,
                              textStyle: const TextStyle(fontSize: 15)),
                          onPressed: () async {
                            setState(() {
                              _namaSuppController.text.isEmpty
                                  ? _validateNamaSupp = true
                                  : _validateNamaSupp = false;
                              _telpController.text.isEmpty
                                  ? _validateTelp = true
                                  : _validateTelp = false;
                              _alamatController.text.isEmpty
                                  ? _validateAlamat = true
                                  : _validateAlamat = false;
                            });
                            if (_validateNamaSupp == false &&
                                _validateTelp == false &&
                                _validateAlamat == false) {
                              var _supplier = Supplier();
                              _supplier.kodeSupp = widget.supplier.kodeSupp;
                              _supplier.namaSupp = _namaSuppController.text;
                              _supplier.telp = _telpController.text;
                              _supplier.alamat = _alamatController.text;

                              var hasil =
                              await _supplierService.updateSupp(_supplier);
                              Navigator.pop(context, hasil);
                            }
                          },
                          child: const Text('Update')),
                      const SizedBox(
                        width: 10.0,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                              textStyle: const TextStyle(fontSize: 15)),
                          onPressed: () {
                            _namaSuppController.text = '';
                            _telpController.text = '';
                            _alamatController.text = '';
                          },
                          child: const Text('Cancel'))
                    ])
                  ]))),
    );
  }
}
