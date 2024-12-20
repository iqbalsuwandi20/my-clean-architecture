import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_clean_architecture/obsever.dart';

import 'core/app/app.dart';

void main() async {
  Bloc.observer = MyObsever();
  runApp(const App());
}
