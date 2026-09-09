class AppUser {
  final String uid;
  final String name;
  final String phone;
  final String role;

  AppUser({
    required this.uid,
    required this.name,
    required this.phone,
    required this.role,
  });

  factory AppUser.fromMap(String uid, Map<String, dynamic> map) {
    return AppUser(
      uid: uid,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? 'customer',
    );
  }
}