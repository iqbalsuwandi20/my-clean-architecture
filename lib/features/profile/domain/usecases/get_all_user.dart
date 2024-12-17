import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetAllUser {
  final ProfileRepository profileRepository;

  GetAllUser({required this.profileRepository});

  Future<Either<Failure, List<ProfileEntity>>> excute(int page) async {
    return await profileRepository.getAllUser(page);
  }
}
