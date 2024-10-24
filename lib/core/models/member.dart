class MemberUser {
  int id;
  String name, email, noHp;
  int isAdmin;
  String? avatar;

  MemberUser({
    required this.id,
    required this.name,
    required this.email,
    required this.noHp,
    required this.isAdmin,
    this.avatar,
  });

  factory MemberUser.fromJson(Map<String, dynamic> json) {
    return MemberUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      noHp: json['no_hp'] ?? '',
      isAdmin: json['is_admin'],
      avatar: json['avatar'] ?? '',
    );
  }
}
