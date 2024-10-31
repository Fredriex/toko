class Barang {
  String? kode;
  String? nama;
  String? satuan;
  int? hargabeli;
  int? hargajual;
  double? diskon;
  barangMap() {
    var mapping = Map<String, dynamic>();
    mapping['kode'] = kode ?? null;
    mapping['nama'] = nama!;
    mapping['satuan'] = satuan!;
    mapping['hargabeli'] = hargabeli!;
    mapping['hargajual'] = hargajual!;
    mapping['diskon'] = diskon;
    return mapping;
  }
}
