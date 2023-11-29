class AccessToken {
  /// DateTime with the expires date of this token
  final DateTime expirationDate;

  /// DateTime with the last refresh date of this token
  final DateTime refreshDate;

  /// the facebook user id
  final String userId;

  /// token provided by facebook to make api calls to the GRAPH API
  final String token;

  /// the facebook application Id
  final String appID;

  /// the graph Domain name returned by facebook
  final String? graphDomain;

  /// list of string with the rejected permission by the user (on Web is null)
  final List<String>? declinedPermissions;

  /// list of string with the approved permission by the user (on Web is null)
  final List<String>? permissions;

  /// is `true` when the token is expired
  final bool isExpired;

  /// DateTime with the date at which user data access expires
  final DateTime dataAccessExpirationDate;

  AccessToken({
    required this.declinedPermissions,
    required this.permissions,
    required this.userId,
    required this.expirationDate,
    required this.refreshDate,
    required this.token,
    required this.appID,
    this.graphDomain,
    required this.isExpired,
    required this.dataAccessExpirationDate,
  });

  /// convert the data provided for the platform channel to one instance of AccessToken
  ///
  /// [json] data returned by the platform channel
  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
      userId: json['userId'],
      token: json['tokenString'],
      expirationDate: DateTime.parse(json['expirationDate']),
      refreshDate: DateTime.parse(json['refreshDate']),
      appID: json['appID'],
      graphDomain: json['graphDomain'],
      isExpired: json['isExpired'],
      declinedPermissions: json['declinedPermissions'] != null ? List<String>.from(json['declinedPermissions']) : null,
      permissions: json['permissions'] != null ? List<String>.from(json['permissions']) : null,
      dataAccessExpirationDate: DateTime.parse(json['dataAccessExpirationDate']),
    );
  }

  /// convert this instance to one Map
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'token': token,
        'expirationDate': expirationDate,
        'refreshDate': refreshDate,
        'appID': appID,
        'graphDomain': graphDomain,
        'isExpired': isExpired,
        'permissions': permissions,
        'declinedPermissions': declinedPermissions,
        'dataAccessExpirationDate': dataAccessExpirationDate,
      };
}
