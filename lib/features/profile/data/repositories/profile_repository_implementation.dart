import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImplementation extends ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ProfileLocalDataSource profileLocalDataSource;
  final HiveInterface hiveInterface;

  ProfileRepositoryImplementation({
    required this.profileRemoteDataSource,
    required this.profileLocalDataSource,
    required this.hiveInterface,
  });

  @override
  Future<Either<Failure, List<ProfileEntity>>> getAllUser(int page) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        List<ProfileModel> result =
            await profileLocalDataSource.getAllUser(page);
        return right(result);
      } else {
        List<ProfileModel> result =
            await profileRemoteDataSource.getAllUser(page);

        var box = hiveInterface.box('profile_box');
        box.put('getAllUser', result);

        return right(result);
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> getUser(int id) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        ProfileModel result = await profileLocalDataSource.getUser(id);
        return right(result);
      } else {
        ProfileModel result = await profileRemoteDataSource.getUser(id);

        var box = hiveInterface.box('profile_box');
        box.put('getUser', result);

        return right(result);
      }
    } catch (e) {
      return Left(Failure());
    }
  }
}
