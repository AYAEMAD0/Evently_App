
import '../../../domain/entities/user_entity.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthSuccess extends AuthState {
  final UserEntity? user;
  final String? message;
  AuthSuccess({this.user,this.message});
}
final class AuthError extends AuthState {
  final String messageError;
  AuthError({required this.messageError});
}
