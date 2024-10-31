import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlliteflutter2/controller/Barangservice.dart';
import 'package:sqlliteflutter2/controller/Supplierservice.dart';
import 'package:sqlliteflutter2/model/Supplier.dart';
import '../model/Barang.dart';

class Addsupp extends StatefulWidget {
  @override
  State<Addsupp> createState() => _AddSuppState();
}

class _AddSuppState extends State<Addsupp> {
  var _kodeSuppController = TextEditingController();
  var _namaSuppController = TextEditingController();
  var _telpController = TextEditingController();
  var _alamatController = TextEditingController();
  bool _validateKodeSupp = false;
  bool _validateNamaSupp = false;
  bool _validatetelp = false;
  bool _validatealamat = false;
  var _Supplierservice = Supplierservice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Add Supplier'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Supplier',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _kodeSuppController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Kode Supplier',
                    labelText: 'Kode',
                    errorText:
                    _validateKodeSupp ? 'Kode Supplier Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _namaSuppController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Nama Supplier',
                    labelText: 'Nama',
                    errorText:
                    _validateNamaSupp ? 'Nama Supplier Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _telpController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter No Telepon',
                    labelText: 'Telepon',
                    errorText:
                    _validatetelp ? 'Telp Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _alamatController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Alamat',
                    labelText: 'Alamat',
                    errorText: _validatealamat
                        ? 'Alamat Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _kodeSuppController.text.isEmpty
                              ? _validateKodeSupp = true
                              : _validateKodeSupp = false;
                          _kodeSuppController.text.isEmpty
                              ? _validateNamaSupp = true
                              : _validateNamaSupp = false;
                          _telpController.text.isEmpty
                              ? _validatetelp = true
                              : _validatetelp = false;
                          _alamatController.text.isEmpty
                              ? _validatealamat = true
                              : _validatealamat = false;
                        });
                        if (_validateKodeSupp == false &&
                            _validateNamaSupp == false &&
                            _validatetelp == false &&
                            _validatealamat == false) {
                          var _supplier = Supplier();
                          _supplier.kodeSupp = _kodeSuppController.text;
                          _supplier.namaSupp = _namaSuppController.text;
                          _supplier.telp = _telpController.text;
                          _supplier.alamat = _alamatController.text;

                          print(_kodeSuppController);
                          print(_namaSuppController);
                          print(_telpController);
                          print(_alamatController);


                          var hasil = await _Supplierservice.saveSupp(_supplier);
                          Navigator.pop(context, hasil);
                        }
                      },
                      child: const Text('Save')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _kodeSuppController.text = '';
                        _namaSuppController.text = '';
                        _telpController.text = '';
                        _alamatController.text = '';
                      },
                      child: const Text('Cancel'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
