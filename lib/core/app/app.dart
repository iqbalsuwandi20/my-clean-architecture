import 'package:flutter/material.dart';

import '../my_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: MyRouter().router,
      debugShowCheckedModeBanner: false,
    );
  }
}
