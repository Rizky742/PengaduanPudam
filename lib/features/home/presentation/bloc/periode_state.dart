part of 'periode_bloc.dart';

@immutable
sealed class PeriodeState {}

final class PeriodeInitial extends PeriodeState {}

final class PeriodeSetted extends PeriodeState {
  final DateTime periode;

  PeriodeSetted(this.periode);
}

