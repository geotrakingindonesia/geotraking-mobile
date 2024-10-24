// ignore_for_file: non_constant_identifier_names
class TroubleMember {
  int? id;
  int? memberId;
  String? idfull;
  String? keluhan;
  DateTime? createAt;
  int? status;
  String? namaKapal;
  String? kategori;
  String? type;
  String? custamer;

  TroubleMember({
    this.id,
    this.memberId,
    this.idfull,
    this.keluhan,
    this.createAt,
    this.status,
    this.namaKapal,
    this.kategori,
    this.type,
    this.custamer,
  });

  factory TroubleMember.fromJson(Map<String, dynamic> json) {
    return TroubleMember(
      id: json['id'],
      memberId: json['member_id'],
      idfull: json['idfull'],
      keluhan: json['keluhan'],
      createAt: json['create_at'],
      status: json['status'],
      namaKapal: json['nama_kapal'],
      kategori: json['kategori'],
      type: json['type'],
      custamer: json['custamer'],
    );
  }

  @override
  String toString() {
    return 'trouble member{id: $id, member_id: $memberId, idfull: $idfull, keluhan: $keluhan, create_at: $createAt, status: $status, nama_kapal: $namaKapal, kategori: $kategori, type: $type, custamer: $custamer}';
  }
}
