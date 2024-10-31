import 'package:sqlliteflutter2/model/Supplier.dart';

import '../model/Barang.dart';
import '../model/Repository.dart';

class Supplierservice {
  late Repository _repository;
  Supplierservice() {
    _repository = Repository() as Repository;
  }
  //Save data
  saveSupp(Supplier supplier) async {
    return await _repository.insertDataSupp('supplier', supplier.supplierMap());
  }

  //Read data
  readAllSupp() async {
    return await _repository.readDataSupp('supplier');
  }

  //Edit User
  updateSupp(Supplier supplier) async {
    return await _repository.updateData('supplier', supplier.supplierMap());
  }

  deleteSupp(kode) async {
    return await _repository.deleteDataBykode('supplier', kode);
  }
}
