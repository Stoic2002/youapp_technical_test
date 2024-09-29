part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final AuthModel authModel;

  const RegisterEvent({required this.authModel});

  @override
  List<Object> get props => [authModel];
}

class LoginEvent extends AuthEvent {
  final AuthModel authModel;

  const LoginEvent({required this.authModel});

  @override
  List<Object> get props => [authModel];
}

class CheckAuthStatusEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
