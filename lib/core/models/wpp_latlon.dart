class WppLatLong {
  final int? id;
  final int? wppId;
  final double lat;
  final double lon;

  WppLatLong({
    required this.id,
    required this.wppId,
    required this.lat,
    required this.lon,
  });

  factory WppLatLong.fromJson(Map<String, dynamic> json) {
    return WppLatLong(
      
      // id: int.tryParse(json['id'].toString()),
      // id: json['id'],
      
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      wppId: json['wpp_id'] != null ? int.tryParse(json['wpp_id'].toString()) : null,
      // id: int.tryParse(json['id'].toString() ?? ''),
      // wppId: int.tryParse(json['wpp_id'].toString() ?? ''),
      // wppId: json['wpp_id'],
      lat: double.tryParse(json['lat'].toString()) ?? 0.0,
      lon: double.tryParse(json['lon'].toString()) ?? 0.0,
      // lat: double.parse(json['lat']),
      // lon: double.parse(json['lon']),
      // lat: json['lat'],
      // lon: json['lon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wpp_id': wppId,
      'lat': lat,
      'lon': lon,
    };
  }
}