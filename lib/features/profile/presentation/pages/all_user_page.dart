import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/profile_entity.dart';
import '../bloc/profile_bloc.dart';

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
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: context.read<ProfileBloc>()
          ..add(
            ProfileEventGetAllUsers(2),
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
          } else if (state is ProfileStateLoadedAllUsers) {
            List<ProfileEntity> allUsers = state.allUsers;
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: allUsers.length,
              itemBuilder: (context, index) {
                ProfileEntity profileEntity = allUsers[index];
                return ListTile(
                  onTap: () {
                    context.pushNamed(
                      'detail_user',
                      extra: profileEntity.id,
                    );
                  },
                  title: Text(profileEntity.fullName),
                  subtitle: Text(profileEntity.id.toString()),
                );
              },
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
