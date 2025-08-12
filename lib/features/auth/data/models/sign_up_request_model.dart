class SignUpRequestBody {
  final String username;
  final String birthDay;
  final String password;
  final String phoneNumber;
  final String fullName;

  SignUpRequestBody({
    required this.username,
    required this.birthDay,
    required this.password,
    required this.phoneNumber,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'birthDay': birthDay,
      'password': password,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
    };
  }
}
