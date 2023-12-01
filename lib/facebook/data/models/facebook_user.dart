import 'dart:convert';

class FacebookUser {
  final String name;
  final String id;
  final String profileUrl;
  final String? email;

  FacebookUser({
    required this.name,
    required this.id,
    required this.profileUrl,
    this.email,
  });

  FacebookUser copyWith({
    String? name,
    String? id,
    String? profileUrl,
    String? email,
  }) {
    return FacebookUser(
      name: name ?? this.name,
      id: id ?? this.id,
      profileUrl: profileUrl ?? this.profileUrl,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'profileUrl': profileUrl,
      'email': email,
    };
  }

  factory FacebookUser.fromMap(Map<String, dynamic> map) {
    return FacebookUser(
      name: map['name'] as String,
      id: map['id'] as String,
      profileUrl: map['picture']['data']['url'] as String,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FacebookUser.fromJson(source) => FacebookUser.fromMap(source);

  @override
  String toString() {
    return 'FacebookUser(name: $name, id: $id, profileUrl: $profileUrl, email: $email)';
  }

  @override
  bool operator ==(covariant FacebookUser other) {
    if (identical(this, other)) return true;

    return other.name == name && other.id == id && other.profileUrl == profileUrl && other.email == email;
  }

  @override
  int get hashCode {
    return name.hashCode ^ id.hashCode ^ profileUrl.hashCode ^ email.hashCode;
  }
}
