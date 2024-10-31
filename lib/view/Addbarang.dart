import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlliteflutter2/controller/Barangservice.dart';
import '../model/Barang.dart';

class AddBarang extends StatefulWidget {
  @override
  State<AddBarang> createState() => _AddBarangState();
}

class _AddBarangState extends State<AddBarang> {
  var _kodeController = TextEditingController();
  var _namaController = TextEditingController();
  var _satuanController = TextEditingController();
  var _hargabeliController = TextEditingController();
  var _hargajualController = TextEditingController();
  var _diskonController = TextEditingController();
  bool _validateKode = false;
  bool _validateNama = false;
  bool _validateSatuan = false;
  bool _validatehargabeli = false;
  bool _validatehargajual = false;
  bool _validatediskon = false;
  var _barangService = BarangService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Add Barang'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Barang',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _kodeController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Kode',
                    labelText: 'Kode',
                    errorText:
                        _validateKode ? 'Kode Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Nama',
                    labelText: 'Nama',
                    errorText:
                        _validateNama ? 'Nama Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _satuanController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Satuan',
                    labelText: 'Satuan',
                    errorText:
                        _validateSatuan ? 'Satuan Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _hargabeliController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Harga Beli',
                    labelText: 'Harga Beli',
                    errorText: _validatehargabeli
                        ? 'Harga Beli Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _hargajualController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Harga Jual',
                    labelText: 'Harga Jual',
                    errorText: _validatehargajual
                        ? 'Harga Jual Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _diskonController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Diskon',
                    labelText: 'Diskon',
                    errorText: _validatediskon
                        ? 'Diskon Value Can\'t Be Empty'
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
                          _kodeController.text.isEmpty
                              ? _validateKode = true
                              : _validateKode = false;
                          _kodeController.text.isEmpty
                              ? _validateNama = true
                              : _validateNama = false;
                          _namaController.text.isEmpty
                              ? _validateSatuan = true
                              : _validateSatuan = false;
                          _satuanController.text.isEmpty
                              ? _validatehargabeli = true
                              : _validatehargabeli = false;
                          _hargabeliController.text.isEmpty
                              ? _validatehargajual = true
                              : _validatehargajual = false;
                          _diskonController.text.isEmpty
                              ? _validatediskon = true
                              : _validatediskon = false;
                        });
                        if (_validateKode == false &&
                            _validateNama == false &&
                            _validateSatuan == false &&
                            _validatehargabeli == false &&
                            _validatehargajual == false &&
                        _validatediskon == false) {
                          var _barang = Barang();
                          _barang.kode = _kodeController.text;
                          _barang.nama = _namaController.text;
                          _barang.satuan = _satuanController.text;
                          _barang.hargabeli =
                              int.parse(_hargabeliController.text);
                          _barang.hargajual =
                              int.parse(_hargajualController.text);
                          _barang.diskon = double.parse(_diskonController.text)/100;

                          print('Kode: ${_barang.kode}');
                          print('Nama: ${_barang.nama}');
                          print('Satuan: ${_barang.satuan}');
                          print('Harga Beli: ${_barang.hargabeli}');
                          print('Harga Jual: ${_barang.hargajual}');
                          print('Diskon: ${_barang.diskon}');

                          var hasil = await _barangService.saveBarang(_barang);
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
                        _kodeController.text = '';
                        _namaController.text = '';
                        _satuanController.text = '';
                        _hargabeliController.text = '';
                        _hargajualController.text = '';
                        _diskonController.text = '';
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
