import 'dart:developer';

import 'package:bloc/bloc.dart';

class MyObsever extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('Bloc: $bloc --> $change');
  }
}
