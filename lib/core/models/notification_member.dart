// // ignore_for_file: non_constant_identifier_names

// class NotificationMember {
//   int? id;
//   int? memberId;
//   int? tujuan;
//   int? readStatus;
//   String? judul;
//   String? teksNotification;
//   DateTime? createAt;

//   NotificationMember({
//     this.id,
//     this.memberId,
//     this.tujuan,
//     this.readStatus,
//     this.judul,
//     required this.teksNotification,
//     this.createAt,
//   });

//   factory NotificationMember.fromJson(Map<String, dynamic> json) {
//     return NotificationMember(
//       id: json['id'],
//       memberId: json['member_id'],
//       tujuan: json['tujuan'],
//       readStatus: json['read_status'],
//       judul: json['judul'],
//       teksNotification: json['teks'],
//       createAt: DateTime.parse(json['create_at']),
//     );
//   }

//   @override
//   String toString() {
//     return 'notification{id: $id, member_id: $memberId, tujuan: $tujuan, read_status: $readStatus, judul: $judul, teks: $teksNotification, create_at: $createAt}';
//   }
// }