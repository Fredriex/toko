class Supplier {
  String? kodeSupp;
  String? namaSupp;
  String? telp;
  String? alamat;
  supplierMap() {
    var mapping = Map<String, dynamic>();
    mapping['kodeSupp'] = kodeSupp ?? null;
    mapping['namaSupp'] = namaSupp!;
    mapping['telp'] = telp!;
    mapping['alamat'] = alamat!;
    return mapping;
  }
}