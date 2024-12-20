import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/profile/data/models/profile_model.dart';
import 'obsever.dart';

import 'core/app/app.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileModelAdapter());

  Bloc.observer = MyObsever();

  runApp(const App());
}
