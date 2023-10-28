import 'dart:convert';

class AuthResponseModel {
  final String? jwt;
  final User? user;
  final Error? error;

  AuthResponseModel({
    this.jwt,
    this.user,
    this.error,
  });

  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        jwt: json["jwt"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        error: json["error"] == null ? null : Error.fromMap(json["error"]),
      );

  Map<String, dynamic> toMap() => {
        "jwt": jwt,
        "user": user?.toMap(),
        "error": error?.toMap(),
      };
}

class User {
  final int? id;
  final String? username;
  final String? email;
  final String? provider;
  final bool? confirmed;
  final bool? blocked;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "blocked": blocked,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Error {
    final int? status;
    final String? name;
    final String? message;    

    Error({
        this.status,
        this.name,
        this.message,        
    });

    factory Error.fromJson(String str) => Error.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Error.fromMap(Map<String, dynamic> json) => Error(
        status: json["status"],
        name: json["name"],
        message: json["message"],        
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "name": name,
        "message": message,        
    };
}
