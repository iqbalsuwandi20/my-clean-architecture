import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, List<ProfileEntity>>> getAllUser(int page);
  Future<Either<Failure, ProfileEntity>> getUser(int id);
}
