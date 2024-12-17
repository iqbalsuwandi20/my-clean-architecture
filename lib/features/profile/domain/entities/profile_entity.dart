import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final int id;
  final String email;
  final String fullName;
  final String avatarUrl;

  const ProfileEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        avatarUrl,
      ];
}
