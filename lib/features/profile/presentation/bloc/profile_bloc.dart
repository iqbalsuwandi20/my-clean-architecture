import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_clean_architecture/core/error/failure.dart';
import 'package:my_clean_architecture/features/profile/domain/entities/profile_entity.dart';
import 'package:my_clean_architecture/features/profile/domain/usecases/get_all_user.dart';
import 'package:my_clean_architecture/features/profile/domain/usecases/get_user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetAllUser getAllUsers;
  final GetUser getUser;

  ProfileBloc(this.getAllUsers, this.getUser) : super(ProfileStateEmpty()) {
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
