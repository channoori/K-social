class LoginInfo {
  final String email;
  final String profile;
  final String name;
  final String token;

  LoginInfo({
    required this.email,
    required this.profile,
    required this.name,
    required this.token,
  });

  LoginInfo copyWith({
    String? email,
    String? profile,
    String? name,
    String? token,
  }) {
    return LoginInfo(
      email: email ?? this.email,
      profile: profile ?? this.profile,
      name: name ?? this.name,
      token: token ?? this.token,
    );
  }

  static LoginInfo empty() {
    return LoginInfo(email: '', profile: '', name: '', token: '');
  }
}
