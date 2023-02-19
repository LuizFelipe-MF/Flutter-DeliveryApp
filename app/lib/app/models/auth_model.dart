import 'dart:convert';

class AuthModel {
  final String accessToken;
  final String refreshToken;

  AuthModel({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      accessToken: map['access_token'] as String,
      refreshToken: map['refresh_token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
