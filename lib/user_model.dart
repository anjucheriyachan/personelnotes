class UserModel {
  final String email;
  final String password;

  UserModel({required this.email, required this.password});

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password, // ⚠ Only for demonstration. Do not store in plain text!
    };
  }

  // Create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
    );
  }
}
