part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {
  final bool rememberMe;
  final bool obscureText;

  AuthInitial({this.rememberMe = false, this.obscureText = true});

  AuthInitial copyWith({bool? rememberMe, bool? obscureText}) {
    return AuthInitial(
      rememberMe: rememberMe ?? this.rememberMe,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}

final class AuthLoading extends AuthState {}

final class AuthLoggedIn extends AuthState {
  final Auth auth;
  AuthLoggedIn(this.auth);
}

final class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
