import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetUser {
  final ProfileRepository profileRepository;

  GetUser({required this.profileRepository});

  Future<Either<Failure, ProfileEntity>> excute(int id) async {
    return await profileRepository.getUser(id);
  }
}
