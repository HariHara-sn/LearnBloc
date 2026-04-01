class UserModel {
  final String name;
  final String email;
  final String photoUrl;

  UserModel({
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  factory UserModel.fromGoogleSignIn({
    required String name,
    required String email,
    required String photoUrl,
  }) {
    return UserModel(
      name: name,
      email: email,
      photoUrl: photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  @override
  String toString() =>
      'UserModel(name: $name, email: $email, photoUrl: $photoUrl)';
}