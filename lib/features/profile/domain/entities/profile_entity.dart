import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

// part 'profile_entity.g.dart';

@HiveType(typeId: 0)
class ProfileEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String fullName;
  @HiveField(3)
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
