class UserModel {
  final String id;
  final String name;
  final int age;
  final String profileImageUrl;
  final String location;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.profileImageUrl,
    required this.location,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      profileImageUrl: json['profileImageUrl'] ?? '',
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'profileImageUrl': profileImageUrl,
      'location': location,
    };
  }

  String get displayName => '$name, $age';
}