class PortPelabuhan {
  final String namaPelabuhan;
  final String kodePelabuhan;
  final double lat;
  final double lon;

  PortPelabuhan({
    required this.namaPelabuhan,
    required this.kodePelabuhan,
    required this.lat,
    required this.lon,
  });

  factory PortPelabuhan.fromJson(Map<String, dynamic> json) {
    return PortPelabuhan(
      namaPelabuhan: json['nama'],
      kodePelabuhan: json['kd_pelabuhan'],
      // lat: double.parse(json['lat']),
      // lon: double.parse(json['lon']),
      lat: double.tryParse(json['lat'].toString()) ?? 0.0,
      lon: double.tryParse(json['lon'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': namaPelabuhan,
      'kd_pelabuhan': kodePelabuhan,
      'lat': lat,
      'lon': lon,
    };
  }
}