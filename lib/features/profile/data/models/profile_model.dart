import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  final String firstName;
  final String lastName;
  final String avatar;

  const ProfileModel({
    required super.id,
    required super.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  }) : super(
          fullName: "$firstName $lastName",
          avatarUrl: avatar,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> data) {
    return ProfileModel(
      id: data['data'],
      email: data['email'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      avatar: data['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }

  static List<ProfileModel> fromJsonList(List data) {
    if (data.isEmpty) return [];

    return data.map((e) => ProfileModel.fromJson(e)).toList();
  }
}
