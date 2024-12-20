import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllUserPage extends StatelessWidget {
  const AllUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All User'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              context.pushNamed(
                'detail_user',
                extra: index + 1,
              );
            },
            title: Text('${index + 1}'),
          );
        },
      ),
    );
  }
}
