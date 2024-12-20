import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../domain/entities/profile_entity.dart';
import '../bloc/profile_bloc.dart';

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
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: myInjection<ProfileBloc>()
          ..add(
            ProfileEventGetDetailUser(userId),
          ),
        builder: (context, state) {
          if (state is ProfileStateLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
              ),
            );
          } else if (state is ProfileStateError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ProfileStateLoadedDetailUser) {
            ProfileEntity profileEntity = state.detailUser;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profileEntity.avatarUrl),
                ),
                const SizedBox(height: 30),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('ID:${profileEntity.id}'),
                        const SizedBox(height: 10),
                        Text('Fullname: ${profileEntity.fullName}'),
                        const SizedBox(height: 10),
                        Text('Email: ${profileEntity.email}'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Empty Data'.toUpperCase()),
            );
          }
        },
      ),
    );
  }
}
