// ignore_for_file: non_constant_identifier_names

class NotificationModel {
  int? id;
  String? judul;
  String? teksNotification;
  DateTime? createAt;

  NotificationModel({
    this.id,
    this.judul,
    required this.teksNotification,
    this.createAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      judul: json['judul'],
      teksNotification: json['teks'],
      createAt: DateTime.parse(json['create_at']),
    );
  }

  @override
  String toString() {
    return 'notification{id: $id, judul: $judul, teks: $teksNotification, create_at: $createAt}';
  }
}