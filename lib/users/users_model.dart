class User {
  final String userId;
  final String firstName;
  final String gender;
  final String location;
  final String role;
  final String bio;
  final String learningType;
  final String studyPlace;
  final String academicLevel;
  final String profilePicture;

  User({
    required this.userId,
    required this.firstName,
    required this.gender,
    required this.location,
    required this.role,
    required this.bio,
    required this.learningType,
    required this.studyPlace,
    required this.academicLevel,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      firstName: json['first_name'],
      gender: json['gender'],
      location: json['location'],
      role: json['role'],
      bio: json['bio'],
      learningType: json['learningType'],
      studyPlace: json['studyPlace'],
      academicLevel: json['academicLevel'],
      profilePicture: json['profilePicture'], // buat image url tapi belom kepake
    );
  }
}
