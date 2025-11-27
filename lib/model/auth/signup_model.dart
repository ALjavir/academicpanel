class SignupModel {
  String? uid;
  final int id;
  final String firstName;
  final String lastName;
  final String department;
  final int phone;
  final String address;
  final String password;
  final String email;

  SignupModel({
    this.uid,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.phone,
    required this.address,
    required this.password,
    required this.email,
  });

  // Convert model → Firestore JSON
  Map<String, dynamic> toJson() => {
    'uid': uid,
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'department': department,
    'phone': phone,
    'address': address,
    'email': email,
  };

  // Convert Firestore JSON → model
  factory SignupModel.fromJson(Map<String, dynamic> data) => SignupModel(
    uid: data['uid'],
    email: data['email'] ?? '',
    firstName: data['first_name'] ?? '',
    lastName: data['last_name'] ?? '',
    password: data['password'] ?? '',
    address: data['address'] ?? '',
    department: data['department'] ?? '',
    phone: data['phone'] is int
        ? data['phone']
        : int.tryParse('${data['phone']}') ?? 0,
    id: data['id'] is int ? data['id'] : int.tryParse('${data['id']}') ?? 0,
  );

  // Copy existing model with edited values
  SignupModel copyWith({
    String? uid,
    int? id,
    String? firstName,
    String? lastName,
    String? department,
    int? phone,
    String? address,
    String? email,
    String? password,
  }) {
    return SignupModel(
      uid: uid ?? this.uid,
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      department: department ?? this.department,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
