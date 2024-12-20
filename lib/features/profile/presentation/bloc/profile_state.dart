part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {}

class ProfileStateEmpty extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileStateLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileStateError extends ProfileState {
  final String message;

  ProfileStateError(this.message);

  @override
  List<Object?> get props => [
        message,
      ];
}

class ProfileStateLoadedAllUsers extends ProfileState {
  final List<ProfileEntity> allUsers;

  ProfileStateLoadedAllUsers(this.allUsers);

  @override
  List<Object?> get props => [
        allUsers,
      ];
}

class ProfileStateLoadedDetailUser extends ProfileState {
  final ProfileEntity detailUser;

  ProfileStateLoadedDetailUser(this.detailUser);

  @override
  List<Object?> get props => [
        detailUser,
      ];
}
