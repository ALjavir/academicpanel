class UserModel {
  String? uid;
  String? image;
  final String id;
  final String firstName;
  final String lastName;
  final String department;
  final int phone;
  final String address;
  final String password;
  final String email;
  Map<String, String>? courses;

  UserModel({
    this.uid,
    this.image,
    this.courses,
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
    'image': image,
    'courses': courses,
    'first_name': firstName,
    'last_name': lastName,
    'department': department,
    'phone': phone,
    'address': address,
    'email': email,
  };

  // Convert Firestore JSON → model
  factory UserModel.fromJson(Map<String, dynamic> data) => UserModel(
    uid: data['uid'],
    image: data['image'],
    //image: _convertToDirectLink(data['image'].toString()),
    courses: data['courses'] != null
        ? Map<String, String>.from(data['courses'])
        : null,

    email: data['email'] ?? '',
    firstName: data['first_name'] ?? '',
    lastName: data['last_name'] ?? '',
    password: data['password'] ?? '',
    address: data['address'] ?? '',
    department: data['department'] ?? '',
    phone: data['phone'] is int
        ? data['phone']
        : int.tryParse('${data['phone']}') ?? 0,
    id: data['id'] ?? '',
  );

  // Copy existing model with edited values
  UserModel copyWith({
    String? uid,
    String? image,
    Map<String, String>? courses,

    String? id,
    String? firstName,
    String? lastName,
    String? department,
    int? phone,
    String? address,
    String? email,
    String? password,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      image: image ?? this.image,
      courses: courses ?? this.courses,
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

  // static String _convertToDirectLink(String link) {
  //   final regex = RegExp(r'd/([^/]+)/'); // Matches "d/<fileId>/"
  //   final altRegex = RegExp(r'id=([^&]+)'); // Matches "id=<fileId>"

  //   if (regex.hasMatch(link)) {
  //     final match = regex.firstMatch(link);
  //     final fileId = match?.group(1);
  //     return 'https://drive.google.com/uc?export=view&id=$fileId';
  //   } else if (altRegex.hasMatch(link)) {
  //     final match = altRegex.firstMatch(link);
  //     final fileId = match?.group(1);
  //     return 'https://drive.google.com/uc?export=view&id=$fileId';
  //   } else {
  //     return link;
  //   }
  // }
}
