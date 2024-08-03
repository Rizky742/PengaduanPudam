part of 'periode_bloc.dart';

@immutable
sealed class PeriodeEvent {}

final class SetPeriodeEvent extends PeriodeEvent {
  final DateTime selectPeriode;

  SetPeriodeEvent(this.selectPeriode);
}

final class PeriodeSet extends PeriodeEvent {
  final DateTime selectPeriode;

  PeriodeSet(this.selectPeriode);

}
