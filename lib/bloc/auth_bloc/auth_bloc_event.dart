part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthStatusChanged extends AuthEvent {
  final User? user;
  AuthStatusChanged(this.user);
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  AuthLoginRequested(this.email, this.password);
}

class AuthSignupRequested extends AuthEvent {
  final String email;
  final String password;
  AuthSignupRequested(this.email, this.password);
}

class AuthLogoutRequested extends AuthEvent {}
