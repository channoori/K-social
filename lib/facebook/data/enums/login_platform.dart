enum LoginPlatform {
  facebook('facebook'),
  unknown('unknown');

  final String _title;

  get title => _title;

  const LoginPlatform(this._title);

  static LoginPlatform fromString(String platform) {
    switch (platform) {
      case 'facebook':
        return LoginPlatform.facebook;
      default:
        return LoginPlatform.unknown;
    }
  }
}
