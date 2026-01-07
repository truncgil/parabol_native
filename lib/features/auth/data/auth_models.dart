import 'package:json_annotation/json_annotation.dart';

part 'auth_models.g.dart';

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class LoginResponse {
  final bool success;
  final LoginData? data;

  LoginResponse({required this.success, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
}

@JsonSerializable()
class LoginData {
  final String token;
  final String token_type;

  LoginData({required this.token, required this.token_type});

  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);
}
