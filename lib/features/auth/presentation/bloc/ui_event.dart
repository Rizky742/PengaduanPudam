part of 'ui_bloc.dart';

@immutable
sealed class UiEvent {}

final class ToggleObscureTextEvent extends UiEvent {}

final class ToggleRememberMeEvent extends UiEvent {}
