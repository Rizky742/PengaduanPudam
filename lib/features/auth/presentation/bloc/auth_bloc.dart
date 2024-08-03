import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pengaduan/features/auth/domain/entities/auth.dart';
import 'package:pengaduan/features/auth/domain/usecases/sign_in.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn signIn;
  AuthBloc(this.signIn) : super(AuthInitial()) {
    on<LoginEvent>(
      (event, emit) async {
        emit(AuthLoading());
        // await Future.delayed(const Duration(seconds: 1));
        final failureOrUser =
            await signIn.call(username: event.email, password: event.password);
        failureOrUser.fold((failure) {
          emit(AuthError(failure.message));
        }, (auth) => emit(AuthLoggedIn(auth)));
      },
    );
  }
}
