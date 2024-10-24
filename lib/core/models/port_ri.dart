class PortRi {
  // int id;
  String kodePelabuhan, namaPelabuhan, lokasiPelabuhan, unitKerja, alamatKantor;

  PortRi({
    // required this.id,
    required this.kodePelabuhan,
    required this.namaPelabuhan,
    required this.lokasiPelabuhan,
    required this.unitKerja,
    required this.alamatKantor,
  });

  factory PortRi.fromJson(Map<String, dynamic> json) {
    return PortRi(
      // id: json['id'],
      kodePelabuhan: json['kd_pelabuhan'],
      namaPelabuhan: json['nama_pelabuhan'],
      lokasiPelabuhan: json['lokasi_pelabuhan'],
      unitKerja: json['unit_kerja'],
      alamatKantor: json['alamat_kantor'],
    );
  }
}
