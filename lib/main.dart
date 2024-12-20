import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'injection.dart';
import 'obsever.dart';

void main() async {
  await Hive.initFlutter();

  await init();

  Bloc.observer = MyObsever();

  runApp(const App());
}
