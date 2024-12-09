// // ignore_for_file: non_constant_identifier_names

// class KapalMember {
//   int? id;
//   int? memberId;
//   String? idfull;
//   DateTime? createAt;
//   String? namaKapal;
//   String? kategori;
//   String? type;
//   String? custamer;
//   String? mobileId;
//   String? sn;
//   String? imei;
//   String? powerstatus;
//   String? externalvoltage;
//   String? heading;
//   String? speed;
//   // DateTime? timestamp;
//   // DateTime? broadcast;
//   // DateTime? atpStart;
//   // DateTime? atpEnd;
//   String? timestamp;
//   String? broadcast;
//   String? atpStart;
//   String? atpEnd;
//   String? lat;
//   String? lon;

//   KapalMember({
//     this.id,
//     this.memberId,
//     this.idfull,
//     this.createAt,
//     this.namaKapal,
//     this.kategori,
//     this.type,
//     this.custamer,
//     this.mobileId,
//     this.sn,
//     this.imei,
//     this.heading,
//     this.speed,
//     this.powerstatus,
//     this.externalvoltage,
//     this.timestamp,
//     this.broadcast,
//     this.atpStart,
//     this.atpEnd,
//     this.lat,
//     this.lon,
//   });

//   factory KapalMember.fromJson(Map<String, dynamic> json) {
//     return KapalMember(
//       id: json['id'],
//       memberId: json['member_id'],
//       idfull: json['idfull'],
//       createAt: json['create_at'],
//       namaKapal: json['nama_kapal'],
//       kategori: json['kategori'],
//       type: json['type'],
//       custamer: json['custamer'],
//       mobileId: json['mobileId'],
//       sn: json['sn'],
//       imei: json['imei'],
//       powerstatus: json['powerstatus'],
//       externalvoltage: json['externalvoltage'],
//       heading: json['heading'],
//       speed: json['speed'],
//       timestamp: json['timestamp'],
//       broadcast: json['broadcast'],
//       atpStart: json['atp_start'],
//       atpEnd: json['atp_end'],
//       // lat: double.tryParse(json['lat']),
//       // lon: double.tryParse(json['lon']),
//       lat: json['lat'],
//       lon: json['lon'],
//     );
//   }

//   @override
//   String toString() {
//     return 'kapal{id: $id, member_id: $memberId, idfull: $idfull, externalvoltage: $externalvoltage, powerstatus: $powerstatus, create_at: $createAt, nama_kapal: $namaKapal, speed: $speed, kategori: $kategori, type: $type, heading: $heading, custamer: $custamer, timestamp: $timestamp, lat: $lat, lon: $lon, sn: $sn, imei: $imei, atp_start: $atpStart, atp_end: $atpEnd}';
//   }
// }
