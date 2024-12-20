import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/my_router.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'injection.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => myInjection<ProfileBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: MyRouter().router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
