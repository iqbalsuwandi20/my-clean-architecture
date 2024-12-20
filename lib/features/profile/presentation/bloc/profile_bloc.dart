import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/get_all_user.dart';
import '../../domain/usecases/get_user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetAllUser getAllUsers;
  final GetUser getUser;

  ProfileBloc({required this.getAllUsers, required this.getUser})
      : super(ProfileStateEmpty()) {
    on<ProfileEventGetAllUsers>(
      (event, emit) async {
        emit(ProfileStateLoading());
        Either<Failure, List<ProfileEntity>> resultGetAllUsers =
            await getAllUsers.excute(event.page);

        resultGetAllUsers.fold(
          (leftResultAllUsers) {
            emit(ProfileStateError('Cannot get all users'));
          },
          (rightResultAllUsers) {
            emit(ProfileStateLoadedAllUsers(rightResultAllUsers));
          },
        );
      },
    );

    on<ProfileEventGetDetailUser>(
      (event, emit) async {
        emit(ProfileStateLoading());
        Either<Failure, ProfileEntity> resultGetUser =
            await getUser.excute(event.userId);

        resultGetUser.fold(
          (leftResultGetUser) {
            emit(ProfileStateError('Cannot get user'));
          },
          (rightResultGetUser) {
            emit(ProfileStateLoadedDetailUser(rightResultGetUser));
          },
        );
      },
    );
  }
}
