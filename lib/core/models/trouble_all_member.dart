// ignore_for_file: non_constant_identifier_names

class TroubleAllMember {
  int? id;
  int? memberId;
  String? nameMember;
  String? emailMember;
  String? idfull;
  String? keluhan;
  DateTime? createAt;
  int? status;
  String? namaKapal;
  String? kategori;
  String? type;
  String? custamer;

  TroubleAllMember({
    this.id,
    this.memberId,
    this.nameMember,
    this.emailMember,
    this.idfull,
    this.keluhan,
    this.createAt,
    this.status,
    this.namaKapal,
    this.kategori,
    this.type,
    this.custamer,
  });

  factory TroubleAllMember.fromJson(Map<String, dynamic> json) {
    return TroubleAllMember(
      id: json['id'],
      memberId: json['member_id'],
      nameMember: json['nameMember'],
      emailMember: json['emailMember'],
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
}
