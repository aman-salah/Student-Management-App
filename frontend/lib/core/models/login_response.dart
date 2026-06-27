class LoginResponse {
  final String accessToken;
  final String tokenType;
  final String username;
  final String email;

  LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.username,
    required this.email,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      username: json["username"],
      email: json["email"],
    );
  }
}
