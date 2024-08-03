part of 'penugasan_bloc.dart';

@immutable
sealed class PenugasanEvent {}

final class LoadPenugasan extends PenugasanEvent {}

final class SelectPetugas extends PenugasanEvent {
  final String petugas;

  SelectPetugas(this.petugas);
}

final class SelectDate extends PenugasanEvent {
   final String day;
  final String month;
  final String year;

  SelectDate(this.day, this.month, this.year);
}

