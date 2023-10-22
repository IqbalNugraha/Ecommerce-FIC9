import 'dart:convert';

class LoginRequestModel {
  final String identifier;
  final String password;
  LoginRequestModel({
    required this.identifier,
    required this.password,
  });

  LoginRequestModel copyWith({
    String? identifier,
    String? password,
  }) {
    return LoginRequestModel(
      identifier: identifier ?? this.identifier,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identifier': identifier,
      'password': password,
    };
  }

  factory LoginRequestModel.fromMap(Map<String, dynamic> map) {
    return LoginRequestModel(
      identifier: map['identifier'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequestModel.fromJson(String source) =>
      LoginRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
