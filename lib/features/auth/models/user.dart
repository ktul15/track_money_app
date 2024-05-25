class AppUser {
  final String uid;
  final String name;
  final String email;

  const AppUser({required this.uid, required this.name, required this.email});

  AppUser copyWith(
    String? name,
    String? email,
  ) {
    return AppUser(
        uid: uid, name: name ?? this.name, email: email ?? this.email);
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map["uid"] ?? '',
      name: map['name'] ?? '',
      email: map["email"] ?? '',
    );
  }
}
