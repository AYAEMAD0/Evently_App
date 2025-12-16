part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserEntity user;
  ProfileSuccess(this.user);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
