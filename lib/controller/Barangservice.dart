import '../model/Barang.dart';
import '../model/Repository.dart';

class BarangService {
  late Repository _repository;
  BarangService() {
    _repository = Repository();
  }
  //Save data
  saveBarang(Barang barang) async {
    return await _repository.insertData('data', barang.barangMap());
  }

  //Read data
  readAllBarang() async {
    return await _repository.readData('data');
  }

  //Edit User
  updateBarang(Barang barang) async {
    return await _repository.updateData('data', barang.barangMap());
  }

  deleteBarang(kode) async {
    return await _repository.deleteDataBykode('data', kode);
  }
}
