class TroubleMemberDetail {
  int? troubleMemberId;
  int? adminId;
  int? userGeoId;
  int? memberId;
  String? respon;
  String? responMember;
  DateTime? createAt;
  DateTime? createAtMember;
  String? nameUser;
  String? nameAdmin;
  String? nameMember;
  int? isAdminMember;

  TroubleMemberDetail({
    this.troubleMemberId,
    this.adminId,
    this.userGeoId,
    this.memberId,
    this.respon,
    this.responMember,
    this.createAt,
    this.createAtMember,
    this.nameUser,
    this.nameAdmin,
    this.nameMember,
    this.isAdminMember,
  });

  factory TroubleMemberDetail.fromJson(Map<String, dynamic> json) {
    return TroubleMemberDetail(
      troubleMemberId: json['trouble_member_id'],
      adminId: json['admin_id'],
      userGeoId: json['user_geo_id'],
      memberId: json['member_id'],
      respon: json['respon'],
      responMember: json['responMember'],
      createAt: json['create_at'],
      createAtMember: json['create_at_member'],
      nameUser: json['nameUser'],
      nameAdmin: json['nameAdmin'],
      nameMember: json['nameMember'],
      isAdminMember: json['is_admin_member'],
    );
  }

  @override
  String toString() {
    return 'trouble member detail{trouble_member_id: $troubleMemberId, admin_id: $adminId, user_geo_id: $userGeoId, member_id: $memberId, respon: $respon, respon_member: $responMember, create_at: $createAt, create_at_member: $createAtMember, nameUser: $nameUser, nameAdmin: $nameAdmin, nameMember: $nameMember, is_admin_member: $isAdminMember}';
  }
}