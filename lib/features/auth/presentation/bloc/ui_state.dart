part of 'ui_bloc.dart';

@immutable
sealed class UiState {
  
}

final class UiInitial extends UiState {
    final bool obscureText;
  final bool rememberMe;

  UiInitial({this.obscureText = true, this.rememberMe = false});
}
