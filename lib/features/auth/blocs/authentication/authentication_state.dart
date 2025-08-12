part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationSuccessState extends AuthenticationState {
  AuthenticationSuccessState();

  @override
  List<Object?> get props => [];
}

class AuthenticationErrorState extends AuthenticationState {
  final String error;

  AuthenticationErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class UnAuthenticationState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
