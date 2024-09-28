part of 'get_penugasan_bloc.dart';

@immutable
sealed class GetPenugasanEvent {}

final class toggleGetPenugasanEvent extends GetPenugasanEvent {
  final int idPengaduan;

  toggleGetPenugasanEvent(this.idPengaduan);
}
