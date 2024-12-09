// ignore_for_file: non_constant_identifier_names

class TransactionAirtime {
  int? id;
  int? memberId;
  String? mobileId;
  String? price;
  DateTime? paymentDate;
  int? status;
  String? idfull;
  String? namaKapal;
  String? kategori;
  String? type;
  String? custamer;

  TransactionAirtime({
    this.id,
    this.memberId,
    this.mobileId,
    this.price,
    this.paymentDate,
    this.status,
    this.idfull,
    this.namaKapal,
    this.kategori,
    this.type,
    this.custamer,
  });

  factory TransactionAirtime.fromJson(Map<String, dynamic> json) {
    return TransactionAirtime(
      id: json['id'],
      memberId: json['member_id'],
      mobileId: json['mobile_id'],
      price: json['price'],
      paymentDate: json['payment_date'],
      status: json['status'],
      idfull: json['idfull'],
      namaKapal: json['nama_kapal'],
      kategori: json['kategori'],
      type: json['type'],
      custamer: json['custamer'],
    );
  }

  @override
  String toString() {
    return 'status payment member{id: $id, member_id: $memberId, idfull: $idfull, payment_date: $paymentDate, status: $status, nama_kapal: $namaKapal, kategori: $kategori, type: $type, custamer: $custamer}';
  }
}
