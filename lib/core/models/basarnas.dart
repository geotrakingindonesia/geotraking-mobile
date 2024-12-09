class Basarnas {
  final int? id;
  final double lat;
  final double lon;
  final String tipe;
  final String namaBasarnas;

  Basarnas({
    this.id,
    required this.lat,
    required this.lon,
    required this.tipe,
    required this.namaBasarnas,
  });

  factory Basarnas.fromJson(Map<String, dynamic> json) {
    return Basarnas(
      id: int.tryParse(json['id'].toString()),
      lat: double.tryParse(json['lat'].toString()) ?? 0.0,
      lon: double.tryParse(json['lon'].toString()) ?? 0.0,
      tipe: json['tipe'] as String? ?? '',
      namaBasarnas: json['nama'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lat': lat,
      'lon': lon,
      'tipe': tipe,
      'nama': namaBasarnas,
    };
  }
}
