class SigninModel {
  String? uid;
  final String id;
  final String email;
  final String password;

  SigninModel({
    this.uid,
    required this.email,
    required this.password,
    required this.id,
  });
}
