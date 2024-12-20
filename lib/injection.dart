import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'features/profile/data/datasources/profile_local_data_source.dart';
import 'features/profile/data/datasources/profile_remote_data_source.dart';
import 'features/profile/data/models/profile_model.dart';
import 'features/profile/data/repositories/profile_repository_implementation.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/get_all_user.dart';
import 'features/profile/domain/usecases/get_user.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';

var myInjection = GetIt.instance;

Future<void> init() async {
  Hive.registerAdapter(ProfileModelAdapter());
  var box = await Hive.openBox('profile_box');

  myInjection.registerLazySingleton(() => box);

  myInjection.registerLazySingleton(
    () => http.Client(),
  );

  myInjection.registerFactory(
    () => ProfileBloc(
      getAllUsers: myInjection(),
      getUser: myInjection(),
    ),
  );

  myInjection.registerLazySingleton(
    () => GetAllUser(
      profileRepository: myInjection(),
    ),
  );

  myInjection.registerLazySingleton(
    () => GetUser(
      profileRepository: myInjection(),
    ),
  );

  myInjection.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImplementation(
      profileRemoteDataSource: myInjection(),
      profileLocalDataSource: myInjection(),
      box: box,
    ),
  );

  myInjection.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImplementation(
      box: box,
    ),
  );

  myInjection.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImplementation(
      client: myInjection(),
    ),
  );
}
