import 'package:hive/hive.dart';

import '../models/profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUser(int id);
}

class ProfileLocalDataSourceImplementation extends ProfileLocalDataSource {
  ProfileLocalDataSourceImplementation({required this.hiveInterface});
  final HiveInterface hiveInterface;

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    var box = hiveInterface.box('profile_box');
    return box.get('getAllUser');
  }

  @override
  Future<ProfileModel> getUser(int id) async {
    var box = hiveInterface.box('profile_box');
    return box.get('getUser');
  }
}
