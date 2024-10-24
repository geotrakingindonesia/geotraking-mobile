// ignore_for_file: non_constant_identifier_names
class Airtime {
  String? mobileId;
  String? idfull;
  String? namaKapal;
  String? sn;
  String? imei;
  String? kategori;
  String? type;
  String? custamer;
  String? powerstatus;
  String? timestamp;
  String? broadcast;
  String? atp_start;
  String? atp_end;
  double? lat;
  double? lon;
  double? speed;
  double? speedKmh;
  double? speedKn;
  double? heading;
  double? externalvoltage;

  Airtime({
    this.mobileId,
    this.idfull,
    this.namaKapal,
    this.sn,
    this.imei,
    this.kategori,
    this.type,
    this.custamer,
    this.timestamp,
    this.broadcast,
    this.lat,
    this.lon,
    this.speed,
    this.speedKmh,
    this.speedKn,
    this.heading,
    this.powerstatus,
    this.externalvoltage,
    this.atp_start,
    this.atp_end,
  });

  factory Airtime.fromJson(Map<String, dynamic> json) {
    return Airtime(
      mobileId: json['mobile_id'],
      idfull: json['idfull'],
      namaKapal: json['nama_kapal'],
      sn: json['sn'],
      imei: json['imei'],
      kategori: json['kategori'],
      type: json['type'],
      custamer: json['custamer'],
      timestamp: json['timestamp'],
      broadcast: json['broadcast'],
      lat: json['lat'],
      lon: json['lon'],
      speed: json['speed'],
      speedKmh: json['speed_kmh'],
      speedKn: json['speed_kn'],
      heading: json['heading'],
      powerstatus: json['powerstatus'],
      externalvoltage: json['externalvoltage'],
      atp_start: json['atp_start'],
      atp_end: json['atp_end'],
    );
  }

  @override
  String toString() {
    return 'Airtime{mobile_id: $mobileId, idfull: $idfull, namaKapal: $namaKapal, sn: $sn, imei: $imei, kategori: $kategori, type: $type, custamer: $custamer, lat: $lat, lon: $lon, speed: $speed, heading: $heading, powerstatus: $powerstatus, externalvoltage: $externalvoltage, timestamp: $timestamp, atp_start: $atp_start, atp_end: $atp_end}';
  }
  // String toStringWithFormattedDates(DateFormat formatter) {
  //   return 'Airtime{idfull: $idfull, namaKapal: $namaKapal, sn: $sn, imei: $imei, kategori: $kategori, type: $type, custamer: $custamer, lat: $lat, lon: $lon, speed: $speed, heading: $heading, powerstatus: $powerstatus, externalvoltage: $externalvoltage, timestamp: ${formatter.format(timestamp?.toLocal())}, atp_start: ${formatter.format(atp_start?.toLocal())}, atp_end: ${formatter.format(atp_end?.toLocal())}}';
  // }
}
