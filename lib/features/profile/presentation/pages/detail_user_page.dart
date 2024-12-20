import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailUserPage extends StatelessWidget {
  final int userId;

  const DetailUserPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Detail User $userId',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          )),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
          ),
          SizedBox(height: 30),
          Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('ID:'),
                  SizedBox(height: 10),
                  Text('Fullname:'),
                  SizedBox(height: 10),
                  Text('Email:'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
