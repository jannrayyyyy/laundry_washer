part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class Authenticating extends AuthState {}

class UnAuthenticated extends AuthState {}

class Error extends AuthState {}
